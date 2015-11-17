__author__      = "David Stern"

import pandas as pd
import Tkinter
import tkFileDialog

root=Tkinter.Tk()
root.withdraw()
filename=tkFileDialog.askopenfilename(parent=root)

print 'The following lines will be excluded from the analysis: \n'

df = pd.read_csv(filename,sep='\s+', error_bad_lines=False, header=None,na_values="-")
df.columns = ['host','date','request','HTTP reply code','bytes']

print '\n Which hostname or IP address made the most requests? \n'
print df['host'].value_counts().head(1) 


print '\n Which hostname or IP address received the most total bytes from the server? How many bytes did it receive? \n'
print df.groupby('host').sum().sort('bytes',ascending=False).drop('HTTP reply code', axis=1).head(1)

print '\n During what hour was the server the busiest in terms of requests? \n'

df['date'] = pd.to_datetime(df['date'],format='[%d:%H:%M:%S]')
df['hour'] = df['date'].dt.hour

print df['hour'].value_counts().head(1)

print '\n Which .gif image was downloaded the most during the day? \n'

justGif = df[df['request'].str.contains('gif')]
print justGif['request'].value_counts().head(1)

print '\n What HTTP reply codes were sent other than 200? \n'

errors = df['HTTP reply code'].unique().tolist()
print errors[1:]

