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
    averagePerPerson()
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
    for ()
  })

  averagePersons <- reactive ({
    v = c()
    d <- 5
    for (dorm in 1:d) {
      v[dorm] = mean(strtoi(recentData()[,dorm+1]))
    }
    return(v)
  })

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

  sumP <- ()

  sumPerPerson <- reactive ({

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
}
