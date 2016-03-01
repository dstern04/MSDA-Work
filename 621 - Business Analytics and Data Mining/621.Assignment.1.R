library(ggplot2)
library(car)
library(leaps)
library(coefplot)

cig <- read.csv("cigarette-training-data.csv",header=T)
eval <- read.csv("cigarette-evaluation-data.csv",header=T)

# correlation matrix

cor(cig[-1])

# histograms and summary stats

hist(cig$Sales, breaks=20, xlab="Sales", main="Histogram of Cigarette Sales")
abline(v=115.55,col="red")
summary(cig$Sales)
hist(cig$Income, breaks=10, xlab="Income", main="Histogram of Income")
abline(v=3744.5,col="red")
summary(cig$Income)
hist(cig$Age, breaks=12, xlab="Age", main="Histogram of Age")
abline(v=27.5,col="red")
summary(cig$Age)
hist(cig$Price, breaks=12, xlab="Price", main="Histogram of Price")
abline(v=38.9,col="red")
summary(cig$Price)

cor(cig$Age,cig$Sales)
cor(cig$Income,cig$Sales)
cor(cig$Price,cig$Sales)

fitAge = lm(Sales~Age,cig)
fitIncome = lm(Sales~Income,cig)
fitPrice = lm(Sales~Price,cig)

# Simple Plots

par(mfrow=c(1,3))
plot(Sales~Age,cig,main="Sales by Age")
abline(a=-2.216,b=4.435,col="red")
plot(Sales~Income,cig,main="Sales by Income")
abline(a=50.86239,b=0.01835,col="red")
plot(Sales~Price,cig,main="Sales by Price")
abline(a=207.919,b=-2.298,col="red")

# Error Distributions

par(mfrow=c(1,3))
hist(summary(fitAge)$residuals,xlab="error",main="Hist of Error, Sales ~ Age",breaks=20)
hist(summary(fitIncome)$residuals,xlab="error",main="Hist of Errors, Sales ~ Income",breaks=20)
hist(summary(fitPrice)$residuals,xlab="error",main="Hist of Errors, Sales ~ Price",breaks=20)

# Plots of Square of residuals

par(mfrow=c(1,3))
plot(summary(fitAge)$residuals^2,ylab="Residual Squared",main="Sales ~ Age")
plot(summary(fitIncome)$residuals^2,ylab="Residual Squared",main="Sales ~ Income")
plot(summary(fitPrice)$residuals^2,ylab="Residual Squared",main="Sales ~ Price")

# Bucket Income data

cig$Income[cig$Income <= 3100] <- "2600-3100"
cig$Income[(cig$Income <= 3600) & (cig$Income >= 3100)] <- "3100-3600"
cig$Income[(cig$Income <= 4100) & (cig$Income >= 3600)] <- "3600-4100"
cig$Income[(cig$Income <= 4600) & (cig$Income >= 4100)] <- "4100-4600"
cig$Income[(cig$Income <= 5100) & (cig$Income >= 4600)] <- "4600-5100"

fitAll = lm(Sales~Age+Income+Price,cig)

plot(fitAll, which=1, col=as.numeric(factor(fitAll$model$Income)))
legend("topright", legend=levels(factor(fitAll$model$Income)),
        pch=1, col=as.numeric(factor(levels(factor(fitAll$model$Income)))), 
        text.col= as.numeric(factor(levels(factor(fitAll$model$Income)))), 
        title="Income Bracket")

plot(fit1, which=2)

# Reload data so Income is numeric and continous 

cig <- read.csv("cigarette-training-data.csv",header=T)

# Fit different models, "A" for Age, "I" for Income, "P" for Price in fit titles

fitAI= lm(Sales~Age+Income,cig)
fitAP= lm(Sales~Age+Price,cig)
fitPI= lm(Sales~Income+Price,cig)
fitA = fitAge
fitI = fitIncome
fitP = fitPrice
fitAPI = fitAll

# Try other variations:

fit1 = lm(formula = Sales ~ Age:Income + Price, data = cig)  # 1
fit2 = lm(formula = Sales ~ I(Price/Income), data = cig) # 3
fit3 = lm(formula = Sales ~ I(Price/Income) + I(Age^2), data = cig) #2
fitAllInteractions = lm(Sales~Age*Income*Price,cig) # all interactions

summary(fitAllInteractions) # repeat for all above
coefplot(fitAllInteractions)
BIC(fitAllInteractions)
vif(fitAllInteractions)

vif(fitAPI)

# BIC Plot

full <- regsubsets(Sales ~ Income+Age+Price, data = cig, nvmax = 10)
par(new=True)
plot(summary(full)$bic, xlab = "Number of Predictors", ylab = "BIC", type = "l",
     main = "Best Subset Selection Using BIC")


# Coefficients for full model:

fitAPI$coefficients

# Predict values of Evaluation Set

predict(fitAPI,eval)

mean((cig$Sales - predict(fitAPI, cig))^2) # Mean Predictor Error (test MSE) = 719.84
sd((cig$Sales - predict(fitAPI, cig))^2)/sqrt(46) # Standard Error = 384.1

hist(summary(fitAPI)$residuals,xlab="residual",main="Residual Plot, Sales ~ Age + Price + Income",breaks=20)

