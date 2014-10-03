# 1. The dataframe caith is a cross-classification of people by eye-color (rows) and hair color (columns).
# 2.
EyeColor <- rowSums(caith)
# EyeColor is the total number of eye colors acrosshair colors.  The variable "blue" contains
# all individuals who have blue eyes and wither fair, red, medium, dark, or black hair
# 3. 
HairColor <- colSums(caith)
# 4. # For this problem, a barplot is more appropriate than a histogram, as the data is qaulitative in nature
# Histograms are useful for continuous/qualitative data
barplot(EyeColor, main="Distribution of Eye Color")
# Medium is the most common eye color
# 5. 
caitha <- as.matrix(caith)
# This line of code turns the caith dataframe into a matrix
class(caitha)
# 6.
barplot(t(as.matrix(caith)))
# This line of code demonstrates the matrix of caith data as a barplot. Each of the bars represent the total
# number of datapoints within each eye color. The sections within each bar represent the 
# distribution of hair color within each eye color. From top (lightest color) to bottom 
# (darkest color), the sections represent <black, dark, medium, red, fair>
# 7.
# Here we use the beside=TRUE argument in order to split the stacked sections into adjacent bars
barplot(t(as.matrix(caith)), beside=TRUE)
# 8. IT appears that there is a correlation between eye color and hair color, as the hair colors occurs 
# in roughly equivalent relatively frequencies for each color of eye. The one exception being "fair" hair