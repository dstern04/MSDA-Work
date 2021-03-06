A <- matrix(c(0,0.5,0.5,0,0,0,
              0,0,1,0,0,0,
              0.25,0.25,0,0,0.25,0.25,
              0,0,0,0,0.5,0.5,
              0,0,0,0.5,0,0.5,
              0,0,0.5,0.5,0,0),ncol=6)
A
# To model Decay, we set B = d x A + (1 - d)/n
# When decay (d) = 0.85
B <- 0.85*A + 0.15/6
B
# Now we will create the uniform rank vector
r <- matrix(rep(1/6,6))
# We will require the "expm" package to access matrix exponation. In this function, we will perform power iterations 
# on matrix B until the ranks converge. We will structure this function to test equality between B^i and B^(i+1).
# For simplicity, we will test equality of the first 8 decimal places of the 6 values in the the two ranks.
# When all 6 of the values are equal, the sum of the equality will equal 6 and the loop will break. We will then be 
# able to print the value of i at which the ranks begin to converge.
suppressWarnings(suppressMessages(library(expm)))
for (i in 1:100){
  if (sum(round((B %^% i) %*% r,8) == round((B %^% (i+1)) %*% r,8))!=6)
    {
      next
    }
  else
    {
      break
    }
}
print(i)
# To visualize the convergence, we can print (B %^% i) %*% r for i = 22,23,24,25
(B %^% 23) %*% r
(B %^% 24) %*% r
(B %^% 25) %*% r
# This shows that we see convergence to four decimal places starting as early as the 12th iteration:
(B %^% 12) %*% r
# And convergence to decimal places at the 7th iteration:
(B %^% 7) %*% r
# This will return the Eigenvalues of matrix A
eigenValues <- as.numeric(eigen(B)$values)
eigenVector <- matrix(as.numeric(eigen(B)$vectors[,1],nrow=6,byrow=6))
# And this will confirm that the largest EigenValue is 1. Since the eigen function returns the eigenvalues in 
# decreasing order, we can call the first element to find the max
eigenValues[1]
max(eigenValues)
# Now we will look at the corresponding eigenvector, rescaled by the sum of its elements:
eigenVector <- eigenVector/sum(eigenVector)
eigenVector
# We see that it is the same as our rank:
(B %^% 23) %*% r
eigenVector > 0 # test that all entries are positive
sum(eigenVector) # test that they sum to 1
suppressWarnings(suppressMessages(library(igraph)))
# Now we will use the igraph package to show the links between websites and to demonstrate that the page.rank
# function will return the same PageRank vector as above.
webLinks <- data.frame(fromSite=c(1,1,2,3,3,3,3,4,4,5,5,6,6), toSite=c(2,3,3,1,2,5,6,5,6,4,6,3,4))
webGraph <- graph.data.frame(webLinks)
plot(webGraph)
matrix(page.rank(webGraph)$vector,nrow=6)
