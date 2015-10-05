# (1) show a vector that contains 20 numbers
a <- c(1, 2, 4, 4, 5, 5, 8, 9, 10, 7, 15, 18, 19, 14, 13, 21, 20, 19, 18, 20)
# (2) converting vector "a" into a character vector
b <- as.character(a)
# (3) converting vector "a" into a vector of factors
c <- as.factor(a)
# (4) show how many levels are in the vector of factors
nlevels(as.factor(a))
# alternatively
nlevels(c)
# (5) perform the formula on the original vector
polyvector <- 3*a^2 - 4*a + 1
# (6) creating a named list
theAlist <- list(Max=1, Sam=2, Rex=3)
# (7) here I will create vectors for the dataframe, with 20 elements in each
# in order: numeric (x) character (y), factor (q), and date (dates)
x <- c(1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2)
y <- as.character(x)
q <- as.factor(x)
dates <- seq(as.Date("2014-08-01"), as.Date("2014-08-20"), by="days")
mydataframe <- data.frame(x, y, q, dates)
# (9) read the CSV
read.table(temperatures.csv)
# (10) to retrieve information that is not in the current working directory, one can specify the location
# of the desired document
read.table("c:\\documents\\david\\desktop\\criticaldataset.txt", header=TRUE, sep="\t")
# (11) retrieving a dataset from a website
read.table("http://www.amazingdata.com", header=True, sep="|")


