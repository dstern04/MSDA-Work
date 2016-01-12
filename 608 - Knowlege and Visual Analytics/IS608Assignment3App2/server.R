library(RCurl)
library(shiny)
setwd("/Users/davidstern/Github/MSDA-Work/IS608Assignment3App2")
url <- "https://raw.githubusercontent.com/jlaurito/CUNY_IS608/master/lecture3/data/cleaned-cdc-mortality-1999-2010.csv"
mortData <- getURL(url)
mortData <- read.csv(textConnection(mortData))
causes <- unique(mortData$ICD.Chapter)
causes <- as.character(causes)
states <- unique(mortData$State)
states <- as.character(states)

shinyServer(function(input, output) {
  outputPlot <- function(){
    in_state <- input$states
    in_cause <- input$causes
    stateData <- subset(mortData, State==in_state & ICD.Chapter==in_cause, select=c(Year,ICD.Chapter,Crude.Rate,State))
    nationalData <- aggregate(cbind(Deaths, Population) ~ Year + ICD.Chapter, mortData, sum)
    nationalData["State"] = "National"
    nationalData <- transform(nationalData, Crude.Rate = Deaths*100000/Population)
    nationalData <- subset(nationalData, State==in_state & ICD.Chapter==in_cause, select=c(Year,ICD.Chapter,Crude.Rate,State))
    allData <- rbind(stateData,nationalData)
    statePlot <- ggplot(allData, aes(x=Year, y=Crude.Rate)) + 
      geom_line(aes(color=State)) + 
      xlab("Year") + 
      ylab("Crude Rate")                    
    print(statePlot)
  }
  output$values <- renderPlot(outputPlot())
})