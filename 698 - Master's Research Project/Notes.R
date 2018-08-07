# test 2

# Euclidean Distance - simplest technique
x1 <- rnorm(30)
x2 <- rnorm(30)
Euc_dist = dist(rbind(x1,x2) ,method="euclidean")

# Cosine Distance - similarity measure between two vectors of an inner product space
vec1 = c( 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 )
vec2 = c( 0, 0, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0 )
library(lsa)
cosine(vec1,vec2)

# Pearson - basic correlation between two variables, as calculated by their covariance divided by 
# the product of their standard deviations

cor(mtcars, method="pearson")
cov(mtcars$mpg,mtcars$cyl)/(sd(mtcars$mpg)*sd(mtcars$cyl))

# "Empirical studies showed that Pearson coefficient outperformed other similarity measures for 
# user-based collaborative filtering recommender systems. The studies also show that Cosine similarity
# consistently performs well in item-based collaborative filtering."

# Principal component analysis is a classical statistical technique for dimensionality reduction. 
# The PCA algorithm transforms the data with high-dimensional space to a space with fewer dimensions.
# The algorithm linearly transforms m-dimensional input space to n-dimensional (n<m) output space, 
# with the objective to minimize the amount of information/variance lost by discarding (m-n) dimensions.
# PCA allows us to discard the variables/features that have less variance.

# Here the book provides a decent overview of PCA implementation in R, but falls short on the explanation
# and next step in dimensionality reduction

apply(USArrests, 2, var)

# Assault has the highest variance

# Scaling the features is a very step while applying PCA.
# Applying PCA after scaling the feature as below


# Clustering looks for patterns, does not need a response variable like regression analysis. 
# The different clustering methods are good for unsupervised learning methods. 
pca = prcomp(USArrests , scale =TRUE)
pca
