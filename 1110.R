#2차시
setwd("C:\\R_temp")
getwd()

install.packages("RCurl")
install.packages("XML")
library(RCurl)
library(XML)

searchUrl<-"https://openapi.naver.com/v1/search/news.xml"
Client_ID<-"_MhCrkp1vzFBx0GapXWI"
Client_Secret<-"DQfMnQA5M1"

query<-URLencode(iconv("첫눈", "euc-kr", "UTF-8"))
url<-paste(searchUrl, "?query=", query, "&display=20", sep="")

doc<-getURL(url, httpheader=c('Content-Type'="application/xml",
          'X-Naver-Client-Id'=Client_ID,
          'X-Naver-Client-Secret'=Client_Secret))

doc2<-htmlParse(doc, encoding="UTF-8")
text<-xpathSApply(doc2, "//item/description", xmlValue)
text


#3차시
setwd("C:\\R_temp")
getwd()

install.packages("httr")
install.packages("rvest")
install.packages("dplyr")
install.packages("stringr")

library(httr)
library(rvest)
library(dplyr)
library(stringr)

url='https://search.naver.com/search.naver?where=news&sm=tab_pge&query=%EC%9D%B4%EB%94%94%EC%95%BC&sort=0&photo=0&field=0&pd=1&ds=2021.11.19&de=2021.11.26&cluster_rank=36&mynews=0&office_type=0&office_section_code=0&news_office_checked=&nso=so:r,p:1w,a:all&start='

naver_url_list<-c()
for(i in 1:9) {
  i=(i*10)-9
  naver_url=paste(url, i, sep="")
  naver_url_list<-c(naver_url_list, naver_url)
}
head(naver_url_list, 5)

news_url<-c()
for(i in 1:length(naver_url_list)) {
  naver_url<-naver_url_list[i]
  html<-read_html(naver_url)
  temp<-unique(html_nodes(html,'.info_group') %>%
                 html_nodes('a') %>%
                 html_attr('href'))
  news_url<-c(news_url,temp)
  print(i)
}
View(news_url)

df_news_url <- as.data.frame(news_url)
df_news_url <- df_news_url[which(grepl("news.naver.com",df_news_url$news_url)),]
df_news_url <- as.data.frame(df_news_url)
df_news_url <- df_news_url[!grepl("sports",df_news_url$df_news_url),]
df_news_url <- as.data.frame(df_news_url)


names(df_news_url) <- "url"
NEWS1 <- df_news_url
NEWS1$title <- ""
NEWS1$date <- ""
NEWS1$content <- ""
View(NEWS1)

NEWS1$url[1] ##1번만 먼저 시행
html <- read_html(as.character(NEWS1$url[1])) 
html_nodes(html, "#articleTitle") %>% html_text()
html_nodes(html, ".t11") %>% html_text()
html_nodes(html, "#articleBodyContents") %>% html_text()


dim(NEWS1)#url구조
for (i in 1:23){
  html <- read_html(as.character(NEWS1$url[i]))
  temp_news_title<- html_nodes(html, "#articleTitle") %>% html_text()
  temp_date <- html_nodes(html, ".t11") %>% html_text()
  temp_news_content <- html_nodes(html, "#articleBodyContents") %>% html_text()
  if (length(temp_news_title)>0){
    NEWS1$title[i] <- temp_news_title
    NEWS1$date[i] <- temp_date
    NEWS1$content[i] <- temp_news_content 
  }
  print(i) ##진행상황 확인
}

View(NEWS1)
NEWS1_1 <- NEWS1
NEWS1_1 <- NEWS1_1[grepl("", NEWS1_1$title),]
write.csv(NEWS1_1, "네이버뉴스_이디야.csv", row.names=F)

