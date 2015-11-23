setwd("/Users/davidstern/Documents")
carData <- read.table("auto-mpg.data",header=F)
colnames(carData) <- c("displacement", "horsepower", "weight", "acceleration", "mpg")