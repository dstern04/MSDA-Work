# 1. First we concatenate the 5 customers into one character vector
queue <- c("James", "Mary", "Steve", "Alex", "Patricia")
# 2. To add Harold, we need to redefine "queue" in terms of itself + "Harold"
queue <- c(queue, "Harold")
# 3. To reflect James checking out, we will again redefine the list in terms of itself, this time
# by eliminating the first element using [-1]
queue <- c(queue[-1])
# 4. We will reorder the vector by calling each customer by the number corresponding to their 
# location in the vector
queue <- queue[c(1,4,2,3,5)]
# 5. To show harold left we will reuse one of the above expressions
queue <- c(queue[-5])
# 6. We will now remove Alex fromt the queue by calling him by name, not by corresponding ordinal
queue <- queue[!(queue=="Alex")]
# 7. The match() expression will located the position of a particular element within a vector
match("Patricia", queue)
# 8. The length() expression will count the number of elements in the vector
length(queue)