library(rjson)
library(XML)

title <- c("Plenty","Mastering the Art of French Cooking","Balaboosta")
author <- c("Yolam Ottolenghi and Jonathan Lovekin","Julia Child","Einat Admony")
cuisine <- c("Vegetarian","French","Israeli")
yearPub <- c(2011,1961,2013)
ISBN <- c(1452101248,0375413405,1579655009)
cookBooks <- data.frame(title,author,cuisine,yearPub,ISBN)
cookBooks # view data frame
exportJson <- toJSON(cookBooks) # change to JSON format
exportJson # view JSON data



exportJSON <- "{\"title\":[\"Plenty\",\"Mastering the Art of French Cooking\",\"Balaboosta\"],
               \"author\":[\"Yolam Ottolenghi and Jonathan Lovekin\",\"Julia Child\",\"Einat Admony\"],
               \"cuisine\":[\"Vegetarian\",\"French\",\"Israeli\"],\"yearPub\":[2011,1961,2013],
                \"ISBN\":[1452101248,375413405,1579655009]}")
write(exportJson, "cookBooks.json") # create JSON file
json_data <- fromJSON(file="cookBooks.json") # now we read directly from the file
json_data #view
jsonDF <- data.frame(json_data$title,json_data$author,json_data$cuisine,json_data$yearPub,json_data$ISBN)
for (i in 1:length(jsonDF)){colnames(jsonDF)[i] <- names(json_data)[i]}

exportHTML <- "
<table>
  <tr>
  <th>title</th>
  <th>author</th>
  <th>cuisine</th>
  <th>yearPub</th>
  <th>ISBN</th>
  </tr>
  <tr>
  <td>Plenty</td>
  <td>Yolam Ottolenghi and Jonathan Lovekin</td>
  <td>Vegetarian</td>
  <td>2011</td>
  <td>1452101248</td>
  </tr>
  <tr>
  <td>Mastering the Art of French Cooking</td>
  <td>Julia Child</td>
  <td>French</td>
  <td>1961</td>
  <td>375413405</td>
  </tr>
  <tr>
  <td>Balaboost</td>
  <td>Einat Admony</td>
  <td>Israeli</td>
  <td>2013</td>
  <td>1579655009</td>
  </tr>
  </table>"
write(exportHTML, "cookBooks.html") # create HTML file
htmlDF <- readHTMLTable("cookBooks.html")
class(htmlDF) #returns as a list
htmlDF
htmlDF <- htmlDF$'NULL' # Now we have our data frame


exportXML <- "
<myLibrary>
  <book>
      <title>Plenty</title>
      <author>Yolam Ottolenghi</author>
      <author>Jonathan Lovekin</author>
      <cuisine>Vegetarian</cuisine>
      <yearPub>2011</yearPub> 
      <ISBN>1452101248</ISBN>
  </book>
  <book>
      <title>Mastering the Art of French Cooking</title>
      <author>Julia Child</author>
      <cuisine>French</cuisine>
      <yearPub>1961</yearPub> 
      <ISBN>375413405</ISBN>
  </book>
  <book>
      <title>Balaboosta</title>
      <author>Einat Admony</author>
      <cuisine>Israeli</cuisine> 
      <yearPub>2013</yearPub>
      <ISBN>1579655009</ISBN>
  </book>
</myLibrary>"
  
write(exportXML, "cookBooks.xml") # create XML file

# We will continue to use the XML package
xmlData <- xmlTreeParse("cookBooks.xml",useInternal=T)
ourRoot <- xmlRoot(xmlData)
xmlName(ourRoot) # identify parent node
names(ourRoot) # find its child nodes - this shows there are three books in myLibrary
# like a list, calling top[1] will return the first book
ourRoot[1]
# we could identify the child nodes for each books by calling names(top[[1])
names(ourRoot[[1]])
# We can built this dataframe by pulling the values one at a time:
title <- xpathApply(xmlData, "//title", xmlValue)
title <- as.character(title)
author <- xpathApply(xmlData, "//author", xmlValue)
author <- as.character(author)
cuisine <- xpathApply(xmlData, "//cuisine", xmlValue)
cuisine <- as.character(cuisine)
yearPub <- xpathApply(xmlData, "//yearPub", xmlValue)
yearPub <- as.character(yearPub)
ISBN <- xpathApply(xmlData, "//ISBN", xmlValue)
ISBN <- as.character(ISBN)

# We need to combine two authors in the "author" vector to reflect in our dataframe that "Plenty" was written by two individuals
author[1] <- paste(author[1],"and",author[2])
author <- author[-2]
xmlDF <- data.frame(title,author,cuisine,yearPub,ISBN)

Now we 

xmlDF
htmlDF
jsonDF



