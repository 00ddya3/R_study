#1차시
setwd("C:\\R_temp")
getwd()

install.packages("foreign")
install.packages("dplyr")
install.packages("ggplot2")
library("foreign")
library("dplyr")
library("ggplot2")

raw_welfare <- read.spss(file="Koweps_hpc10_2015_beta1.sav", to.data.frame=T)

welfare<-raw_welfare
welfare<-rename(welfare, sex=h10_g3, birth=h10_g4, marriage=h10_g10,
                religion=h10_g11, income=p1002_8aq1, code_job=h10_eco9,
                code_religion=h10_reg7)

class(welfare$sex)
table(welfare$sex)
welfare$sex<-ifelse(welfare$sex==1, "male", "female")
table(welfare$sex)
qplot(welfare$sex)

class(welfare$income)
summary(welfare$income)
qplot(welfare$income)+xlim(0,1000)

sex_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(sex) %>%
  summarise(mean_income=mean(income))
sex_income
ggplot(data=sex_income, aes(x=sex, y=mean_income))+geom_col()

class(welfare$birth)
summary(welfare$birth)
qplot(welfare$birth)

install.packages("readxl")
library("readxl")

youtube <- read_excel("week10_youtube.xlsx")
View(youtube)
youtube$ratio<-(youtube$dislikeCount/(youtube$dislikeCount+youtube$likeCount))*1000
youtube$ratio
youtube$ratio_ch <- ifelse(youtube$ratio<25, 1, ifelse(youtube$ratio<50, 2, ifelse(youtube$ratio<75, 3, 4)))
table(youtube$ratio_ch)
ratio_commentCount<-youtube%>%
  filter(!is.na(commentCount))%>%
  group_by(ratio_ch)%>%
  summarise(mean_commentCount=mean(commentCount))
ratio_commentCount
ggplot(ratio_commentCount, 
       aes(x=ratio_ch, y=mean_commentCount))+geom_col()

youtube$ratio<-(youtube$dislikeCount/(youtube$dislikeCount+youtube$likeCount))*100
youtube$ratio_ch<-ifelse(youtube$ratio<25, 1, ifelse(youtube$ratio<50,2, ifelse(youtube$ratio<75,3,4)))
table(youtube$ratio_ch)


#2차시
setwd("C:\\R_temp")
getwd()
men<-read.csv("men.csv")
men
plot(weight~height, data=men)
nem<-lm(weight~height, data=men)
abline(nem)


#3차시
summary(nem)
cor.test(men$weight, men$height)
(0.990699)^2

airbnb<-read.csv("week10_airbnb.csv")
airbnb_select <- airbnb %>% 
  select(host_response_rate, review_scores_rating) %>%
  filter(host_response_rate>0 & host_response_rate<=100 & 
           review_scores_rating>0 & review_scores_rating<=100)
head(airbnb_select)

plot(review_scores_rating~host_response_rate, data=airbnb_select)
bnb<-lm(review_scores_rating~host_response_rate, data=airbnb_select)
abline(bnb)
summary(bnb)
