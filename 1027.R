#1차시
setwd("C:\\R_temp")
getwd()

install.packages("readxl")
library("readxl")

ck <- read_excel("data_week_9.xlsx")
head(ck)

addr <- substr(ck$소재지전체주소, 11, 16)
head(addr)

addr_num <- gsub("[0-9]", "", addr)
addr_trim <- gsub(" ", "", addr_num)
head(addr_trim)

install.packages("dplyr")
library(dplyr)

addr_count <- addr_trim %>% table() %>% data.frame()
head(addr_count)

install.packages("treemap")
library(treemap)
treemap(addr_count, index=".", vSize="Freq", title="서대문구 동별 치킨집 분포")


#3차시
setwd("C:\\R_temp")
getwd()

install.packages("ggplot2")
library(ggplot2)
install.packages("dplyr")
library(dplyr)

mpg<-as.data.frame(ggplot2::mpg)
head(mpg)

mpg_diff <- mpg %>% 
  select(class, cty) %>% 
  filter(class%in%c("compact", "suv"))
head(mpg_diff)
table(mpg_diff$class)

t.test(data=mpg_diff, cty~class, var.equal=T)

#3차시 실습
setwd("C:\\R_temp")
getwd()

install.packages("dplyr")
library(dplyr)

sc <- read.csv("data1.csv")
head(sc)

sc_diff <- sc %>% select(gender, iq)
head(sc_diff)
table(sc_diff$gender)

sc_diff %>%
  group_by(gender) %>%
  summarise(mean=mean(iq), median=median(iq), 
            var=var(iq), sd=sd(iq))

t.test(data=sc_diff, iq~gender, var.equal=T)
