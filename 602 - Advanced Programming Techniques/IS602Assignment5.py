
# David Stern


import csv
import urllib2
import pandas as pd

url = 'https://raw.githubusercontent.com/dstern04/MSDA-Work/master/IS602/brainandbody.csv'
response = urllib2.urlopen(url)
data = pd.read_csv(response)

print data


sumY = data.sum(axis=0)[1]
sumX = data.sum(axis=0)[2]
sumXY = (data["brain"]*data["body"]).sum()
sumX2 = (data["brain"]**2).sum()
meanX = data["brain"].mean()
meanY = data["body"].mean()
a = (sumY*sumX2-sumX*sumXY)/(len(data)*sumX2-sumX**2)
b = (sumXY - len(data)*meanX*meanY)/(sumX2 - len(data)*meanX**2)


print "The least squares fit for this data gives us the model:  body = ", b, "* brain ", a

