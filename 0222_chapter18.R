library(ggplot2)
library(tidyverse)


p=ggplot(data=mpg, aes(displ, hwy)) +
  geom_point(aes(color=class)) +
  geom_smooth(se=FALSE)

#title, subtitle, caption
p+labs(title="Fuel efficiency .vs. engine size",
       subtitle = "Two seaters are exceptional",
       caption = "Data from fueleconomy.gov")

#x, y, color
p + labs(x="engine displacement(L)",
         y="highway fuel economy(mpg)",
         color = "Car Type")

#group by, filter
best_in_class = mpg %>%
  group_by(class) %>%
  filter(row_number(desc(hwy))==1)

#geom-text
p+geom_text(aes(label = model), data=best_in_class)

label = tibble(displ=Inf, hwy=Inf, label='첫줄/n둘째줄')

p+geom_text(data=label, aes(label=label), vjust='top', hjust='right')



##################################
install.packages("dplyr")
library(dplyr)

df <- mpg[,c(2,3,9,11)]

df.trim <- df %>%
  group_by(class) %>%
  filter (row_number(desc(hwy))==1)

df.trim

p<- ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth()

#모델명을 그래프에 표시하기

p + geom_text(data = df.trim,
              aes(label = model))

p + geom_text(data = mpg,
              aes(label = fl))

p + geom_label(data = df.trim,
               aes(label = model),
               nudge_y = 2, alpha = 0.9)

#라벨 붙이기

##모든 점에 라벨붙여짐
p + geom_text(data = mpg, 
              aes(label = "Hello"))

label <- tibble(
  displ = Inf, hwy = Inf, #infinite
  label = "Increasing engine size is related to decreasing fuel economy."
)

##라벨 붙여주기
p + geom_text(data = label, 
              aes(label = label),
              vjust = "top",
              hjust = "right")

#테마설정
p+theme_bw()

#플롯 저장
ggsave(file='myplot.png', width = 1920, height=1080, units='px')


#####R gallery book에서 Sankey Diagram 그리기

install.packages("networkD3")
library(networkD3)

# A connection data frame is a list of flows with intensity for each flow
links <- data.frame(
  source=c("group_A","group_A", "group_B", "group_C", "group_C", "group_E"), 
  target=c("group_C","group_D", "group_E", "group_F", "group_G", "group_H"), 
  value=c(2,3, 2, 3, 1, 3)
)

# From these flows we need to create a node data frame: it lists every entities involved in the flow
nodes <- data.frame(
  name=c(as.character(links$source), 
         as.character(links$target)) %>% unique()
)

# With networkD3, connection must be provided using id, not using real name like in the links dataframe.. So we need to reformat it.
links$IDsource <- match(links$source, nodes$name)-1 
links$IDtarget <- match(links$target, nodes$name)-1

# Make the Network
p <- sankeyNetwork(Links = links, Nodes = nodes,
                   Source = "IDsource", Target = "IDtarget",
                   Value = "value", NodeID = "name", 
                   sinksRight=FALSE)
p


#####gapminder
install.packages("gapminder")
library(gapminder)
gapminder

ggplot(data=gapminder,
       mapping=aes(x=gdpPercap, y=lifeExp, color=continent)) +
  geom_point(alpha=0.5) + 
  scale_x_log10(labels = scales::dollar) +
  labs(title = "Life Expectancy by GDP per Captita",
       x="GDP per Captita", y="Life Expectancy") + 
  theme(plot.title=element_text(size=18, face="bold", color="magenta"))



#동그라미의 크기를 인구수(pop)에 대비시키시오
#방법1
ggplot(data=gapminder,
       mapping=aes(x=gdpPercap, y=lifeExp, color=continent)) +
  geom_point(mapping=aes(size=pop), alpha=0.5) + 
  scale_x_log10(labels = scales::dollar) +
  labs(title = "Life Expectancy by GDP per Captita",
       x="GDP per Captita", y="Life Expectancy") + 
  theme(plot.title=element_text(size=18, face="bold", color="magenta"))

#방법2
ggplot(data=gapminder,
       mapping=aes(x=gdpPercap, y=lifeExp, 
                   color=continent, size=pop)) +
  geom_point(alpha=0.5) + 
  scale_x_log10(labels = scales::dollar) +
  labs(title = "Life Expectancy by GDP per Captita",
       x="GDP per Captita", y="Life Expectancy") + 
  theme(plot.title=element_text(size=18, face="bold", color="magenta"))
