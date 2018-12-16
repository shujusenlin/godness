library(readxl)
library(ggplot2)
library(ggimage)
library(ggthemr)
library(ggthemes)
library(Cairo)


setwd('D:/爬虫/女神')

data = read_excel('女神统计.xlsx')
data$score = as.numeric(data$score)
data$count=as.numeric(data$count)
data$final_score=data$score+data$count/1000
data$show_score=data$final_score-3
data$label=paste(data$name,'综合得分:',data$final_score)

## 整体排行榜
ggthemr('light')
p<-ggplot(data[order(data$final_score,decreasing = T),][1:15,],
       aes(x=reorder(name,final_score),y=show_score))+
  geom_bar(stat='identity',width = 0.7)+
  geom_image(aes(x=name,y=0.1,image=pic),size=0.09)+
  geom_text(aes(x=name,y=3,label=label),size = 7,col='black',fontface='bold')+
  ggtitle('女神排行榜TOP15') +                       
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        plot.title = element_text(hjust=0.5,size=50),
        panel.grid = element_blank(),
        legend.position = 'none',
        panel.background = element_blank(),
        axis.title  = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank()
        )+coord_flip()+ylim(0,6.65)
ggsave("整体top15.png", p, width = 10, height = 16) 

p<-ggplot(data[order(data$final_score,decreasing = F),][1:15,],
       aes(x=reorder(name,-final_score),y=show_score))+
  geom_bar(stat='identity',width = 0.7)+
  geom_image(aes(x=name,y=0.1,image=pic),size=0.09)+
  geom_text(aes(x=name,y=3,label=label),size = 7,col='black',fontface='bold')+
  ggtitle('女神排行榜BOTTOM15') +                       
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        plot.title = element_text(hjust=0.5,size=50),
        panel.grid = element_blank(),
        legend.position = 'none',
        panel.background = element_blank(),
        axis.title  = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank()
  )+coord_flip()+ylim(0,6.65)
ggsave("整体bottom15.png", p, width = 10, height = 16)

## 地区排行榜
ggthemr('pale')
gangtai <- subset(data,area=='港台')
p<-ggplot(gangtai[order(gangtai$final_score,decreasing = T),][1:10,],
          aes(x=reorder(name,final_score),y=show_score))+
  geom_bar(stat='identity',width = 0.6)+
  geom_image(aes(x=name,y=0.1,image=pic),size=0.12)+
  geom_text(aes(x=name,y=3,label=label),size = 7,col='black',fontface='bold')+
  ggtitle('港台女神榜单TOP10') +                       
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        plot.title = element_text(hjust=0.5,size=30),
        panel.grid = element_blank(),
        legend.position = 'none',
        panel.background = element_blank(),
        axis.title  = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank()
  )+coord_flip()+ylim(0,6.65)
ggsave("港台top10.png", p, width = 6, height = 10) 


ggthemr('pale')
oumei <- subset(data,area=='欧美')
p<-ggplot(oumei[order(oumei$final_score,decreasing = T),][1:10,],
          aes(x=reorder(name,final_score),y=show_score))+
  geom_bar(stat='identity',width = 0.6)+
  geom_image(aes(x=name,y=0.1,image=pic),size=0.12)+
  geom_text(aes(x=name,y=3,label=label),size = 7,col='black',fontface='bold')+
  ggtitle('欧美女神榜单TOP10') +                       
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        plot.title = element_text(hjust=0.5,size=30),
        panel.grid = element_blank(),
        legend.position = 'none',
        panel.background = element_blank(),
        axis.title  = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank()
  )+coord_flip()+ylim(0,6.65)
ggsave("欧美top10.png", p, width = 6, height = 10) 


ggthemr('pale')
rihan <- subset(data,area=='日韩')
p<-ggplot(rihan[order(rihan$final_score,decreasing = T),][1:10,],
          aes(x=reorder(name,final_score),y=show_score))+
  geom_bar(stat='identity',width = 0.6)+
  geom_image(aes(x=name,y=0.1,image=pic),size=0.12)+
  geom_text(aes(x=name,y=3,label=label),size = 7,col='black',fontface='bold')+
  ggtitle('日韩女神榜单TOP10') +                       
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        plot.title = element_text(hjust=0.5,size=30),
        panel.grid = element_blank(),
        legend.position = 'none',
        panel.background = element_blank(),
        axis.title  = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank()
  )+coord_flip()+ylim(0,6.65)
ggsave("日韩top10.png", p, width = 6, height = 10) 


ggthemr('pale')
neidi <- subset(data,area=='大陆')
p<-ggplot(neidi[order(neidi$final_score,decreasing = T),][1:10,],
          aes(x=reorder(name,final_score),y=show_score))+
  geom_bar(stat='identity',width = 0.6)+
  geom_image(aes(x=name,y=0.1,image=pic),size=0.12)+
  geom_text(aes(x=name,y=3,label=label),size = 7,col='black',fontface='bold')+
  ggtitle('大陆女神榜单TOP10') +                       
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        plot.title = element_text(hjust=0.5,size=30),
        panel.grid = element_blank(),
        legend.position = 'none',
        panel.background = element_blank(),
        axis.title  = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank()
  )+coord_flip()+ylim(0,6.65)
ggsave("内地top10.png", p, width = 6, height = 10) 


## 区域对比
ggthemr('grape')
ggplot(data,aes(x=area,y=final_score,fill=area))+
  geom_boxplot(col='black',alpha=1,notchwidth = 1)+
  geom_violin(alpha=0.5,width=1)+
  theme_wsj()+  ggtitle('地区评分对比') +                     
  theme(axis.text.x = element_text(size=25),
        axis.text.y = element_text(size=25),
        plot.title = element_text(hjust=0.5,size=25),
        panel.grid = element_blank(),
        axis.title  = element_blank(),
        legend.position =  'NONE'  )

## 年份对比
data$period=ifelse(data$year<1970,'60后',ifelse(data$year<1980,'70后',ifelse(data$year<1990,'80后','90后')))
ggthemr('grape')
ggplot(data,aes(x=period,y=final_score,fill=period))+
  geom_boxplot(col='black',alpha=1,notchwidth = 1)+
  geom_violin(alpha=0.7,width=0.8)+
  theme_wsj()+  ggtitle('出生年份评分对比') +                     
  theme(axis.text.x = element_text(size=25),
        axis.text.y = element_text(size=25),
        plot.title = element_text(hjust=0.5,size=25),
        panel.grid = element_blank(),
        axis.title  = element_blank(),
        legend.position =  'NONE'  )

## 年份/区域对比
ggthemr('light')
ggplot(data,aes(x=score,y=1,fill=period,col=area))+
  geom_histogram(col='black',stat='identity')+
  ggtitle('出生年份评分对比') +                     
  theme(axis.text.x = element_text(size=25),
        axis.text.y = element_blank(),
        plot.title = element_text(hjust=0.5,size=25),
        panel.grid = element_blank(),
        axis.title = element_blank())+facet_wrap(~area,ncol=1)
## 星期对比
data$weekday = weekdays(as.Date(data$date))
ggplot(data,aes(x=factor(weekday,order=TRUE,
  levels=c("星期一","星期二","星期三","星期四","星期五","星期六","星期日")),y=final_score,fill=weekday))+
  geom_boxplot(col='black',alpha=1,notchwidth = 1)+
  geom_violin(alpha=0.7,width=0.8)+
  theme_wsj()+  ggtitle('发布日期星期评分对比') +                     
  theme(axis.text.x = element_text(size=25),
        axis.text.y = element_text(size=25),
        plot.title = element_text(hjust=0.5,size=25),
        panel.grid = element_blank(),
        axis.title  = element_blank(),
        legend.position =  'NONE'  )
