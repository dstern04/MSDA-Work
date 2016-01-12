require(RCurl)
require(ggplot2)
require(plyr)
url <- "https://raw.githubusercontent.com/jlaurito/CUNY_IS608/master/lecture1/data/inc5000_data.csv"
top5k <- getURL(url)
top5k <- read.csv(textConnection(top5k))
totals <- table(top5k$State)
totals <- as.data.frame(totals,stringsAsFactors=FALSE)
colnames(totals) <- c("State","Companies")
totals <- arrange(totals, desc(Companies))
figure1 <- ggplot(totals, aes(reorder(State, Companies), Companies))+ 
  geom_bar(stat="identity") + xlab("State")+
  ggtitle("Number of Companies Registered by State")+ 
  coord_flip()
figure1
# Since we have created a graph that identifies the States with the most companies, in descending order, we can easily identify
# NY as the state with the 4rd most companies
NYS <- subset(top5k, State=='NY') # create new dataframe with only NY companies
dim(NYS) 
# This will show us how many rows, or companies there are. We can verify that 311 is correct by checking with the previous graph
sum(complete.cases(NYS)) 
# We know that in R, TRUE has a value of 1, so if the sum of complete.cases(NYS) == 311, we know we have a full dataset
# To graph this data, I used boxplots to show the distribution of employees by industry.
# Although boxplots are good at showing distribution around the median, they do not show the mean. I used the stat_summary option to display the mean
# for each industry as a red circle. When I initially plotted the data the boxplots were very small, given the numerical outliers in the thousands.
# I decided to use coord_cartesian to "zoom" the graph so we could make sense of the boxplots without filtering the outliers from the data
# This way, we can exclude outliers from the graph but keep them in the calculation of the mean by industry.
# We can still still get a sense of which industries are skewed by outliers as the mean in these industries will lie far above the median.
figure2 <- ggplot(NYS, aes(x=Industry, y=Employees)) + 
  geom_boxplot() +
  stat_summary(fun.y=mean, geom="point", colour="red", shape=1, size=2) + 
  coord_cartesian(ylim=c(0,1000)) + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  ggtitle("Distribution of Employees by Industry in NYS")
figure2
# Let's first add a column that gives Revenue/Employee by Company
NYS <- mutate(NYS, RevPerEmployee = Revenue/Employees)
figure3 <- figure2 <- ggplot(NYS, aes(x=Industry, y=RevPerEmployee)) + 
  geom_boxplot() +
  stat_summary(fun.y=mean, geom="point", colour="red", shape=1, size=2) + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  ggtitle("Distribution of Revenue/Employee by Industry in NYS")
figure3
# By looking at the graph, we can see there are very few datapoints above $2,500,000 on the y-axis. 
# Here, we will again "zoom" in by setting ylim = 2500000
figure3 <- figure2 <- ggplot(NYS, aes(x=Industry, y=RevPerEmployee)) + 
  geom_boxplot() +
  stat_summary(fun.y=mean, geom="point", colour="red", shape=1, size=2) +
  coord_cartesian(ylim=c(0,2500000)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  ggtitle("Distribution of Revenue/Employee by Industry in NYS")
figure3
# If I was an investor, I would analyze which industries generate the most revenue/employee by comparing 
# like factors (comparing the median between industries, the means, or uper quartiles). A shrewd investor might look
# at the outliers to determine the maximum potential of revenue/employee for an industry, or analyze the skew and distribition 
# of revenue/employee to analyze how competitve an industry is.
# Judging by figure 3, I would determine Logistics & Transportation to be the industry with the highest revenue per employee.
# It has the highest median, average, and outliers of all industries.