# Project 1

# Write a function that takes a numeric vector as input and uses it to determine 
# the minimum, the maximum, the mean, the median, the first quartile, 
# the third quartile, the standard deviation of the vector, 
# and the number of missing values. 

# Do not use any built-in functions to do this. 
# Return a named list with the eight desired values in an order you deem best.

# built in functions that were used - is.na(), sqrt(), sort()

calc_min = function (vec) {
  # find the min value of a vector
  current_min = Inf
  for (i in 1:length(vec)) {
    if (!is.na(vec[i]) & vec[i] < current_min) {
      current_min = vec[i]
    }
  }
  return(current_min)
}

calc_max = function (vec) {
  # find the max value of a vector  
  current_max = -Inf
  for (i in 1:length(vec)) {
    if (!is.na(vec[i]) & vec[i] > current_max) {
      current_max = vec[i]
    }
  }
  return(current_max)
}

calc_missing = function(vec) {
  # find the number of missing values in a vector
  n_missing = 0
  for (i in 1:length(vec)) {
    if (is.na(vec[i])  ) {
      n_missing = n_missing + 1
    }
  }
  return (n_missing)
}

calc_mean = function(vec) {
  # find the mean of a vector
  total = 0
  n = 0
  for (i in 1:length(vec)) {
    if (!is.na(vec[i])) {
      total = total + vec[i]
      n = n +1
    }
  avg = total / n  
  }
  return(avg)
  
}

calc_std_dev = function(vec) {
  # find the standard deviation of a vector
  
  square_diff = 0
  avg = calc_mean(vec)
  n_good = length(vec) - calc_missing(vec) 
  for (i in 1:length(vec)) {
    if (!is.na(vec[i])) {
      square_diff = square_diff + (vec[i] - avg)^2
    }
  }
  
  # can use n or n-1 depending on which std dev definition you use
  variance = square_diff / (n_good-1) # same as R sd function
  std_dev = sqrt(variance)
  return(std_dev)
}


calc_median = function(vec) {
  # find the median of a vector
  
  # you dont have to write your own sort routine
  vec = sort(vec) # eliminates NAs as a side effect
  
  if (length(vec) == 1) {
    med = vec[1]  
  }
  else if (length(vec) %% 2 == 1) {
    # if odd number then pick the middle value
    med = vec[ceiling(length(vec)/2)] # round up
  } 
  else {
    # if even compute average of middle 2 numbers
    n = ceiling(length(vec)/2)
    med = (vec[n] + vec[n+1]) /2 
  }

  return (med)  
}

calc_quartile= function(vec,quartile) {
  # find the quartile (1st,2nd, or 3rd) of a vector
  
  vec = sort(vec) # sort and get rid of NAs
  med = calc_median(vec)
  
  # can find 1st or 3rd quartile simply by taking median of upper or lower half of data
  # http://en.wikipedia.org/wiki/Quartile
  # method 1, split data, do not include median
  
  if (quartile == 1) {
    vec_half = vec[vec < med]
    q = calc_median(vec_half)
  }
  else if (quartile == 2) {
    q = med # 2nd quartile is just the median
  }
  else if (quartile == 3) {
    vec_half = vec[vec > med]
    q = calc_median(vec_half)
  }
  return (q)
}


vector_stats = function(vec) {
  # compute various descriptive stats of a vector
  # min, max, num missing, mean, median, standard deviation, 1st and 3rd quartile
  
  stats_list = NULL

  # minimum
  stats_list['min'] = calc_min(vec)
  
  # maximum
  stats_list['max'] = calc_max(vec)
  
  # missing values
  stats_list['missing'] = calc_missing(vec)
  
  # mean
  stats_list['mean'] = calc_mean(vec)
  
  # standard deviation
  stats_list['std dev'] = calc_std_dev(vec)
  
  # median = 2nd quartile
  stats_list['median'] = calc_median(vec)
  # 1st and 3rd quartile
  
  # 1st and 3rd quartiles
  stats_list['q1'] = calc_quartile(vec,1)
  stats_list['q3'] = calc_quartile(vec,3)
  
  return (stats_list)
}

# run example 
vec = c(-10:29, NA)
stats = vector_stats(vec)
print (stats)
