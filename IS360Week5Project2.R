# 1. Questions - (1) What percent of the total vote did each demographic represent - based on age group and location.
# (2) What was the outcome in each of the councils (Glasgow and Edinburgh)?
# (3) Who won?! (Based on total number of votes)
# 2.
c <- c("Yes", "No")
d <- c(80100, 35900)
e <- c(143000, 214800)
f <- c(99400, 43000)
g <- c(150400, 207000)
soupVote <- data.frame("Outcome" = c, "EdinU24" = d, "EdinO25" = e, "GlasU24" = f, "GlasO25" = g)
#3
require(tidyr)
require(dplyr)
soupVote %>%
  gather(Demo, Votes, EdinU24:GlasO25) %>%

