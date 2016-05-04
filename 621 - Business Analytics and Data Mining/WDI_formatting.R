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

# model 3 for plm package -> long -> wide:

  # choose predictors
edu_pred <- c("SL.AGR.0714.ZS","SL.MNF.0714.ZS","X.KLT.DINV.WD.GD.ZS","SE.PRM.UNER","SE.PRM.PRIV.ZS",
              "SP.POP.0014.TO.ZS","SP.POP.1564.TO.ZS","SE.XPD.TOTL.GD.ZS","BN.KLT.DINV.CD","SP.HOU.FEMA.ZS",
              "SE.XPD.CPRM.ZS","SH.HIV.0014","SL.TLF.0714.FE.ZS","SL.TLF.0714.MA.ZS","SG.GEN.LSOM.ZS",
              "SE.XPD.PRIM.PC.ZS","SE.PRE.ENRR","SE.PRE.ENRR.FE","SP.DYN.TFRT.IN","SE.PRM.TCAQ.ZS",
              "SE.PRM.ENRL.TC.ZS","SL.TLF.0714.ZS")
education <- subset(wdi, Indicator.Code %in% edu_pred)
              
education <- education[,-c(2,3)]
  # melt
edu_long <- melt(education,id.vars=c("Country.Name","Indicator.Code"),variable.name="Year")
edu_long$Year <- as.numeric(str_sub(edu_long$Year,start=2,end=5))
  # cast
edu_wide <- dcast(edu_long,Country.Name+Year~Indicator.Code,value.var="value")

# count NA

na_count <-sapply(edu_wide, function(y) sum(length(which(is.na(y)))))
na_count <- na_count*100/nrow(edu_wide)
na_count <- data.frame(na_count)
subset(na_count,na_count>0)

# fit model 

model1 <- plm(SE.PRM.UNER ~ SL.AGR.0714.ZS + SP.POP.0014.TO.ZS + SH.HIV.0014,edu_wide,model="pooling")
summary(model1)
