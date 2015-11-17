__author__      = "David Stern"

import timeit

setup = '''
import csv
import urllib2
import pandas as pd
from scipy.optimize import curve_fit

url = 'https://raw.githubusercontent.com/dstern04/MSDA-Work/master/IS602/brainandbody.csv'

def leastsquares(rawCSV):
    response = urllib2.urlopen(rawCSV)
    data = pd.read_csv(response)
    sumY = data.sum(axis=0)[1]
    sumX = data.sum(axis=0)[2]
    sumXY = (data["brain"]*data["body"]).sum()
    sumX2 = (data["brain"]**2).sum()
    meanX = data["brain"].mean()
    meanY = data["body"].mean()
    a = (sumY*sumX2-sumX*sumXY)/(len(data)*sumX2-sumX**2)
    b = (sumXY - len(data)*meanX*meanY)/(sumX2 - len(data)*meanX**2)
    return a,b
    
def scipylr(rawCSV):
    response = urllib2.urlopen(url)
    data = pd.read_csv(response)
    xarray = data[[2]].values
    yarray = data[[1]].values
    x = []
    for each in xarray:
        x.append(each[0])
    y = []
    for each in yarray:
        y.append(each[0])
    popt, pcov = curve_fit(func, x, y)
    return popt[0],popt[1]

def func(x, a, b):
    return a * x + b
    
'''

n = 10
t = timeit.Timer("leastsquares(url)", setup = setup)
print 'Least Squares Regression: ', n, 'loops takes ', t.timeit(n), 'seconds'
t = timeit.Timer("scipylr(url)", setup = setup)
print 'SciPy Linear Regression: ', n, 'loops takes ', t.timeit(n), 'seconds'


