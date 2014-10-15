x1 <- c(10.0,8.0,13.0,9.0,11.0,14.0,6.0,4.0,12.0,7.0,5.0)
y1 <- c(8.04,6.95,7.58,8.81,8.33,9.96,7.24,4.26,10.84,4.82,5.68)
x2 <- c(10.0,8.0,13.0,9.0,11.0,14.0,6.0,4.0,12.0,7.0,5.0)
y2 <- c(9.14,8.14,8.74,8.77,9.26,8.10,6.13,3.10,9.13,7.26,4.74)
x3 <- c(10.0,8.0,13.0,9.0,11.0,14.0,6.0,4.0,12.0,7.0,5.0)
y3 <- c(7.46,6.77,12.74,7.11,7.81,8.84,6.08,5.39,8.15,6.42,5.73)
x4 <- c(8.0,8.0,8.0,8.0,8.0,8.0,8.0,19.0,8.0,8.0,8.0)
y4 <- c(6.58,5.76,7.71,8.84,8.47,7.04,5.25,12.50,5.56,7.91,6.89)
df1 <- data.frame(x1,y1)
df2 <- data.frame(x2,y2)
df3 <- data.frame(x3,y3)
df4 <- data.frame(x4,y4)
master <- data.frame(df1,df2,df3,df4)
#Let's get a brief overview of the stats. We can see that the mean and median are fairly stable among the 
sumStats <- as.data.frame(summary(master))
sumStats$Freq <- as.character(sumStats$Freq)
require(stringr)
interlist <- str_split(sumStats$Freq, ":")
require("plyr")
interdf <- ldply(list)
colnames(interdf) <- c("Stat", "Value")
sumStats <- cbind(sumStats, interdf)
sumStats <- sumStats[-c(1,3)]
colnames(sumStats)[1] <- "Variable"
# Now let's look at some non-graphic ways of visualizing the dataset
sumStats$Value <- as.numeric(sumStats$Value)
wideData <- reshape(sumStats, direction="wide", idvar="Variable", timevar="Stat")
# Let's add the Range and IQR of each set
wideData["Value.Range"] <- wideData$Value.Max - wideData$Value.Min
wideData["Value.IQR"] <- wideData["Value.3rd Qu."] - wideData["Value.1st Qu."]
# Now for visuals
require(ggplot2)
p1 <- ggplot(df1, aes(x=x1, y=y1)) + geom_line()
p2 <- ggplot(df2, aes(x=x2, y=y2)) + geom_line()
p3 <- ggplot(df3, aes(x=x3, y=y3)) + geom_line()
p4 <- ggplot(df4, aes(x=x4, y=y4)) + geom_line()
multiplot(p1, p2, p3, p4, cols=2)
# As we can see, the x and y have varyinr relationships in the datasets and the points in each dataframe seem
# to be treated as ordered pairs
# df1 demonstrates a positive, but very volatile correlation
# df2 is parabolic - the y value is positively correlated with the y value until it reaches a peak
# df3 demonstrates a steady positive correlation, with a spike in the highest quartile of ordered pairs
# df4 seems to have no correlation, as the x values remain the same for all values of y with the exception of one outlier
