require(ggplot2)
require(plyr)

#1

SI <- read.csv("SI.csv")
QN <- read.csv("QN.csv")
MN <- read.csv("MN.csv")
BX <- read.csv("BX.csv")
BK <- read.csv("BK.csv")
NYC <- rbind(SI,QN,MN,BX,BK)
# For the exercises, we will want to use the cols "YearBuilt", "NumFloors" and "AssessTot".
# We will trim the other data to hopefully improve processing time in R
NYC <- NYC[,c("Borough","YearBuilt","NumFloors","AssessTot")]
# Now let's remove the data where there's no data for the building age or number of floors
NYC <- subset(NYC, NumFloors !=0, YearBuilt != 0)
ggplot(NYC, aes(x=YearBuilt)) + geom_histogram(binwidth=5)
# As we can see, there's very little data before 1890 and virtually none before 1850.
NYC <- subset(NYC, YearBuilt > 1850 & YearBuilt < 2016)
# Since we want to find when the time after which "most" buildings were constructed, we should look at a 
# histogram and bin the years in 5 year increments. We can draw a vertical line on the graph to demonstrate
# by which year only 20% of the city's buildings had been constructed.
ggplot(NYC, aes(x=YearBuilt)) + 
  geom_histogram(binwidth=5) +
  ggtitle("NYC Buildings - Year Constructed") +
  geom_vline(aes(xintercept=quantile(YearBuilt,0.20),color="orange")) + 
  scale_x_continuous(breaks=seq(1850,2020,10)) +
  theme(axis.text.x = element_text(angle=45))
# This graph shows us that 80% of buildings were built after 1920

# 2 We can see which buildins are unusually tall - they are the white boxes that "jump" much higher than the rest
ggplot(NYC, aes(x=YearBuilt,y=NumFloors)) +
  stat_bin2d(bins=110) +  # I chose 110 bins so that there is exactly one bin per floor/build year
  ylim(10,120) + # Every year, most buildings constructed are below 10 floors, so I start the ylim at 10
  xlim(1905,2015) +              
  scale_fill_gradient2() +
  ggtitle("NYC Buildings by Build Year and Number of Floors")


# We can also look at a scatterplot of max building heights by year:

maxHeight <- aggregate(NumFloors ~ YearBuilt, NYC, max)
maxHeight <- subset(maxHeight, YearBuilt >= 1905)
ggplot(maxHeight, aes(x=YearBuilt, y=NumFloors)) + 
  geom_point() +
  ggtitle("Max Building Height By Year")

# 3 First, we will add a column that has the assessed value per floor for each building.

NYC["ValuePerFloor"] <- NYC$AssessTot/NYC$NumFloors
valueByYear <- aggregate(ValuePerFloor  ~ YearBuilt, NYC, mean) # We will aggregate by mean

# This graph will look at the average Value/Floor by Year. We will draw Orange lines on the X-intercepts
# to indicate the beginning and end of WWII. It seems that the mean varies, with one outlier, one on average, 
# one year below average, and one year way above average.

ggplot(valueByYear, aes(x=YearBuilt, y=ValuePerFloor)) + 
  geom_point() +
  geom_vline(aes(xintercept = 1941), color="orange") +
  geom_vline(aes(xintercept = 1945), color="orange") +
  scale_x_continuous(breaks=seq(1850,2020,10)) +
  ggtitle("Mean Value/Floor by Year")

