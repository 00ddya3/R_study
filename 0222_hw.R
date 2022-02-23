install.packages("vioplot")
install.packages("treemap")

library(gapminder)
library(ggplot2)
library(vioplot)
library(tidyverse)
library(treemap)

###이전에 사용한 데이터로 실습
flights=read.csv('C:/R_workspace/flights.csv', header=T)
head(flights)


#사람들은 긴 비행에서 더 좋은 좌석을 선호할까?
with(data=flights, 
     vioplot(distance[flightType=='premium'],
             distance[flightType=='firstClass'],
             distance[flightType=='economic'],
             color=flightType,
             names=c('premium', 'firstClass', 'economic')))
#Error in (1 - h) * qs[i] : non-numeric argument to binary operator 에러 발생
#distance type num이라는데 왜??

#여행사별 금액대
ggplot(data=flights, aes(x=agency,  y=price, fill=flightType)) + 
  geom_bar(position="dodge", stat="identity")

#자주가는 여행지
treemap_data = flights %>% group_by(to) %>% summarize(times = n())
treemap_data
treemap(treemap_data, index="to", vSize="times")

#여행시간 분포
ggplot(flights, aes(x=time)) + geom_histogram()

#여행시간 분포
flights %>% ggplot(aes(x=time)) + 
  geom_density(color='orange', fill='orange', alpha=0.5)

#여행사 점유율
donut_data = flights %>% group_by(agency) %>% summarize(share = n())
donut_data$fraction = donut_data$share/sum(donut_data$share)
donut_data$ymax = cumsum(donut_data$fraction)
donut_data$ymin = c(0, head(donut_data$ymax, n=-1))

ggplot(donut_data, aes(ymax=ymax, ymin=ymin, xmax=4, xmin=3, fill=agency)) +
  geom_rect() +
  coord_polar(theta="y")+
  xlim(c(2,4))
