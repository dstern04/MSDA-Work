import Tkinter
import tkFileDialog
import pandas as pd

root=Tkinter.Tk()
root.withdraw()
filename=tkFileDialog.askopenfilename(parent=root)
print filename

carData = pd.read_csv(filename)
carData.columns = ["buying", "maint","doors","persons","lug_boot","safety","class"]

buying_values = ['vhigh','high','med', 'low']
maint_values = ['vhigh','high','med', 'low']
doors_values = ['2','3','4','5more']
persons_values = ['2','4','more']
lug_boot_values = ['small','med','big']
safety_values = ['low','med','high']
class_values = ['unacc','acc','good', 'vgood']

print "Testing for invalid data..."

if carData["buying"].any() not in buying_values:
    print("bad 'buying' value detected")
else:
    print("all 'buying' values are valid")
    
if carData["maint"].any() not in maint_values:
    print("bad 'maint' value detected")
else:
    print("all 'maint' values are valid")
    
if carData["doors"].any() not in doors_values:
    print("bad 'doors' value detected")
else:
    print("all 'doors' values are valid")
    
if carData["persons"].any() not in persons_values:
    print("bad 'persons' value detected")
else:
    print("all 'persons' values are valid")
    
if carData["lug_boot"].any() not in lug_boot_values:
    print("bad 'lug_boot' value detected")
else:
    print("all 'lug_boot' values are valid")
    
if carData["safety"].any() not in safety_values:
    print("bad 'safety' value detected")
else:
    print("all 'safety' values are valid")
    
if carData["class"].any() not in class_values:
    print("bad 'class' value detected")
else:
    print("all 'class' values are valid")

def func1(row):
    if row['safety'] == 'low':
        return 1
    elif row['safety'] == 'med':
        return 2 
    elif row['safety'] =='high':
        return 3
    else:
        return 'NA'

carData['safety_num'] = carData.apply(func1, axis=1)

print "These are the top 10 rows of the dataset sorted by 'safety' in descending order:"

print carData.sort(columns="safety_num", ascending = False).head(10)

def func2(row):
    if row['maint'] == 'low':
        return 1
    elif row['maint'] == 'med':
        return 2 
    elif row['maint'] =='high':
        return 3
    elif row['maint'] =='vhigh':
        return 4
    else:
        return 'NA'

carData['maint_num'] = carData.apply(func2, axis=1)

print "These are the bottom 15 rows of the dataset sorted by 'maint' in ascending order:"

print carData.sort(columns="maint_num", ascending = True).tail(15)
                    
print "Here all rows that are high or vhigh in fields 'buying', 'maint', and 'safety', sorted by 'doors' in ascending order:"

print carData[
    (carData.buying.str.match('(v.*|h.*)').str.len() > 0) & 
    (carData.maint.str.match('(v.*|h.*)').str.len() > 0) &
    (carData.safety.str.match('(h.*)').str.len() > 0)].sort(columns="doors", ascending = True)
    
print "Saving to a file all rows that are: 'buying': vhigh, 'maint': med, 'doors': 4, and 'persons': 4 or more."
print "This file is saved as 'output.csv' in the current directory"

subset = carData.query('buying == "vhigh" and maint == "med" and doors == "4" and (persons == "4" or persons == "more")')
print subset

subset.to_csv('output.csv')