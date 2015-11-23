
# coding: utf-8

# # Analysis of Enterococcus Levels in the Hudson

# In[1]:

import pandas as pd
import seaborn as sns
import re


# In[2]:

the_hudson = pd.read_csv('https://raw.githubusercontent.com/jlaurito/CUNY_IS608/master/lecture4/data/riverkeeper_data_2013.csv')


# In[3]:

the_hudson[15:22]


# In[4]:

the_hudson.describe()


# Here we will scrubs the EnterCount data of the greater than or less than symbols and then convert the data to numeric. This will avoid the creation of NA values. Values with the symbol prepending the number in the data will simply be converted to that number for convenience. e.g. "<1" becomes "1" and "2420" becomes "2420". 

# In[5]:

the_hudson['EnteroCount'] = the_hudson['EnteroCount'].astype(str)
the_hudson['EnteroCount'] = the_hudson['EnteroCount'].str.replace('>', '')
the_hudson['EnteroCount'] = the_hudson['EnteroCount'].str.replace('<', '')
the_hudson['EnteroCount'] = the_hudson['EnteroCount'].convert_objects(convert_numeric=True)


# Now we will convert the date column to class datetime. 

# In[6]:

the_hudson['Date'] = pd.Series([pd.to_datetime(x) for x in the_hudson['Date']])


# Now we will call a quick list of EnteroCount by average counts per site. This will give us a general sense of the best 
# and worst places to swim. It generally confirms what we would expect - up-river (or up-estuary) near Poughkeepsie is 
# the cleanest and the notorious Gowanus Canal is the worst.

# In[7]:

bysite = the_hudson['EnteroCount'].groupby(the_hudson['Site'])
meanCountBySite = bysite.mean()
meanCountBySite.sort()
meanCountBySite


# In[8]:

bysite.describe()


# In[9]:

bins = [0,110,24196]
safetyLevel = ['safe','unsafe']
Safety = pd.cut(the_hudson['EnteroCount'],bins,labels=safetyLevel)
the_hudson['Safety'] = Safety


# In[11]:

the_hudson[:6]


# In[ ]:




# In[ ]:




# In[ ]:




# In[ ]:




# In[ ]:




# In[ ]:




# In[ ]:



