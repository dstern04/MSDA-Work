library(RCurl)
library(shiny)
setwd("/Users/davidstern/Github/MSDA-Work/IS608Week3-App")
mortData <- getURL(url)
mortData <- read.csv(textConnection(mortData))
mort2010 <- subset(mortData, Year == "2010")
causes <- unique(mort2010$ICD.Chapter)

shinyUI(pageWithSidebar(
  headerPanel("Cause of Death Frequency by State in 2010"),
  sidebarPanel(selectInput("State", "State: ", ),
  mainPanel(tableOutput('values')))

