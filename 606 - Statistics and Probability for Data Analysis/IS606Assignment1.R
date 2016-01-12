setwd("/Users/davidstern/Downloads")

allProbs <- function(x){
  text <- scan(x, character(0),quote=NULL)
  output <- tolower(gsub("[^[:alnum:][:space:]]", "", text))
  return(table(output)/length(output))
}
# Now we can run the function by specifying the text file:
allProbs("assign6.sample.txt")
# Let's make sure all the probabilities add up to 1:
sum(allProbs("assign6.sample.txt"))

twoWords <- function(doc,word1,word2){
    totals <- allProbs(doc)
    word1 <- as.character(word1)
    word2 <- as.character(word2)
    print(totals[word1])
    print(totals[word2])
  }

twoWords("assign6.sample.txt","the","for")

detectTwo <- function(doc,word1,word2){
  text <- scan(doc, character(0),quote=NULL)
  output <- tolower(gsub("[^[:alnum:][:space:]]", "", text))
  total <- table(output)/length(output)
  word1 <- as.character(word1)
  word2 <- as.character(word2)
  count <- 0
  for(i in 1:length(text)){
    if (output[i] == word1 && (output[i-1] == word2 || output[i+1] == word2))
    {
      count <- count + 1
    }
  }
  results <- as.matrix(c(totals[word1],totals[word2],count/length(text)),byrow=TRUE)
  rownames(results) <- c(word1,word2,"adjacency")
  print(t(results))
}

detectTwo("assign6.sample.txt","the","for")

