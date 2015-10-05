require(plyr)
LosAngeles <- c(497,62,694,117)
Phoenix <- c(221,12,4840,415)
SanDiego <- c(212,20,383,65)
SanFrancisco <- c(503,102,320,129)
Seattle <- c(1841,305,201,61)
flights <- data.frame(LosAngeles,Phoenix,SanDiego,SanFrancisco,Seattle)
rownames(flights)<- c("AlaskaOnTime", "AlaskaDelay", "AmWestOnTime", "AmWestDelay")
# Add columns, but first we must transpose the df
flights <- t(flights)
flights[,2]*100/(flights[,1]+flights[,2]) # Alaska Delays by Airport
mean(flights[,2]*100/(flights[,1]+flights[,2])) # Average Alaska Delay, calculated by airport
sum(flights[,2])/(sum(flights[,1])+sum(flights[,2]))*100 # Average Alaska Delay = sum(delays)/(sum(delays)+sum(on-time))
flights[,4]*100/(flights[,3]+flights[,4]) # AmWest Delays by Airport
mean(flights[,4]*100/(flights[,3]+flights[,4])) # Average AmWest Delay, calculated by airport
sum(flights[,4])/(sum(flights[,3])+sum(flights[,4]))*100 # Average AmWest Delay = sum(delays)/(sum(delays)+sum(on-time))


