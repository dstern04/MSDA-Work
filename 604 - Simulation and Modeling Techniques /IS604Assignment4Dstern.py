# For this assignment, I will read in the text of a magazine article and pass it through the Alchemy API 
# to rank the keywords. First, we must read the text in from the html with the help of beautifulsoup.


import urllib
import bs4
from alchemyapi import AlchemyAPI


url = "http://www.theatlantic.com/magazine/archive/2015/09/the-coddling-of-the-american-mind/399356/" 
f = urllib.urlopen(url)
website = f.read()
soup = bs4.BeautifulSoup(website,'html.parser')
story = soup.find('div', {'class': 'article-body'}).getText()
story


# Now that we have the text of the article, we will pass it to the Alchemy API and print out the top 10 
# ranked words and their respective relevance.


alchemyapi = AlchemyAPI()
keywords = alchemyapi.keywords("text", story,{'maxRetrieve': 10})
i = 0 
for keyword in keywords[u'keywords']:
    i += 1
    print 'Rank:', i, '\t Relevance:', "\t %s \t %s" %(keyword['relevance'],keyword['text'])

