library(RCurl)
library(shiny)
setwd("/Users/davidstern/Github/MSDA-Work/IS608Assignment3App1")
mortData <- getURL(url)
mortData <- read.csv(textConnection(mortData))
mort2010 <- subset(mortData, Year == "2010")
causes <- unique(mort2010$ICD.Chapter)
causes <- as.character(causes)

shinyUI(pageWithSidebar(
  headerPanel("Cause of Death frequency by State in 2010"),
  sidebarPanel(selectInput("causes", "Cause of Death: ", choices = causes),
               submitButton("Update View")),
  mainPanel(
    p("This feature will allow you to select a common cause of death and view a table of crude mortality rates by state.
       The crude rate describes the freqency of deaths as a proportion of the state's population. The table will be ordered in 
      decreasing order of rate."),
    tableOutput("values")))
)

