# 1. The count for "True" tells us how many numbers, from 1:1000, are not divisible by 3, 7 or 11
large <- 1:1000
table(ifelse(large%%3 != 0 & large%%7 != 0 & large%%11, "True", "False"))
# 2. 
sample3 <- c(3, 5, 4, 9, NA, NA, 10) #test vector
testna <- function(x)
{ print(sum(is.na(x)))
}
testna(sample3) #test
#3. 
x <- c(3, 4, 5, NA, NA, NA, 2, 2, 2, 3)
y <- c(2, 3, 4, 1, 2, NA, NA, NA, NA, NA)
z <- c(NA, NA, 2, 3, 2, 3, 2, 3, 2, 3)
baseball <- data.frame("H" = x, "RBI"= y, "BB" = z)
dfNA <- function(df)
{NAvector = NULL #Navector will return the vector of named NA counts
 for (i in 1:ncol(df)){ #using ncol(df) allows us to run the loop until the n'th column
   NAvector[colnames(df)[i]] = testna(baseball[i])}
 return(NAvector)}
dfNA(baseball)
