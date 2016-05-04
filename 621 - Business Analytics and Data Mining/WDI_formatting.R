require(stringr)

setwd("/Users/davidstern/Downloads/WDI_csv")
wdi <- read.csv("WDI_Data.csv",header=T)

# model 1:

wdi_sub <- wdi[,-c(2:3)]
wdi_ts <- wdi_sub
wdi_ts$delta <- (wdi_ts[,"X2010"] - wdi_ts[,"X2000"])/wdi_ts[,"X2000"]
wdi_ts <- wdi_ts[,c("Country.Name","Indicator.Code","delta")]

# check % NA:

sum(is.na(wdi_ts$delta))/nrow(wdi_ts)

# model 2: 

wdi_long <- melt(wdi_sub,id.vars=c("Country.Name","Indicator.Code"),variable.name="Year",value.name="Value")
wdi_long$Year <- as.numeric(str_sub(wdi_long$Year,start=2,end=5)) # strip "X" from Year col