library(RCurl)
library(shiny)
setwd("/Users/davidstern/Github/MSDA-Work/IS608Assignment3App1")
url <- "https://raw.githubusercontent.com/jlaurito/CUNY_IS608/master/lecture3/data/cleaned-cdc-mortality-1999-2010.csv"
mortData <- getURL(url)
mortData <- read.csv(textConnection(mortData))
mort2010 <- subset(mortData, Year == "2010")
causes <- unique(mort2010$ICD.Chapter)
causes <- as.character(causes)


shinyServer(function(input, output) {
  subsetAndOrder <- function(df){
    dfOut <- subset(df, 
            ICD.Chapter==input$causes,
            select=c('State','Deaths','Crude.Rate'))
    dfOut <- dfOut[order(-dfOut$Crude.Rate),]
    return(dfOut)
  }
  output$values <- renderTable(subsetAndOrder(mort2010))
})