# 1. The count for "True" tells us how many numbers, from 1:1000, are not divisible by 3, 7 or 11
large <- 1:1000
table(ifelse(large%%3 != 0 & large%%7 != 0 & large%%11, "True", "False"))
# 2. This problem has a relatively simple solution
sample3 <- c(3, 5, 4, 9, NA, NA, 10)
sum(is.na(sample3))
 }
sum(is.na(fun1(baseball, "BB")))