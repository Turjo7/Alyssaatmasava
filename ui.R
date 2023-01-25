library(shiny)
library(shinydashboard)

dashboardPage(
  dashboardHeader(title = "Persons with Disabilities’ NGO suggestion system", titleWidth =  650),
  dashboardSidebar(
    #siderbarmenu
    sidebarMenu(
      id = "siderbar",
      menuItem(" Dataset", tabName = "data", icon = icon("database")),
      menuItem("Visualization", tabName = "viz", icon = icon("chart-line")),
      menuItem("Choropleth Map", tabName = "map", icon = icon("map")),
      menuItem("Location of NGOs", tabName = "test", icon = icon("map"))
    )
  ),
  dashboardBody(
    tabItems(
      #first tab item
      tabItem(tabName = "data",
              #tab box
              tabBox(id = "t1", width = 12,
                     tabPanel("About", icon = icon("address-card"), fluidRow(
                       column(width = 10, tags$img(src = "pic.jpeg", width =800, height = 300),
                              tags$br(), align = "right"),
                       column(width = 12, tags$br(),
                              p("This project is purposely designed for people, no matter 
                                     their status or age, who believe in spreading kindness. 
                                     It focuses on suggesting to its users a list of Non-Governmental 
                                     Organizations(NGO) that specifically cater to Persons with 
                                     Disabilities(PWD). Users will then have the ability to choose 
                                     suggested NGOs that best suit them according to their chosen 
                                     state. The suggestion process will be done after much 
                                     attentiveness in analyzing and exploring data sets of the number 
                                     of PWDs in each state of Malaysia."), align = "justify"
                              )
                     )),
                     tabPanel("Data of NGOs", icon = icon("address-card"), dataTableOutput("dataT")
                              ),
                     tabPanel("Data of PWDs", icon = icon("address-card"), dataTableOutput("dataPWD"))
                    )
              ),
      #second tab item
      tabItem(tabName = "viz",
              tabBox(id = "t2", width = 12,
                     tabPanel("Number of NGOs per State",br(), plotlyOutput("NGObar"), 
                              br(),br(),
                              fluidRow(tags$div(align = "center", box(tableOutput("top5"), title = textOutput("head1"), 
                                       collapsible = TRUE, status = "primary",  collapsed = TRUE, solidHeader = TRUE)),
                                       tags$div(align = "center", box(tableOutput("low5"), title = textOutput("head2"), 
                                       collapsible = TRUE, status = "primary",  collapsed = TRUE, solidHeader = TRUE)))),
                     
                     tabPanel("Number of newly registered PWDs per year according to state", br(),
                              solidHeader = TRUE, selectInput(inputId = "var1" , label ="Select the year", choices = c1),
                              plotlyOutput("barYear"), width = 8, 
                              br(),br(),
                              fluidRow(tags$div(align = "center", box(tableOutput("top5PWD"), title = textOutput("head3"), 
                                                                      collapsible = TRUE, status = "primary",  collapsed = TRUE, solidHeader = TRUE)),
                                       tags$div(align = "center", box(tableOutput("low5PWD"), title = textOutput("head4"), 
                                                                      collapsible = TRUE, status = "primary",  collapsed = TRUE, solidHeader = TRUE)))),
                     
                     tabPanel("Relation between number of NGOs and number of PWDs from 2017-2021", plotlyOutput("scatter"),
                              br(),
                              p("This is a Linear Regression model between the number of NGO in each state of Malaysia against the 
                                average number of PWDs from the years 2017-2021 in each state of Malaysia. The Linear Regression model shows a positive 
                                relationship, meaning that as the average number of PWDs in each state increases, the number of NGOs in each 
                                state also increases."
                              )),
                     )
              ),
      
      #third tab item
      tabItem(tabName = "map", h4(strong("Total Number of newly registered PWDs from 2017-2021 per State")),
              box(leafletOutput("chloromap", width = 1230, height = 500), width = 800, height = 525), 
              h4("Tip: Hover over the states to see the number of PWDs", style = "font-size:15px;")),
      
      
      
      #fourth tab item (TEST)
      
      tabItem(tabName = "test",
              selectInput("statesMY", label = "Select a state in Malaysia", choices = c("All States","Johor", "Kedah", "Kelantan", 
                                                                                        "Melaka", "Negeri Sembilan", "Pahang", 
                                                                                        "Penang","Perak", "Perlis", "Sabah", "Sarawak", 
                                                                                        "Selangor", "Terengganu")),
              box(leafletOutput("newmap", width = 1230, height = 500), width = 800, height = 525),
              dataTableOutput("dataNew")
      )
      
    
  
    )
  )
)