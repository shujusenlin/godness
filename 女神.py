# -*- coding: utf-8 -*-
"""
Created on Thu Dec 13 23:35:17 2018

@author: Administrator
"""
import json
import requests
from bs4 import BeautifulSoup
import pandas as pd
import re
import os
os.chdir('D:/爬虫/女神')

id_list = []
title_list = []
pic_list = []
date_list=[]

for i in range(1,6):
    url= 'http://api.dongqiudi.com/search?keywords=%E5%A5%B3%E7%A5%9E%E5%A4%A7%E4%BC%9A&type=all&page='+str(i) 
    html = requests.get(url=url).content
    news = json.loads(html.decode('utf-8'))['news']
    this_id = [k['id'] for k in news]
    this_pic = [k['thumb'] for k in news]
    this_title = [k['title'] for k in news]
    this_date = [k['pubdate'] for k in news]
    this_title=[BeautifulSoup(k,"html.parser").text for k in this_title]
    id_list = id_list+this_id
    title_list = title_list+this_title
    pic_list = pic_list+this_pic
    date_list = date_list+this_date

prev_title_list = []
score_list=[]
count_list=[]
for id in id_list:
    url = 'http://www.dongqiudi.com/archive/{k}.html'.format(k=id)    
    header = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win32; x32; rv:54.0) Gecko/20100101 Firefox/54.0',
    'Connection': 'keep-alive'}
    cookies ='v=3; iuuid=1A6E888B4A4B29B16FBA1299108DBE9CDCB327A9713C232B36E4DB4FF222CF03; webp=true; ci=1%2C%E5%8C%97%E4%BA%AC; __guid=26581345.3954606544145667000.1530879049181.8303; _lxsdk_cuid=1646f808301c8-0a4e19f5421593-5d4e211f-100200-1646f808302c8; _lxsdk=1A6E888B4A4B29B16FBA1299108DBE9CDCB327A9713C232B36E4DB4FF222CF03; monitor_count=1; _lxsdk_s=16472ee89ec-de2-f91-ed0%7C%7C5; __mta=189118996.1530879050545.1530936763555.1530937843742.18'
    cookie = {}
    for line in cookies.split(';'):
        name, value = cookies.strip().split('=', 1)
        cookie[name] = value    
    html = requests.get(url,cookies=cookie, headers=header).content
    try:
        content = BeautifulSoup(html.decode('utf-8'),"html.parser")
        score = content.find('span',attrs={'style':"color:#ff0000"}).text
        prev_title = content.find('a',attrs={"target": "_self"}).text
        prev_title_list.append(prev_title)
        score_list.append(score)
        sentence = content.text.split('，')
        count=[k for k in sentence if re.search('截至目前',str(k))][0]
        count_list.append(count)
    except:
        continue

score_table = pd.DataFrame({'score':score_list,'prev':prev_title_list,'count':count_list}) 
info_table = pd.DataFrame({'id':id_list,'title':title_list,'pic':pic_list,'date':date_list})

score_table['title'] = [re.sub('【前情回顾：|】','',k) for k in score_table['prev']]
score_table['title'] = [re.split('：|，',k)[1] for k in score_table['title']]

info_table['title'] = [re.split('：|，',k)[1] for k in info_table['title']]

godness_table = pd.merge(info_table,score_table,how='left',on='title')
godness_table['score'] = [re.sub('综合得分|，','',str(k)) for k in godness_table['score']]
godness_table['name'] = [re.sub(re.split('”',k)[0],'',k) for k in godness_table['title']]
godness_table['name'] = [re.sub('”','',k) for k in godness_table['name']]
godness_table['count'] = [re.sub('截至目前超过|万人打分','',str(k)) for k in godness_table['count']]



godness_table.to_excel('女神统计.xlsx')











   