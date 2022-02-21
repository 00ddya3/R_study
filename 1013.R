setwd("C:\\R_temp")
getwd()
df<-read.csv('data_week_7.csv')

install.packages("googleVis")
library(googleVis)
line<-read.csv("data_week_7.csv", header=T, sep=",")

t1<-gvisMotionChart(line, idvar="연령", timevar="연도", options=list(width=1000, height=500))
plot(t1)

Fruits
aggregate(Sales~Year, Fruits, sum)
aggregate(Sales~Year, Fruits, max)
aggregate(Sales~Fruit+Year, Fruits, max)

install.packages("dplyr")
library(dplyr)

setwd("C:\\R_temp")
getwd()
exam<-read.csv("exam_week_7.csv")

exam%>%arrange(desc(math))

aggregate(Sales~Fruit+Year, Fruits, max)

install.packages("googleVis")
library(googleVis)
Fruits

#실습1
aggregate(Sales~Fruit+Year, subset(Fruits, Fruit=="Apples"), max)

#실습2
Fruits$Price<-Fruits$Expenses+Fruits$Profit

Fruits%>%
  group_by(Fruit, Year) %>%
  summarise(max_price=max(Price))

aggregate(Price~Fruit+Year, Fruits, mean)
