#week2 practise dplyr

load("demo.Rdata")

##安裝套件
install.packages("dplyr")

#啟動套件
library(dplyr)

#order rows
d1=arrange(d,talklength)
d1=arrange(d,desc(talklength))

#最大的10個值
top_n(d, 10, talklength)

##選擇資料
#選擇變項
d1=select(d,content)
d1=select(d,title:date)
d1=select(d,-title)
d1=select(d, -(title:date))

#選擇觀察值
#過濾
d1=filter(d,talklength==0)
d1=filter(d,sentiment=="中立")	

#設定條件
d1=subset(d, talklength>10 & sentiment=="中立")
		
#刪除變項
d$title=NULL
	
#刪除obs
d1=d[-c(1:3),]
	
##修改變項
#改變名稱
d=rename(d, source=media)   

#改變類型
d$source=as.factor(d$source)

##重新編碼,& 存成新變項
table(d$source)
d=mutate(d, media=recode(source, "LINE TODAY"="web media", 
                         "TVBS新聞"="traditional media", 
                         "yahoo新聞"="web media", 
                       "Match生活網"="web media", 
                       "Taiwan News Agency"="traditional media", 
                       "自由時報"="traditional media") )
table(d$media)

#看每種媒體的發文數
count(d,source)

#看每篇文章平均的回應數
summarise(d,avg=mean(talklength))

#看每種媒體的每篇文章平均的回應數
d %>%
  group_by(source)%>%
  summarise(avg=mean(talklength))

#產生一個新變項size，計算每篇文章的字數
d$size=nchar(d$content)
