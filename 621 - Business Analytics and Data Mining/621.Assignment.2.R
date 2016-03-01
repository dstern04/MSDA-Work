library(psych)
library(car)
library(coefplot)

training <- read.csv("moneyball-training-data.csv", header=T)
evaluation <- read.csv("moneyball-evaluation-data.csv", header=T)
training <- training[,-1] # remove index

# plot histograms of all variables 

par(mfrow=c(2,4))
for (i in 1:8){
  hist(training[,i], breaks=20, xlab=colnames(training)[i],main=NA)
}

par(mfrow=c(2,4))
for (i in 9:16){
  hist(training[,i], breaks=20, xlab=colnames(training)[i],main=NA)
}

# summary stats
summary(training)

# pct of seasons with fewer than 60 losses or more than 102 wins

nrow(training[training$TARGET_WINS<60 | training$TARGET_WINS>102,])*100/nrow(training)

# examine strikeout outliers

subset(training,TEAM_PITCHING_SO>2500)

# delete from dataframe

training <- training[-c(1,282,1342,1826,2136),]

# fixed SO distribution

hist(training$TEAM_PITCHING_SO, breaks=20, main="Adjusted P_SO Distribution",xlab=NA)

# check for NA values and measure proportion

na_count <-sapply(training, function(y) sum(length(which(is.na(y)))))
na_pct <- na_count*100/nrow(training)
na_pct <- data.frame(na_pct)
na_pct

#next look at a correlation matrix

training <- training[,-10] # remove HBP
corrMatrix <- cor(training, use = "na.or.complete") 
#pVal <- corr.test(corrMatrix,y=NULL)
#pVal <- data.frame(pVal)
roundedCM <- round(corrMatrix,2)

# Fit all predictors individually and plot error distributions

fitList <- list()

par(mfrow=c(2,4))

for(i in 2:15){
  fitName <- colnames(training)[i]
  fitList[[ fitName ]] <- lm(TARGET_WINS~training[,i],training)
}

par(mfrow=c(2,4))
for (i in 2:9){
  hist(summary(fitList[[i]])$residuals,xlab="error",main=paste("WINS ~",names(fitList)[i-1]),breaks=20)
}

par(mfrow=c(1,5))
for (i in 10:14){
  hist(summary(fitList[[i]])$residuals,xlab="error",main=paste("WINS ~",names(fitList)[i-1]),breaks=20)
}


# Repeat for square of residuals to check for homoscedasticity 

par(mfrow=c(2,4))
for (i in 2:9){
  plot(summary(fitList[[i]])$residuals^2,ylab="Residual Squared",main=paste("WINS ~",names(fitList)[i-1]))
}

par(mfrow=c(1,5))
for (i in 10:14){
  plot(summary(fitList[[i]])$residuals^2,ylab="Residual Squared",main=paste("WINS ~",names(fitList)[i-1]))
}

# find best r-squared of single predictors
# high value is fitList[[1]]

for (i in 1:length(fitList)){
  print(summary(fitList[[i]])$r.squared)
}

fitAll <- lm(TARGET_WINS ~., training)
fitAll <- update(fitAll, . ~ . -TEAM_PITCHING_BB) #R-squared 0.4386
fitAll <- update(fitAll, . ~ . -TEAM_PITCHING_HR) #R-squared 0.4386
fitAll <- update(fitAll, . ~ . -TEAM_BATTING_SO) #R-squared 0.4384

summary(fitAll)$r.squared
summary(fitAll)$coefficients

# impute missing values

tmeans <- apply(training, 2, mean, na.rm=T)
tmedian <- apply(training, 2, mean, na.rm=T)
trainingImputed <- training
for (i in c(9,13,15)){
  for (j in 1:nrow(trainingImputed)){
    if (is.na(trainingImputed[j,i])){
      trainingImputed[j,i] <- tmeans[i]
    }
  }
}
for (i in c(7,8)){
  for (j in 1:nrow(trainingImputed)){
    if (is.na(trainingImputed[j,i])){
      trainingImputed[j,i] <- tmedian[i]
    }
  }
}

# backwards selection, model 2

fitAll2 <- lm(TARGET_WINS ~., trainingImputed)

summary(fitAll2)  #R-squared 0.3213, repeat for each

fitAll2 <- update(fitAll2, . ~ . -TEAM_PITCHING_HR) # R-squared 0.3212
fitAll2 <- update(fitAll2, . ~ . -TEAM_PITCHING_H) # R-squared 0.3211
fitAll2 <- update(fitAll2, . ~ . -TEAM_BASERUN_CS) # R-squared 0.3209

summary(fitAll2)$coefficients

# model 3 

trainingImputed2 <- trainingImputed
for (i in 2:15){
  for (j in 1:nrow(trainingImputed2)){
    if (trainingImputed2[j,i]==0){
      trainingImputed2[j,i] <- tmeans[i]
    }
  }
}

fitAll3 <- lm(TARGET_WINS ~., trainingImputed2) #R-squared 0.318
fitAll3 <- update(fitAll3, . ~ . -TEAM_BATTING_HR) #R-squared 0.318
fitAll3 <- update(fitAll3, . ~ . -TEAM_BASERUN_CS) #R-squared 0.318

# check variance inflations factors

vif(fitAll)
vif(fitAll2)
vif(fitAll3)

# BIC plot

full <- regsubsets(TARGET_WINS ~ ., training, nvmax = 15)
par(new=True)
plot(summary(full)$bic, xlab = "Number of Predictors", ylab = "BIC", type = "l",
     main = "Best Subset Selection Using BIC")

# predict evaluation set, format table in excel

predict(fitAll,evaluation,na.action = na.exclude,interval = "confidence")
predict(fitAll,evaluation,na.action = na.exclude,interval = "prediction")

# compare coefficients for all models

multiplot(fitAll,fitAll2,fitAll3)

# plot of residuals for fitAll

hist(summary(fitAll)$residuals,xlab="error",main="Histogram of fitAll Residuals",breaks=20)
