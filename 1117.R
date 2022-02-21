#1차시
setwd("C:\\R_temp")
getwd()

install.packages("RColorBrewer")
install.packages("wordcloud")
install.packages("dplyr")
install.packages("rJava")
install.packages("memoise")
install.packages("multilinguer")
install.packages(c('stringr','hash','tau','Sejong','RSQLite','devtools'),type="binary")
install.packages("remotes")
remotes::install_github('haven-jeon/KONLP',upgrade='never',INSTALL_opts=c("--no-multiarch"))

library(RColorBrewer)
library(KoNLP)
library(wordcloud)
library(dplyr)

pos=KoNLP::SimplePos09('아 정말 졸린 수업이다. Wow!!')
pos

install.packages("stringr")
library(stringr)
extracted=str_match(pos, '([가-힣]+)/[NP]') #명사와 용언만 추출
extracted

keyword=extracted[,2] #2열에 있는 값만 추출
keyword=keyword[!is.na(keyword)] #오류가 아닌 값만 추출
keyword

#2차시
useNIADic()

txt<-readLines("hiphop.txt")
head(txt)

library(stringr)
txt<-str_replace_all(txt, "\\W", " ")

nouns<-extractNoun(txt) #가사에서 명사 추출
head(nouns)
wordcount<-table(unlist(nouns)) # 명사리스트를 문자열 벡터로 변환, 빈도표 작성
wordcount

# 데이터 프레임으로 변환 
df_word <- as.data.frame(wordcount, stringsAsFactors = F) 
# 변수명 수정 
df_word <- rename(df_word, word = Var1, freq = Freq) 
# 두 글자 이상 단어 추출 
df_word <- filter(df_word, nchar(word) >= 2) 
top_20 <- df_word %>% arrange(desc(freq)) %>% head(20) 

library(RColorBrewer)

pal<-brewer.pal(8,"Dark2")
set.seed(1234) # 난수 고정 
wordcloud(words = df_word$word, # 단어 
          freq = df_word$freq, # 빈도 
          min.freq = 2, # 최소 단어 빈도 
          max.words = 200, # 표현 단어 수 
          random.order = F, # 고빈도 단어 중앙 배치 
          rot.per = .1, # 회전 단어 비율 
          scale = c(4, 0.3), # 단어 크기 범위 
          colors = pal) # 색깔 목록 


#3차시
setwd("C:\\R_temp")
getwd()

install.packages("qgraph")
library(qgraph)
install.packages("wordcloud")
library(wordcloud)
install.packages("tm")
library(tm)
install.packages("stringr")
library(stringr)
install.packages("ggplot2")
library(ggplot2)
install.packages("KoNLP")
library(KoNLP)

#news1 분석
texts<-read.csv("news1.csv")
head(texts)

ko.words=function(texts){
  d=str_split(texts,";")
  extracted=tolower(str_match(d,'([가-힣a-zA-Z]+)/[NVO]'))
  keyword=extracted[,2]
  keyword[!is.na(keyword)]
}

cps=Corpus(VectorSource(texts$article_POS))
tdm<-TermDocumentMatrix(cps,control=list(tokenize=ko.words, removePunctuation=T,
                                         removeNumbers=T, worldLengths=c(2,Inf)))
Encoding(tdm$dimnames$Terms) = "CP949"

dtm = as.DocumentTermMatrix(tdm)

freq=sort(colSums(as.matrix(dtm)), decreasing=TRUE)
wf=data.frame(word=names(freq), freq=freq)

p=ggplot(subset(wf, freq>50), aes(word, freq))
p=p+geom_bar(stat="identity")
p=p+theme(axis.text.x = element_text(angle=90, hjust=1))
wordcloud(names(freq), freq, min.freq=100, color=brewer.pal(6, "Dark2"))

#news2 분석
texts<-read.csv("news2.csv")
head(texts)

ko.words=function(texts){
  d=str_split(texts,";")
  extracted=tolower(str_match(d,'([가-힣a-zA-Z]+)/[NVO]'))
  keyword=extracted[,2]
  keyword[!is.na(keyword)]
}

cps=Corpus(VectorSource(texts$article_POS))
tdm<-TermDocumentMatrix(cps,control=list(tokenize=ko.words, removePunctuation=T,
                                         removeNumbers=T, worldLengths=c(2,Inf)))
Encoding(tdm$dimnames$Terms) = "CP949"

dtm = as.DocumentTermMatrix(tdm)

freq=sort(colSums(as.matrix(dtm)), decreasing=TRUE)
wf=data.frame(word=names(freq), freq=freq)

p=ggplot(subset(wf, freq>20), aes(word, freq))
p=p+geom_bar(stat="identity")
p=p+theme(axis.text.x = element_text(angle=90, hjust=1))
wordcloud(names(freq), freq, min.freq=70, color=brewer.pal(6, "Dark2"))

