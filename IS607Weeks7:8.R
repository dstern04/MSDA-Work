require(tidyr)
require(dplyr)
# 1. Questions:
# (1) What percent of the total vote did each demographic represent - based on age group and location.
# (2) What was the outcome in each of the councils (Glasgow and Edinburgh)?
# (3) Who won?! (Based on total number of votes)
# 2.
c <- c("Yes", "No")  #I made 5 columns that each held two variables
d <- c(80100, 35900)
e <- c(143000, 214800)
f <- c(99400, 43000)
g <- c(150400, 207000)
soupVote <- data.frame("Outcome" = c, "Edin.U24" = d, "Edin.O25" = e, "Glas.U24" = f, "Glas.O25" = g)
#In the dataframe, I coded 16-24 as "U24" and 25+ as "O25"
#By doing so, I was able to integrate the umbrella (city) info in the age data
#3
soupVoteTidy <- soupVote %>%
  gather(Demo, Votes, Edin.U24:Glas.O25) %>%  
  # Here I consolidated the dataframe into a "Demo" column for city/age and another for the vote count
  separate(Demo, into = c("City", "Demo"), sep = "\\.") %>%
  # the separate function will split the age/city data into two columns 
  group_by(Outcome, Demo)
soupVoteTidy
#4
# Answer to Question 1
voteTotal <- sum(soupVoteTidy$Votes)
mutate(soupVoteTidy,
       Percentage = round((Votes/voteTotal)*100, digits = 2))
# Answer to Question 2
# The aggregate() function will allow us to designate the variables of interest
# and apply a sum function on the vote totals
aggregate(Votes ~ Outcome + City, soupVoteTidy, sum)
# Answer to Question 3
# The most important question- who won the vote?
aggregate(Votes ~ Outcome, soupVoteTidy, sum)
# After completing the exercises, I would have chosen the same questions, but I may
# have approached the solutions differently, perhaps to create functions that simply returned
# a specific "Yes/No/Numerical response to a question. On the other hand, many of these
# questions benefit from resized datasets, focused simply on the variables of interest. 
# I found questions 2 and 3 easy to answer with the aggregate function.
