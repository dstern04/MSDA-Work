require(operators)

links <- read.csv("links.csv",header=TRUE)
movies <- read.csv("movies.csv",header=TRUE)
ratings <- read.csv("ratings.csv",header=TRUE)
tags <- read.csv("tags.csv",header=TRUE)

# A movie's mean rating.
# The top 10 movies by mean rating, with their mean, id number, and title.

require(plyr)
meanRatings <- aggregate(rating ~ movieId, ratings, mean)
joinedRatings <- join(meanRatings, movies, by = "movieId", type = "left")
reducedRatings <- joinedRatings[,3:1]
sortedRatings <- arrange(reducedRatings,-rating)
head(sortedRatings,10)

# A movie's number of ratings.
# The 10 movies with the most ratings, with their number of ratings, id number, and title.

numRatingsTable <- table(ratings$movieId)
numRatingsDF <- as.data.frame(numRatingsTable)
colnames(numRatingsDF) <- c("movieId","numRatings")
numRatingsSorted <- arrange(numRatingsDF,-numRatings)
tenMostRated <- head(numRatingsSorted,10)
tenMostRated <- join(tenMostRated, movies, by="movieId", type="left")
tenMostRated <- tenMostRated[,-4] # shed genre column
tenMostRated

# A movie's damped mean, with a damping term of 5.
# The top 10 movies by damped mean rating, with their damped mean, id number, and title.

globalMean <- mean(ratings$rating)
ratingSums <- aggregate(rating ~ movieId, ratings, sum)
ratingsByMovie <- join(ratingSums, numRatingsDF, by="movieId",type="left")
ratingsByMovie$dampedMean <- (ratingsByMovie$rating + 5*globalMean)/(ratingsByMovie$numRatings + 5)
ratingsByMovie <- arrange(ratingsByMovie,-dampedMean)
ratingsByMovie <- ratingsByMovie[,-2:-3] # drop columns
ratingsByMovie <- join(ratingsByMovie, movies, by="movieId", type="left") # add titles
ratingsByMovie <- ratingsByMovie[,-4] # drop genre column after join
head(ratingsByMovie,10)

# The similarity of one movie to another based on how likely the user is to rate one given that they 
# rated the other (ignoring the rating values), using the simple ((x ∧ y)/x) method.

# The 10 movies most similar to movie 1389 (Jaws 3-D) using the simple metric, with their 
# similarity scores, id number, and title.

# Here we need to calculate the 

subRatings <- ratings[,1:2]
#allUsers <- unique(subRatings$userId)
#movie1389ratings <- subset(ratings,movieId==1389)
#not1389Ratings <- subset(ratings,movieId!=1389)
usersWhoRated1389 <- unique(movie1389ratings$userId)
subRatings$rated1389 <- 0
subRatings$didntRate1389 <- 0

for (i in 1:nrow(subRatings)){
  if (subRatings[i,1] %in% usersWhoRated1389) #subMovies[i,1]  %in% usersWhoRated1389
  {
    subRatings[i,3] <- 1
    subRatings[i,4] <- 0
  }
    else
  {
    subRatings[i,3] <- 0
    subRatings[i,4] <- 1
  }
}

sumXY <- aggregate(rated1389 + notrated1389 ~ movieId, subRatings, sum)
sumXY$similarity1389 <- 0
sumXY$similarity1389 <- sumXY$rated1389/length(usersWhoRated1389)
sumXY <- arrange(sumXY,-rated1389)
sumXY <- join(sumXY, movies, by="movieId", type="left") 
sumXY <- sumXY[,c(1,3,4)] # drop unwanted columns

# Here we see that the most similar movie is Jaws 3D itself - a good indication that our formula worked.
# The next ten most similar movies are listed in descending order.

head(sumXY,11)

# recalculate sumXY with 1 in the denominator

sumXY <- aggregate(cbind(rated1389,didntRate1389) ~ movieId, subRatings, sum)
sumXY$similarity1389 <- 0
sumXY$dissimilarity1389 <- 0
sumXY$index <- 0
sumXY$similarity1389 <- sumXY$rated1389/(1+length(usersWhoRated1389))
sumXY$dissimilarity1389 <- (1+sumXY$didntRate1389)/(1+length(allUsers) - length(usersWhoRated1389))
sumXY$index <- sumXY$similarity1389/sumXY$dissimilarity1389

sumXY <- join(sumXY, movies, by="movieId", type="left") 
sumXY <- sumXY[,c(1,6,7)] # drop unwanted columns
sumXY <- arrange(sumXY,-index)
head(sumXY,11)


# The similarity of one movie to another, using the advanced ((x ∧ y)/x)/((!x ∧ y)/!x) method. 
# You may notice with this equation that under certain circumstances, you could end up dividing by zero. 
# To avoid this problem and be consistent in how we score movies, you'll need to add 1 to each of the
# three denominators in the expression for every movie. Your equation should now look like this: 
# ((x ∧ y)/(1 + x))/(1 + ((!x ∧ y)/(1 + !x))).
# The top movies by each of these scores. If there are any ties, rank them by their movieID, 
# from lowest to highest.

# The 10 movies most similar to movie 1389 (Jaws 3-D) using the advanced metric, with their 
# similarity scores, id number, and title
