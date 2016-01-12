# 1 
y <- 1
for(i in 1:12)
{ y <- i*y
}
print(y)
# 2 
# For this problem, I rearranged the compound interest equation. I first set y <- to the principal
# I then wrote the loop based on how many periods the interest would be compounded (72).
# I then took the annual interest rate (0.0324) as a decimal and converted into a monthly compound
# interest rate (0.0027). The loop iterates the increasing value of the principal through each of the 
# compounding periods
y <- 1500
for(i in 1:72)
{ y <- 1500*(1.0027)^i
}
round(y, digits = 2)
# 3 
# Sum every third element. I did this by using the seq() expression. I counted 
# every third element in the vector and made sure to start with the third element
# otherwise, the sequence would have counted every third element starting from 
# the first element
list <- 1:20
y <- sum(list[seq(3,length(list),3)])
print(y)
# 4. For this problem, I created a variable "returnsum" to be looped. It is 
# important to set returnsum <- 0 before running the loop, in order to initiate
# the first iteration
returnsum <- 0
for(i in 1:10)
{returnsum <- returnsum + (2^i)
}
returnsum #test
# 5 skip for now
# 6 For this problem, I used the do.call to specify an action(sum) that would be applied
# to a vector run through a function
list <- 1:10
returnsum2 <- function(x, func = sum)
{
  do.call(func, args = list(x))
}
returnsum2(2^list)
#7 
seq(20,50, by = 5)
#8 
rep(c("example"), each = 10)
#9 
#  For the quadratic equation, I created an expression to process the three
#  variables in tho different functions to account for the +/- branch in the
#  quadratic formula. I then returned a list of the two solutions for X.
quadeq <- function(a,b,c)
{  z1 = (-b + ((b^2)-(4*a*c))^0.5)/(2*a)
   z2 = (-b - ((b^2)-(4*a*c))^0.5)/(2*a)
   return(list(z1,z2))
}
quadeq(a = 1, b = 2, c = 1) #test the equation
#10 
list3 <- 1:30
calculatemean <- function(x)
{
  sum(x)/length(x)
}
calculatemean(list3) # test the function
# 11 
list4 <- c(7,8,NA,9) #first create a vector that contains NA
# The NA values have to be removed in different fashion for sum() and length()
# for sum(), I can use the logical operator na.rm. For length, I will calculate the
# length of the list and subtract the sum of is.na(), as the NA values will 
# each return a value of 1
calculatemean2 <- function(x)
{
  sum(x, na.rm=TRUE)/(length(list4)-sum(is.na(list4)))
}
calculatemean2(list4) #test
# 12
gcd <- function(x,y)
{r <- x%%y
 return(ifelse(r, gcd(y, r), y))
}
#13
polynomial <- function(x,y)
{((x^2)*y) + (2*x*y) - (x*(y^2))
}
polynomial(2,3) #test
