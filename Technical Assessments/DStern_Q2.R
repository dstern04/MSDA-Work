library(caret)
library(MASS)
library(leaps)

# load data 
data <- read.table("housing.txt")
colnames(data) <- c("CRIM","ZN","INDUS","CHAS","NOX","RM","AGE","DIS","RAD",
                    "TAX","PTRATIO","B","LSTAT","MEDV")

# randomly sort and split into training and test set (90:10)

set.seed(546)
data <- data[sample(1:nrow(data)), ]
training <- data[1:round(0.9*nrow(data),0),]
test <- data[(nrow(training)+1):nrow(data),1:13] # Test set without target, MEDV
test_target <- test <- data[(nrow(training)+1):nrow(data),14] # test, just MEDV

# examine correlations with target, MEDV (median housing prices)
cor(training)["MEDV",]

# check for missing values and measure proportion 
# it appears that there are no NAs in either set

na_count <-sapply(training, function(y) sum(length(which(is.na(y)))))
na_train <- na_count*100/nrow(training)
na_train <- data.frame(na_train)
na_train

na_count <-sapply(test, function(y) sum(length(which(is.na(y)))))
na_test <- na_count*100/nrow(test)
na_test <- data.frame(na_test)
na_test


# examine distributions by plotting histograms of all variables 

par(mfrow=c(2,4))
for (i in 1:8){
  hist(training[,i], breaks=20, xlab=colnames(training)[i],main=NA)
}

par(mfrow=c(2,3))
for (i in 9:14){
  hist(training[,i], breaks=20, xlab=colnames(training)[i],main=NA)
}


summary(training)
summary(training$MEDV)
table(training$CHAS)

pairs(training,col=training$MEDV)

# fit all predictors individually and plot error distributions

fitList <- list()

for(i in 1:13){
  fitName <- colnames(training)[i]
  fitList[[ fitName ]] <- lm(MEDV~training[,i],training)
}

# find best r-squared of single predictors

for (i in 1:length(fitList)){
  print(c(names(fitList)[i],summary(fitList[[i]])$r.squared))
}

# find optimal number of predictors 

full <- regsubsets(MEDV ~ ., training, nvmax = 15)
par(new=TRUE)
plot(summary(full)$bic, xlab = "Number of Predictors", ylab = "BIC", type = "l",
     main = "Best Subset Selection Using BIC")


# forward stepwise - returns 11 predictors 

fitAll <- lm(MEDV~.,training)
step <- stepAIC(fitAll,direction="both")
summary(step)


# best with max 3 predictors 
leaps <- regsubsets(MEDV~.,training,nvmax=3,method="forward")
summary(leaps)
fit1 <- lm(MEDV~LSTAT,training) # best of 1 
fit2 <- lm(MEDV~LSTAT+RM,training) # best of 2
fit3 <- lm(MEDV~LSTAT+RM+PTRATIO,training) # best of 3

# compare models 
summary(fit1)
summary(fit2)
summary(fit2)
anova(fit1,fit2,fit3,test="Chisq")
AIC(fit1,fit2,fit3)
BIC(fit1,fit2,fit3)
  
# accuracy test - Mean Absolute Error, Standard Error
mean(abs(test_target-predict(fit3,test)))
sd(abs(test_target-predict(fit3,test)))/sqrt(51)

