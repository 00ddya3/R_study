anscombe[, c("x1", "y1")]

df = anscombe

par(mfrow=c(2,2))

plot(df$x1, df$y1, pch=19, col='tomato')
abline(lm(y1~x1, data=df), col='skyblue')

plot(df$x2, df$y2, pch=19, col='tomato')
abline(lm(y2~x2, data=df), col='skyblue')

plot(df$x3, df$y3, pch=19, col='tomato')
abline(lm(y3~x3, data=df), col='skyblue')

plot(df$x4, df$y4, pch=19, col='tomato')
abline(lm(y4~x4, data=df), col='skyblue')

install.packages('tidyverse')
library(tidyverse)

str(mpg)
head(mpg)

p=ggplot(data=mpg, mapping=aes(x=displ, y=hwy))
p
p+geom_point(mapping = aes(color=class, size=class, alpha=1))

p+geom_point(color='steelblue') + facet_wrap(~class, nrow=2)

p+geom_point(color='orange') + facet_grid(drv~cyl)

p + geom_point (color='blue') + geom_smooth(color='cyan')
                


library(ggplot2)
data('diamonds')
str(diamonds)

p=ggplot(data=diamonds)
#바플롯 (둘다 같음)
p+geom_bar(mapping=aes(x=cut), fill='violet')
p+stat_count(mapping=aes(x=cut), fill='violet')


#y축 끝까지 다 차게 그리기
#fill=clarity : clarity별로 색이 다르게
p+stat_count(mapping=aes(x=cut, fill=clarity), position='fill')

#clarity별로 묶어서 보기
p + geom_bar(mapping=aes(x=cut, fill=clarity), position='dodge')

#산점도
ggplot(data=mpg) + 
  geom_point(mapping=aes(x=displ, y=hwy, color=class), 
             position='jitter')

#박스플롯
p=ggplot(data=mpg, mapping=aes(x=class, y=hwy))
p+geom_boxplot(fill='lightyellow')

#가로로 눕히기
p+geom_boxplot(fill='lightyellow')+coord_flip()


p=ggplot(data=diamonds, mapping=aes(x=cut, fill=cut))
#show.legend = 범례표시
#width : 0 초과 1 이하
+geom_bar(show.legend = F, width = 1)

#coord_polar() :극좌표계
p+geom_bar(show.legend = F, width = 1) +
  labs(x=NULL, y=NULL) + theme(aspect.ratio = 1) + coord_polar()










