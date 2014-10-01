require(dplyr)
mtcars %>%
  group_by(cyl, am) %>%  #this will breakdown the dataset "mtcars" into groups of rows by the combinations of "cyl" and "am"
  summarize(
    avgMPG = mean(mpg, na.rm = TRUE), #this will create a new column, the average mpg for the group of cars
    avgWT = mean(wt, na.rm = TRUE) #this will create a new column, the average weight for the group of cars
  ) %>%
  filter(avgMPG > 20.0) #here I filtered the groups out by avgMPG