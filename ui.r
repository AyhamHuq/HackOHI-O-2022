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
      menuItem("Settings", tabName = "settings", icon = icon("cog")),
      menuItem("Other",tabName = "other")
    )
  )

body <- dashboardBody(
    tabItems(
      # Dashboard tab content
      tabItem(
            uiOutput("datedisplay"),
            tabName = "dashboard",
            uiOutput("comparer"),
            uiOutput("leaderboard"),
            uiOutput("factnocap"),
            uiOutput("plotout")
            
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
                choices = list("Busch House" = 2,"Taylor Tower" = 3,"Smith-Steebe" = 4,"Baker" = 5,"Morrill Tower" = 6)
            ),
            selectInput(
                "EneryType",
                label = "Choose the type of Energy:",
                choices = list("Electricity Consumption" = 2,"Total Energy Consumption" = 5)
            ),
            #Slider for the number of days
            sliderInput(
                "Slider", 
                label = h3("# of Days to Compile"), 
                min = 1, 
                max = 31, 
                value = 7
            )
        ),
        tabItem(
            tabName = "other"
        )
    ) 
)

ui <- dashboardPage(header,sidebar, body, skin = "red")
