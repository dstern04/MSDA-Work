library(ggmap)
setwd("/Users/davidstern/Downloads")
accidents <- read.csv("NYPD_Motor_Vehicle_Collisions.csv",header=T)
summary(accidents$BOROUGH) # I will have to find a way to include the 135k+ accidents that are missing a borough
justBrooklyn <- subset(accidents,BOROUGH == "BROOKLYN")
allCity <- get_map(location="New York City", source="google", maptype="roadmap", crop=FALSE)
ggmap(allCity)
brooklyn<- get_map(location="Brooklyn", source="google", maptype="roadmap", crop=FALSE,zoom=12)
ggmap(brooklyn) + stat_density2d(aes(x = LONGITUDE, y = LATITUDE,alpha=0.1), size = 0.1, 
                                  bins = 10,  
                                  data = justBrooklyn, 
                                  geom = "polygon", 
                                  colour = "red")
                