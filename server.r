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
    recentData()
  })

  #Extracts most recent hours that the user wants (returns bottom section of table uploaded)
  recentData <- reactive({
    # h <- 24*(input$Slider)
    # allData()[nrow(allData())-h:nrow(allData()), ]
    nrow(allData())
  })
}
