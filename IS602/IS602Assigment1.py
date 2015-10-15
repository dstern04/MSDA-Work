#1. 

def sortwithloops(input):
    length = len(input)
    for i in range(length):
        for k in range(i, length):
            if input[i] > input [k]:
                tempList = input[i]
                input[i] = input[k]
                input[k] = tempList
    return input

#2. 

def sortwithoutloops(input): 
    input.sort()
    return input 

#3. 

def searchwithloops(input, value):
    for i in input:
        if i == value:
            return "True"
    return "False"


#4. 

def searchwithoutloops(input, value):
    return value in input	

if __name__ == "__main__":	
    L = [5,3,6,3,13,5,6]	
    
    print sortwithloops(L) # [3, 3, 5, 5, 6, 6, 13]
    print sortwithoutloops(L) # [3, 3, 5, 5, 6, 6, 13]
    print searchwithloops(L, 5) #true
    print searchwithloops(L, 11) #false
    print searchwithoutloops(L, 5) #true
    print searchwithoutloops(L, 11) #false
