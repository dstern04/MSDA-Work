# 1. bowlPool is a data frame
# 2. If you call:
theURL <- "http://www.w3schools.com/html/html_tables.asp"
hvalues <- readHTMLTable(theURL)
#  You will receive an error the following error message:
#  "Error in seq.default(length = max(numEls)) : 
#  length must be non-negative number
#  In addition: Warning message:
#  In max(numEls) : no non-missing arguments to max; returning -Inf
# This error message appears because the webpage contains several tables and there is 
# no parameter in the call function to specify the tables. If you call the same functions 
# with the argument, header=FALSE, you will return a list of tables. 
hvalues <- readHTMLTable(theURL, header=FALSE)
hvalues
# 3. Count the number of tables in hvalues:
length(hvalues)
# We can test this by calling the individual tables
hvalues[7] # returns the last table on the webpage
hvalues[8] # returns NULL
# 4. Return the first table as a data frame
hvalues <- readHTMLTable(theURL, which=1, as.data.frame=TRUE)
# 5. Return dataframe with only "Last Name" and "Points
hvalues <- hvalues[,3:4]
# 6. I want to look at a websire with Consumer Price Indeces.
CPI <- "http://www.bls.gov/ro2/cpinynj.htm"
CPItables <- readHTMLTable(CPI)
# 7. This page contains 3 tables
length(CPItables)
# 8. I use Google Chrome and I have the Chrome Extension "SelectorGadget" installed in order to 
# parse HTML code and click on elements for which I want to identify the selector.