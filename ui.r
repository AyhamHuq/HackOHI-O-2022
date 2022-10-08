library(rsconnect)
library(shiny)
library(shinydashboard)
library(shinyWidgets)

header <- dashboardHeader(
    title = "Energy!!!!!!!"
)

sidebar <- dashboardSidebar(
    sidebarMenu(
      menuItem("Display", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Settings", tabName = "settings", icon = icon("cog"))
    )
  )

body <- dashboardBody(
    tabItems(
      # Dashboard tab content
      tabItem(
            tabName = "dashboard",
            box(
                textOutput("tableTest")
            )
        ),
      # Settings tab content
      tabItem(
            tabName = "settings",
            fileInput(
                inputId = "fileID",
                label = "Upload .csv file"
            ),
            #Dropdown menu items for clinet to choose which building to display the data for
            selectInput(
                "mydorm",
                label = "Choose your dorm:",
                choices = list("Busch House" = 1,"Taylor Tower" = 2,"Smith-Steebe" = 3,"Baker" = 4,"Morrill Tower" = 5)
            ),
            selectInput(
                "EneryType",
                label = "Choose the type of Energy:",
                choices = list("steam" = 1, "elec" = 2)
            ),
            #Slider for the number of days
            sliderInput(
                "Slider", 
                label = h3("# of Days to Compile"), 
                min = 1, 
                max = 31, 
                value = 7
            )
      )
    ) 
)

ui <- dashboardPage(header,sidebar, body, skin = "red")
