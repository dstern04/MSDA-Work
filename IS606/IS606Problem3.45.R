# We know that the there are 0.61 soldiers kicked per corps*year.
# If we graph the distribution in the book, we see that with n=10,000 years:

hist(rpois(10000,0.61),label=TRUE)

# Out of the 10,000 years, approximately 5400 will go by without a soldier being kicked by a horse (when x=0).
# Approximately 3300 years will include exactly one fatality, another 1000 years will include 2 fatalities, 
# and approx. 200 years will include 3 fatalities.

# We can change the probability and time frame to demonstrate the likeliness of a soldier being kicked.
# With 122 deaths over 20 years, we have 6.1 soldier deaths/year. To find the probability of a particular soldier
# being kicked, we divide 6.1 by the number of soldiers n. If there are 10000 than lamba = 0.00061.
# Here we simulate the chance of a particular soldier dying in a given year. We run the simulation 10000 times and 
# see that there are approx 6 years in 10000 where the soldier will be kicked to death. Thus, the chance of a soldier
# being lethally kicked by a horse in a given year = 6.1/(number of soldier). This graph differs from the first because
# we are looking at the distribution of probability of a fatality for a particular solider as oppposed to the 
# probability distribution of fatalities among the entire Prussian army.

hist(replicate(10000,sum(rpois(1,0.00061))),labels=TRUE)

