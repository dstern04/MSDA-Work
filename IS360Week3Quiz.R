# 1 comments
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