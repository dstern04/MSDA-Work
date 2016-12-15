'''
For this excerise, I first defined a helper function that returned the number of unique
permutations of a character string of length n. 

The 'permutations' function from the itertools package finds all of the permuations of the string, 
and we narrow those to the unique permuations by using the 'set' function. 

Rather than store all of the unique permuations of the subset of chacters of the original string,
the helper function only returns the length.

I then wrote a loop to perform this function for all of the subsets of characters of the original string
from length 1 to k, where k is the length of the original string.

The number of subset permutations for each length is then added to the variable 'perms'.


'''

import itertools

def uniquesubsets(string, n):
    return len(set(itertools.permutations(string, n)))

if __name__ == '__main__':

	word = 'BEE'
	''' 
		Convert string to lowercase, so mixed cases for the same letter do not add redundant permutations.
	'''
	word = word.lower()
	perms = 0
	''' 
		This loop perform functions for each subset of words of length i, We then add the length of each subset to 
		our running total, perms.
	'''
	for i in range(1,len(word)+1):
		perms += uniquesubsets(word,i)
	print(perms)