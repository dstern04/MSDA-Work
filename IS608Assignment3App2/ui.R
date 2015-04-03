library(RCurl)
library(shiny)
library(ggplot2)
setwd("/Users/davidstern/Github/MSDA-Work/IS608Assignment3App2")
mortData <- getURL(url)
mortData <- read.csv(textConnection(mortData))
causes <- unique(mortData$ICD.Chapter)
causes <- as.character(causes)
states <- unique(mortData$State)
states <- as.character(states)
states[52] <- "National"

shinyUI(pageWithSidebar(
  titlePanel("Crude Mortality Rates, State vs. National comparison, 1999-2010"),
  sidebarPanel(selectInput("causes", "Cause of Death: ", choices = causes),
               selectInput("states", "State: ", choices = states, multiple=TRUE),
               submitButton("Update View")),
  mainPanel(
    p("This feature will allow you to select a common cause of death and a state in order to compare 
      a state's crude mortality rate, by cause of death, with the national rate. The rate is calculated as 
      the number of related mortalities per 100,000 people."),
    p("From the menu, you can select more than one state to compare the rates. At the end of the list, you may 
      select 'National' to compare states to the national average"),
    plotOutput("values"))))

