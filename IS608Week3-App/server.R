library(RCurl)
library(shiny)
url <- "https://raw.githubusercontent.com/jlaurito/CUNY_IS608/master/lecture3/data/cleaned-cdc-mortality-1999-2010.csv"
mortData <- getURL(url)
mortData <- read.csv(textConnection(mortData))
mort2010 <- subset(mortData, Year == "2010")


shinyServer(function(input, output) {
  
})