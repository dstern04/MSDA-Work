To calculate the Expected Value of X, based on a set of values and their probability distribution, we will build
a function that takes in a dataframe, that should contain the values and the respective probabilities.
We should construct any input as a two-column data frame. 

First, let's construct a function that sums the all of the outcomes by their respective probabilities:

EofX <- function(df){
  sum <- 0
  for (i in 1:nrow(df)){
    sum <- sum + df[i,1]*df[i,2]
  }
  print(sum/nrow(df))
}

Now we can test the function with a carefully constructed probability distribution. We must make sure that \
(1) each output has a corresponding probability and (2) all of the probabilities add up to 1.

outcomes <- c(3,5,7,2,2,2,5,7,8,9)
values <- c(0.05,0.10,0.01,0.09,0.20,0.02,0.03,0.30,0.01,0.19)
length(outcomes) == length(values) # Check that they are the same length
sum(values) # Check that they add up to one
probDist <- as.data.frame(cbind(outcomes,values))
probDist

stored <- vector(mode="numeric", length=0) #initialize the vector of stored values
stats <- function(x){
  stored <<- c(stored,x) # here we use the <<- "superassignment" operator to store in the parent environment
    return(list(ExpectedValue = mean(stored),StandardDeviation = sd(stored)))
}
stats(g)


rm(stored) # Clears previous data



