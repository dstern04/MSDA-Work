library(boot)
setwd("/Users/davidstern/Documents")
carData <- read.table("auto-mpg.data",header=F)
colnames(carData) <- c("displacement", "horsepower", "weight", "acceleration", "mpg")

set.seed(562)
cv.err5 <- c()
for (i in 1:10){
glm.fit=glm(mpg~poly(displacement+horsepower+weight+acceleration,i), data=carData)
cv.err5[i] <- cv.glm(carData,glm.fit,K=5)$delta[1]
}
cv.err5
degree = 1:10
plot(degree,cv.err5,type='b',ylab="Cross Validation Error",xlab="Polynomial Degree")

