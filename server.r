library(rsconnect)
library(shiny)
library(shinydashboard)
library(shinyWidgets)


server <- function(input, output, session) {

  #uses file path to return a table of all the values
  allData <-reactive({
    req(input$fileID)
    filePath <- input$fileID$datapath
    arrayOfDorms <- read.csv(filePath)
    return(arrayOfDorms)
  })

  output$tableTest <- renderPrint({
    myOp()
  })

  averageOI <- reactive({
    c <- 6
    d <- 5
    dorm <- strtoi(input$mydorm)
    category <- strtoi(input$EneryType)
    i <- dorm + (d-dorm+1) + (dorm-1-1)*c+category
    return(mean(recentData()[,i]))
  })

  averagePerPerson <- reactive ({
    return(sumT()/sumP())
  })

  averagePersons <- reactive ({
    v = c()
    d <- 5
    for (dorm in 1:d) {
      v[dorm] = mean(strtoi(recentData()[,dorm+1]))
    }
    return(v)
  })

  sortedArrayOfAveragePerSumPerPersonsPerPeriod <- reactive ({
    copyOfSumPerPersons <- sumPerPerson()
    return (sort(copyOfSumPerPersons))
  })

#funFact <- function(kutb){
#joules = kutb*1054852.3206751
# 
#
#
#
#
#
#    
#}

myOp <- reactive({
  find <- sumPerPerson()[(strtoi(input$mydorm)-1)]
  for(i in 1:5){
    if(find > (sortedArrayOfAveragePerSumPerPersonsPerPeriod()[i] - .5) & find < (sortedArrayOfAveragePerSumPerPersonsPerPeriod()[i] + .5)){
        index <- i
        
    }
  }
  if(index == 1){
      return (2)
  }else{
    return ((index-1))
  }


})

  vyomsfunction <- function(position) {
    
    find <- sortedArrayOfAveragePerSumPerPersonsPerPeriod()[position]
    for(i in 1:5){
      if(find > (sumPerPerson()[i] - .5) & find < (sumPerPerson()[i] + .5)){
        nameIndex <- i+1
        
      }
        if(nameIndex == 2){
          return ("Busch House")
        }else if(nameIndex ==3){
          return ("Taylor Tower")
        }else if(nameIndex == 4){
          return ("Smith-Steebe")
        }else if(nameIndex == 5){
          return ("Baker")
        }else if(nameIndex == 6){
          return ("Morill Tower")
        }
    }
  }

  sumT <- reactive ({
    v <- c()
    c <- 6
    category <- strtoi(input$EneryType)
    d <- 5
    n <- 1
    for (dorm in 2:(d+1)) {
      i <- dorm + (d-dorm+1) + (dorm-1-1)*c+category
      v[n] = sum(recentData()[,i])
      n <- n+1
    }
    return(v)
  })

  sumP <- reactive({
    v = c()
    d <- 5
    for (dorm in 1:d) {
      v[dorm] = sum(strtoi(recentData()[,dorm+1]))
    }
    return(v)
  })

  sumPerPerson <- reactive ({
    h <- 24*(input$Slider)
    return(averagePerPerson()*h)
  })

  sumOI <- reactive({
    c <- 6
    d <- 5
    dorm <- strtoi(input$mydorm)
    category <- strtoi(input$EneryType)
    i <- dorm + (d-dorm+1) + (dorm-1-1)*c+category
    return(sum(recentData()[,i]))
  })

  #Extracts most recent hours that the user wants (returns bottom section of table uploaded)
  recentData <- reactive({
     h <- 24*(input$Slider)
     return(allData()[(nrow(allData())-h+1):nrow(allData()),])
  })

  dormNames <- c("Busch House", "Taylor Tower", "Smith-Steebe","Baker","Morrill Tower")
  catNames <- c("Steam Consumption", "Electricity Consumption" , "Chilled Water Consumption" , "Hot Water Consumption" , "Total Energy Consumption" , "Natural Gas Consumption" )

  output$comparer <- renderUI({
    fluidPage(
      uiOutput("you"),
      uiOutput("them")
    )
  })

  output$you <- renderUI({
    box(
      width = 6,
      title = paste0(dormNames[strtoi(input$mydorm)-1]),
      valueBoxOutput("v1"),
      valueBoxOutput("v2")
    )
  })

  output$them <- renderUI ({
    box(
      width = 6,
      title = paste0(dormNames[strtoi(myOp())]),
      valueBoxOutput("v3"),
      valueBoxOutput("v4")
    )
  })

  output$v1 <- renderValueBox ({
    valueBox(round(sumPerPerson()[strtoi(input$mydorm)-1],digits = 0), paste(catNames[strtoi(input$EneryType)],"per person(kBTU)"),color ="red")
  })

  output$v2 <- renderValueBox ({
    valueBox(round((averagePerPerson()[strtoi(input$mydorm)-1]*1000),digits = 0), "Your hourly consumption :( (BTU)",color ="red")
  })
  output$v3 <- renderValueBox ({
    valueBox(round(sumPerPerson()[strtoi(myOp())],digits = 0), paste(catNames[strtoi(input$EneryType)],"per person(kBTU)"),color ="red")
  })

  output$v4 <- renderValueBox ({
    valueBox(round((averagePerPerson()[strtoi(myOp())]*1000),digits = 0), "Their hourly consumption :( (BTU)",color ="red")
  })

  output$leaderboard <- renderUI({
    box(
      title = "Best Energy Savers",
      h1(paste(vyomsfunction(1)),round(sortedArrayOfAveragePerSumPerPersonsPerPeriod()[1],digits=0))
    )
  })
  
  output$factnocap <- renderUI ({
    box(
      h2(paste0("The difference between you and ",dormNames[strtoi(myOp())], " is",abs(-4)))
    )
  })
}
