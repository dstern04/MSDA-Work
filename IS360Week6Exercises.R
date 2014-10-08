Bundestag <- read.csv("Bundestag2005.csv", header=TRUE)
Lander <- Bundestag$X  #Modify the dataframe to remove column of names and reattach as rownames
Bundestag <- Bundestag[2:6]
rownames(Bundestag) <- Lander
# The document that accompanies the Bundestag2005.csv only includes political parties that did
# not meet the threshold for representation in the Bundestag. The post-war constitution (Grundgesetz)
# bars parties that received less than 5% of the vote from parliamentary representation. This applies to 
# the national parliament (Bundestag) and to the regional parliaments (Landtag).
# The following expression will show us how many votes votes are included in the dataset
sum(Bundestag)
# The German government's voting website indicates that 48,044,134 citizens voted in the election
# Ref: http://www.bundeswahlleiter.de/de/bundestagswahlen/fruehere_bundestagswahlen/btw2005.html
# The following expression indicates the number of voters who casted ballots for "minor" parties
48044134 - sum(Bundestag) #Number of votes for minor parties
(48044134 - sum(Bundestag))*100/sum(Bundestag) #Percentage of votes for all minor parties
# A majority of the votes for minor parties were won by the extremist right-wing party, NPD
# I will add the number of NPD votes, by Land, to the Bundestag dataframe
# From above URL, dataset is "Ergebnis der Wahl zum 16. Deutschen Bundestag am 18. September 2005 nach Wahlkreisen.csv"
NPD <-  c(17497, 32944,	10135, 62313, 5513, 51389, 40324,	33508, 97166,	131718, 51499, 57464, 36481, 126059, 92847,	10920)
Bundestag["NPD"] <- NPD
require(plyr)
percentVote <- function(x) x*100/sum(x)
bundestagByLand <- as.data.frame(t(Bundestag))
voteByLandPct <- colwise(percentVote)(bundestagByLand) #For our analysis, it will be more useful to know the percentage of votes
# won by each party by region rather than the total by region
Partei <- c("SPD", "CDU.CSU", "Gruene", "FDP", "Linke", "NPD")
rownames(voteByLandPct) <- Partei
require(reshape2)
require(ggplot2)
voteByLandPct["Partei"] <- Partei
voteByLandPct.melt <- melt(voteByLandPct, id.vars='Partei')
qplot(x=voteByLandPct.melt$value, geom="histogram", binwidth=5,freq=FALSE, xlab="% Vote by Region", 
      ylab = "density", main = "Histogram of Percent Vote in a Region") +
        geom_vline(xintercept=5, color="red", linetype="dashed")
# This histogram shows the density of vote percentages that parties received in each Bundesland
# This information is valuable to political scientists who analyze the political stability in multiparty systems
# The dashed line represents the 5% threshold for representation. Even though this election was for the national 
# Parliament, we can see that a large proportion of votes by region falls under the 5% threshold. Political scientists
# would likely agree from this histogram that the threshold is largely serving its purpose - stabilizing politics
# in favor of the larger, moderate parties to avoid Weimar-era coalitions. Some political scientists may see the 
# proportion of votes in the 5-10% bin and argue that the threshold should be raised. Above 10%, the vote distribution
# seems to follow a symmetric, mound-shaped distribution.
# In this following boxplot, we are viewing the distribution of votes of the 6 parties in each Bundesland
# This is a useful measure, because ethe distribution of vote percentages is indicative of party dominance
# and coalition politics in each region
boxplot(voteByLandPct[1:16], las=2, ylab="% of Vote", main="Distribution of Vote Percentages by Region")
abline(h=5, col="red", lwd = 2)
abline(h=10, col="blue", lwd = 2)
abline(h=35, col="blue", lwd = 2)
# The shape of each region's boxplot tells us quite a bit:
# (1) I drew a red line at the threshold - 5%. Since there are 6 parties, a median at or lower than 5%
# tells us that half - or three - of the parties would be excluded from representation in that region's parliament
# (2) Regions with a very high skew happen to have legislatures that are ruled by absolute majority: 
# CDU.CSU in Bayern (Bavaria) and SPD in Bremen
# (3) Regions with a high median (near the 15% line) and very little skew are those with 
# vibrant coalition politics. Berlin, for example, has 4 parties over 10%, leading to a number of coalition possibilities
# (4) If the upper quartile is over 40%, it is likely that region is ruled by a grand coalition of the 
# SPD and CDU.CSU, as they each have a very large portion of the vote
boxplot(t(voteByLandPct[1:16]), las=2, ylab="% of Vote", xlab="Party", main="Distribution of Vote Percentages by Region")
abline(h=5, col="red", lwd = 2)
# This second boxplot shows the distribution of votes by political party. The SPD and CDU.CSU have much higher
# median and ranges than the other parties, because they are dominant forces in all regions.
# The FDP (pro-business) and NPD (right-extremist) parties have medians that hover around the threshold. 
# They tend to gain and then lose parliamentary representation frequently. The Linke (far-left) has a wide
# range as they are popular in former-GDR regions and unpopular in former-FRG regions. The outlier for 
# Gruene (green party) can be interpreted as growth potential. (Over the last decade, the median vote percentage did grow
# to the vote percentage of that outlier). For the small parties, a median at the threshold is a great achievement,
# as it indicates that they can gain parliamentary seats in half (8) of the regional parliaments. 
# For the NPD, success is defined by crossing the threshold in one region. Indeed, these instances of outliers always make the news!
plot(voteByPartyPct$Linke, voteByPartyPct$CDU.CSU, main="Scatterplot of Votes: Linke v. CDU.CSU by Region",
     xlab="% Vote Linke", ylab="% Vote CDU/CSU")
abline(lm(voteByPartyPct$CDU.CSU~voteByPartyPct$Linke), col="red")
# In this scatterplot, we can see that there is a loose negative correlation between votes for the Linke and the CDU/CSU
seatsWon <- c(226, 222, 51, 47, 54, 0)
# Now I will create a vector of the number of seats won by each party, in order of their appearance in the "Partei" vector
seatsWon <- c(226, 222, 51, 47, 54, 0)
# I will compare this by the total number of votes won by each party, irrespective of region
plot(rowSums(bundestagByLand), seatsWon, main="Vote Total vs. Seats Won by Party", xlab="Total Votes", ylab="Seats")
abline(lm(seatsWon~rowSums(bundestagByLand)), col="red")
# This is a pretty tight line, indicating a very representative democratic system. Why do some dots fall above the line 
# and some below? In Germany's electoral system, only half of the seats in the Bundestag are directly elected. The other
# half are appointed by political parties, based on their proportion of the vote on the second line of the ballot.
# The seats won by a party, therefore, are not exactly proportional to the vote total, but they are very close!
                               