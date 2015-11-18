import scipy.ndimage as ndimage
import scipy.misc as misc
import matplotlib.pyplot as plt
import numpy as np
import urllib
import pandas as pd
import Tkinter
import tkFileDialog

"""
# Objects Plot

objectsRaw = 'https://raw.githubusercontent.com/dstern04/MSDA-Work/master/IS602/objects.png'
photo = urllib.urlopen(objectsRaw)
objects = misc.imread(photo)
img = ndimage.gaussian_filter(objects,8)
thres = img > img.mean()
labs, count = ndimage.measurements.label(thres)
centers = ndimage.measurements.center_of_mass(thres, labs, range(1, count + 1))
plt.imshow(objects)
plt.scatter([each[1] for each in centers], [each[0] for each in centers],color='red')
plt.show()

# Cars Plot

carsRaw = 'https://raw.githubusercontent.com/dstern04/MSDA-Work/master/IS602/cars.data.csv'
carsCSV = urllib.urlopen(carsRaw)
carData = pd.read_csv(carsCSV)
carData.columns = ["buying", "maint","doors","persons","lug_boot","safety","class"]

priceFreq = carData['buying'].value_counts()
maintFreq = carData['maint'].value_counts()
safetyFreq = carData['safety'].value_counts()
doorsFreq = carData['doors'].value_counts()

plt.subplot(2, 2, 1)
priceFreq.plot(kind='bar')
plt.title('Frequency of Price Categories in Cars Data')
plt.xlabel('Price Levels')
plt.xticks(rotation='horizontal')

plt.subplot(2, 2, 2)
maintFreq.plot(kind='bar')
plt.title('Frequency of Maintenance Levels in Cars Data')
plt.xlabel('Maintenance Levels')
plt.xticks(rotation='horizontal')

plt.subplot(2, 2, 3)
safetyFreq.plot(kind='bar')
plt.title('Frequency of Safety Categories in Cars Data')
plt.xlabel('Safety Levels')
plt.xticks(rotation='horizontal')

plt.subplot(2, 2, 4)
doorsFreq.plot(kind='bar')
plt.title('Frequency of Door Counts in Cars Data')
plt.xlabel('Door Counts')
plt.xticks(rotation='horizontal')
plt.show()


# Brain/Body Plot

bbRaw = 'https://raw.githubusercontent.com/dstern04/MSDA-Work/master/IS602/brainandbody.csv'
bbData = urllib.urlopen(bbRaw)
bbDf = pd.read_csv(bbData)

a = -56.855545428596493
b = 0.90291294772870623

plt.plot(bbDf['brain'],b*bbDf['brain'] + a, color='red')
plt.scatter(bbDf['brain'],bbDf['body'])
plt.text(500, 4000, 'least squares fit: body = 0.903 x brain - 56.856', fontsize=12)
plt.title('Brain Mass vs. Body Size, with regression line')
plt.xlabel('Brain Mass')
plt.ylabel('Body Mass')
plt.ylim(ymin=0)
plt.xlim(xmin=0)
plt.show()

"""


