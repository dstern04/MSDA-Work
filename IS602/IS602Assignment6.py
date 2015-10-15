import timeit

setup = '''

import copy
import numpy as np

def sortwithloops(input):
    length = len(input)
    for i in range(length):
        for k in range(i, length):
            if input[i] > input [k]:
                tempList = input[i]
                input[i] = input[k]
                input[k] = tempList
    return input

def sortwithoutloops(input): 
    input.sort()
    return input  

def searchwithloops(input, value):
    for i in input:
        if i == value:
            return "True"
    return "False"

def searchwithoutloops(input, value):
    return value in input

def sortwithnumpy(input):
    return np.sort(input)	

def searchwithnumpy(input, value):
    return value in np.array(input)

L = [5,3,6,3,13,5,6]

''' 	

n = 10000
t = timeit.Timer("x = copy.copy(L); sortwithloops(x)", setup = setup)
print 'Sort with loops: ', n, 'loops takes ', t.timeit(n), 'seconds'
t = timeit.Timer("x = copy.copy(L); sortwithoutloops(x)", setup = setup)
print 'Sort without loops: ', n, 'loops takes ', t.timeit(n), 'seconds'
t = timeit.Timer("x = copy.copy(L); sortwithnumpy(x)", setup = setup)
print 'Sort with numpy: ', n, 'loops takes', t.timeit(n), 'seconds'
t = timeit.Timer("x = copy.copy(L); searchwithloops(x,13)", setup = setup)
print 'Search with loops: ', n, 'loops takes ', t.timeit(n), 'seconds'
t = timeit.Timer("x = copy.copy(L); searchwithoutloops(x,13)", setup = setup)
print 'Search without loops: ', n, 'loops takes ', t.timeit(n), 'seconds'
t = timeit.Timer("x = copy.copy(L); searchwithnumpy(x,13)", setup = setup)
print 'Search without numpy: ', n, 'loops takes ', t.timeit(n), 'seconds'
