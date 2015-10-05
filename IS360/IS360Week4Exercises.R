#1
setwd("C:/Users/ds/Downloads")
makeModelData <- read.csv("week-4-make-model-data.csv")
priceData <- read.csv("week-4-price-data.csv")
combined <- merge(makeModelData,priceData)
# The combined dataframe has 27 observations in the results. I expected that there
# would be 28, as each of the model numbers in makeModelData corresponds to at 
# least one vehicle in priceData. There is however one vehicle ModelNumber (23120)
# that does not appear to be in makeModelData, so it was not included in the merged
# data frame. This seems to be a typo in the original datasource, as the ModelNumber
# (2312) does correspond to other vehicles
#2 
combined2 <- merge(makeModelData,priceData, all.y=T)
#3 
just2010 <- subset(combined2, Year==2010)
#4
justFancyReds <- subset(combined2, Price>10000 & Color=="Red")
#5
justFancyReds2 <- justFancyReds[, !(colnames(justFancyReds) %in% c("ModelNumber", "Color"))]
# This removes the columns by name, rather than by ordinal placement.
# This solution was more complicated, but prevents errors in case the dataframe
# happens to be re-cast 
#6 
countVonCount <- function(x){
  nchar(x)}
theCount <- c("is", "the", "best", "sesame", "street", "character")
countVonCount(theCount) #test