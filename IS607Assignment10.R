library(XML)
theURL <- "http://en.wikipedia.org/wiki/List_of_countries_and_dependencies_by_population"
countryList <- readHTMLTable(theURL, which = 1, header = FALSE, stringsAsFactors = FALSE)
# 1. countryList will return as a data frame
head(countryList)
class(countryList)

# 2. Suppose instead you call readHTMLTable() with just the URL argument against the provided URL, as shown below
# To my suprise, readHTMLTable can actually read just the URL argument:
readHTMLTable("http://www.w3schools.com/html/html_tables.asp")
# This will return the same list:
theURL2 <- "http://www.w3schools.com/html/html_tables.asp"
hvalues <- readHTMLTable(theURL2)

# hvalues returns a list
class(hvalues)

# 3. Write R code that shows how many HTML tables are represented in hvalues
length(hvalues) # there are 6 HTML tables

# 4. Return the first table as a data frame
df <- readHTMLTable(theURL, which=1, as.data.frame=TRUE)
df

# 5. Return dataframe with only "Last Name" and "Points
df2 <- df[,3:4]
df2

# 6. I want to look at a websire with Labor Statistics.
CPI <- "http://www.bls.gov/cps/cpsaat22.htm"
CPItables <- readHTMLTable(CPI)

# 7. This page contains 2 tables
length(CPItables)

# 8. I use Google Chrome and I have the Chrome Extension "SelectorGadget" installed in order to 
# parse HTML code and click on elements for which I want to identify the selector.
