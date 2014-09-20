# 1 1. Obtain – Data Scientist should have advanced knowledge of where and how to procure large sets
#     of target data, including command-line programming skills that can automate the retrieval 
#     of complex sets of data.
#   2. Scrub – Perhaps the most labor intensive part of the cycle, data usually needs to be 
#     organized, reformatted, and transformed by the analyst into a manageable set of information
#   3. Explore – This is the stage for the analyst to familiarize oneself with the data. 
#     This can be done with a variety of methods, such as viewing different dimensions of the set 
#     and using basic tools like histograms and scatterplots.
#   4. Models – Different models may be applied to the set of data  - or subsets – to test 
#     their accuracy in relative terms.
#   5. Predictive power differs from interpretability in that the former relates to the 
#     quantitative accuracy of a model and the latter to the ability of a model to have 
#     qualitative output – knowledge that the modeler can take from the data
#2   I think it is better to have a well designed function interface, decently implemented, because
#    establishing the overall structure of the function - designating the linkages between the class
#    and the implementation will likely identify missing or poorly-written implementation when the 
#    code is run. It seems more difficult to identify disfunction with a "decent" interface, even
#    if it is well implemented.
#3 # I loaded the Chron and Lubridate packages
dayZero <- as.Date("2013-12-31")
today() - dayZero
#4 POSIXct stores datetime as the number of elapsed seconds since 1/1/1970. I would use POSIXct in
#  dataframes, because it applies a uniform format to datetime objects. POSIXlt is a stored 
#  POSIXlt stores datetime as a vector of some or all of the (seconds, minutes, hours, day of the month, 
#  month year). I would use POSIXlt if I wanted to extract and/or transform part of a datetime object, 
#  i.e. alter the day, and leave the rest the same.
#5 How long ago was Claude Shannon Born? 
# In days:
ShannonBorn <- as.Date("1916-04-30")
today() - ShannonBorn
#6
d <- c(01, 30, 12, 23, 23, 23, 12, 11)
m <- c(02, 03, 10, 12, 01, 04, 02, 04)
y <- c(2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011)
dfdates <- data.frame(m, d, y)
# first, use as.character to change the type of the numeric vectors, then concatenate with paste()
formatted <- as.Date(paste(as.character(y), as.character(m), as.character(d), sep = "-"))
dfdates[,"date"] <- formatted
str(dfdates)
#7
as.Date("06-30-1998", format = "%m-%d-%Y")
#8
date6 <- as.Date("06-30-1998", format = "%m-%d-%Y")
as.numeric(format(date6, "%m"))
#9
seq(from = as.Date("2005-01-01"), to = as.Date("2014-12-31"), by = 1)
#10
stringsAsFactors = FALSE