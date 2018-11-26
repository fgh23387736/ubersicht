# _*_ coding:utf-8 _*_
import urllib2
import json
from bs4 import BeautifulSoup
from lxml import etree
import re
import os
import sys

urls = {
	'hot':'https://www.guokr.com/scientific/channel/hot/',
	'frontier':'https://www.guokr.com/scientific/channel/frontier/',
	'viewpoint':'https://www.guokr.com/scientific/channel/viewpoint/',
	'biology':'https://www.guokr.com/scientific/subject/biology/',
	'psychology':'https://www.guokr.com/scientific/subject/psychology/',
	'internet':'https://www.guokr.com/scientific/subject/internet/'
}
url = "https://www.guokr.com/scientific/channel/hot/"
if len(sys.argv) > 1:
	url = urls[sys.argv[1]]
response = urllib2.urlopen(url)
htmlCode = response.read()
soup = BeautifulSoup(htmlCode, "lxml")
data = []
for tag in soup.find_all('',{'class':'article'}):
	temp = {}
	a = tag.select('a.article-title')[0]
	#print(a)
	temp['title'] = a.string
	temp['url'] = a['href']
	temp['img'] = tag.img['src']
	
	if not os.path.exists('guokr.widget/img'):
		os.makedirs('guokr.widget/img')

	if temp['img'] != None and not os.path.exists("guokr.widget/img/"+temp['img'].split('/')[-1]):
		img = urllib2.urlopen(temp['img'])
		f = open("guokr.widget/img/"+temp['img'].split('/')[-1], 'w')
		f.write(img.read())
		f.close()
	if temp['img'] != None :
		temp['img'] = "guoKr.widget/img/"+temp['img'].split('/')[-1]
	temp['describe'] = tag.select('p.article-summary')[0].string
	temp['time'] = tag.select('div.article-info')[0].get_text().split('|')[1].split('\n')[0]#re.sub("<[^>]*?>","",tag.select('div.article-info')[0].string)
	author = tag.select('a.article-author')
	if len(author) <= 0:
		
		author = tag.select('div.article-author-wramp')
		if len(author) > 0:
			temp['author'] = author[0].span.string
	else:
		temp['author'] = author[0].string
	#print(author)
	data.append(temp)
print(json.dumps(data))

