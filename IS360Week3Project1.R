glut <- 20:40
#the minimum
whatismin <- function(vec){
  for(i in 1:length(vec)){
    theMin = Inf #We set this as infinite to begin with, so the first element will satisfy the 
    # 'less than' condition and initiate the reiterative loop
    if (vec[i] < theMin) 
    {theMin <- vec[i]} #This condition will redefine 'theMin' for every vec[i] if it is less than 
    # any of the preceding values. In the end, 'theMin' will be set to the lowest value
    # in the vector
    return(theMin)
  }
}
whatismin(glut)
#themaximum
whatismax <- function(vec){
  theMax = -Inf #We want to reverse the process above, so we set this to negative inifity to start
  for(i in 1:length(vec)){
    if (vec[i] > theMax){
    theMax <- vec[i]}
  }
    return(theMax)
}
whatismax(glut)
#the mean
whatismean <- function(vec){
  sumOfAll <- 0
  for(i in 1:length(vec)){
    sumOfAll <- sumOfAll + vec[i] #simply loop all of the values through a cummulative sum equation
    #sumOfAll must be set to 0 at the beginning of the loop, or else it will be a NaN
  }
  return(sumOfAll/length(vec)) #divide the total by the lengh of the vector (number of elements)
}
whatismean(glut)
#the median
whatismedian <- function(vec){
  vec <- sort(vec) #We need to sort the vector, so that the we do not pick an arbitrary element 
  # below that happens to be listed in the middle of the vector
  if(length(vec %% 2 == 1)){ #If the vector has an odd number of elements (n), we will want to find
    theMedian = vec[(length(vec)-1)/2 + 1]} # the middle value - subtract 1 from n, divide by 2, add 1 again
  else if(length(vec %% 2 == 0)){ #If the vector has an even number of elements, we will want to use
    theMedian = (vec[length(vec)/2] + vec[length(vec)/2 +1])/2} # this expression to average the 2 middle elements
  return(theMedian)
}
whatismedian(glut)
whatismedian(1:20)
#first quartile
whatisfirst <- function(vec){
  vec <- sort(vec) #We need to sort again, to make sure cut off the right proportion of the vector
  if(length(vec %% 2 == 1)){ #We will use the same format as whatismedian but cut it off at the 
    firstQ = vec[(length(vec)-1)/4 + 1]} #first quarter
  else if(length(vec %% 4 == 0)){ 
    firstQ = vec[length(vec)/4]}
  return(firstQ)
}
#third quartile
whatisthird <- function(vec){
  vec <- sort(vec) 
  if(length(vec %% 2 == 1)){  
    thirdQ = vec[(length(vec)-1)*0.75 + 1]} #same method as above, but multiply by 0.75
  else if(length(vec %% 4 == 0)){ 
    thirdQ = vec[length(vec)/4*0.75]}
  return(thirdQ)
}
whatismissing <- function(vec){
  totalmissing = 0
  for (i in 1:length(vec))
    { #without the use of is.na(), i - i will return all missing values NA, because all integers
      # subtracted by themselves will return 0
      # In R, NA - NA returns "NA"
    if (i - i != 0){ 
      totalmissing = totalmissing + 1
    }
    return(totalmissing)
  }
}
whatisdeviation <- function(vec){
  theMean <- whatismean(vec)
  sumofsqdif <- 0
  for (i in 1:length(vec)){
    sumofsqdif <- sumofsqdif + (vec[i]-theMean)*(vec[i]-theMean) # Since this problem uses a loop, the equation
    # must be split into several parts - sum can be reiterated, but not the division or sqrt
    stdev <- sqrt(sumofsqdif/(length(vec)-1))
  }
  return(stdev)
}
whatisdeviation(glut)
whatisdeviation2 <- function(vec){  #alternative solution, worse than the first, produces NaN
  theMean <- whatismean(vec)
  SumOfSquares <- 0
  for (i in 1:length(vec)){
    SumOfSquares <- SumOfSquares + i*i
    SquareOfSums <- theMean*theMean
    difOfSums <- (SumOfSquares - SquareOfSums/(length(vec)-1))/(length(vec))
    stdev <- sqrt(difOfSums)
  }
  return(difOfSums)
}
whatisdeviation2(glut) 
#produce the list
givemenumbers <- function(vec){
  usefullist <- NULL
  usefullist['min'] <- whatismin(vec)
  usefullist['max'] <- whatismax(vec)
  usefullist['mean'] <- whatismean(vec)
  usefullist['median'] <- whatismedian(vec)
  usefullist['first quartile'] <- whatisfirst(vec)
  usefullist['third quartile'] <- whatisthird(vec)
  usefullist['missing values'] <- whatismissing(vec)
  usefullist['standard deviation'] <- whatisdeviation(vec)
return(usefullist)
}