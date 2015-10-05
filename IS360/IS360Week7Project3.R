# For this project, I decide to take a look at CitiBike's usage data for August 2014
# url: http://www.citibikenyc.com/system-data
setwd("/Users/davidstern/Documents")
bikeData <- read.csv("2014-08 - Citi Bike trip data.csv", header=TRUE)
dim(bikeData) #This is a massive dataset- almost 1 million observations of 15 variables
head(bikeData) 
# In my analysis, I am not very interested in the station names are the station coordinates,
# so I will narrow the dataframe
bikeData <- subset(bikeData, select = -c(5,6,7,9,10,11))
# First I want to look at which variables might be better recoded or binned.
# The trip duration is actually in seconds, so we will transform this column to minutes.
# (Citibike charges additional fees based on the number of minutes a user has a bike)
bikeData["tripduration"] <- round((bikeData$tripduration/60), digits=2)
# I used this crude method to reassign values. When I tried using transform(bikeData, tripduration = tripduration/60) 
# and mutate(bikeData, tripduration = tripduration/60), neither seemed to work.
# We might also consider recoding the "birth.year". I think it would be useful to transform this column
# into approximate age and also to create a column that bins the birth.years into generations, so we can see
# which groups take advantage of bike-sharing.
# First let's create a new column "generation" that duplicates birth.year
bikeData["generation"] <- as.numeric(as.character(bikeData$birth.year))
# Now, we will use variable recoding to bin birth.year by generation
attach(bikeData)
bikeData$generation[generation >= 1985] <- "Millenial"
bikeData$generation[generation > 1965 & generation < 1985] <- "Gen X"
bikeData$generation[generation <= 1965 & generation > 1945] <- "Greatest Gen"
bikeData$generation[generation <= 1945] <- "Silent Gen"
detach(bikeData)
# Let's take a quick look at breakdown by generation
table(bikeData$generation)
d <- table(bikeData$generation)
plot(d)
# Or use a pie chart
pie(d, labels=names(d))
# More than half of users are Gen X'ers, with Millenials taking just over 23%. To my suprise, the percentage of users
# that belong to the Greatest Generation are quite high, and there are even some Silent Gen riders!
# Next we should convert birth.year from factor to numeric
bikeData["birth.year"] <- 2014 - as.numeric(as.character(bikeData$birth.year))
colnames(bikeData)[8] <- "age"


plot(bikeData$usertype)
mean(bikeData$tripduration)
summary(bikeData$tripduration)