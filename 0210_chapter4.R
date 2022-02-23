fact = function(n) {

  if (n == 0) {
    result = 1
  } else {
    result = 1
    for (i in 1:n) {
      result = result*(i)
      }
  }
  
  return (result)
}

choose = function(a, b) {
  return ( fact(a)/fact(b)/fact(a-b) )
}

#로또 : 1~45 중 순서없이 6개 선택
#로또 하나도 맞히지 못하는 경우의 수 : 39C6
fact(39)/fact(6)/fact(33)

#3개를 맞히는 경우의 수 : 39C3 * 6C3
fact(39)/fact(3)/fact(36) * fact(6)/fact(3)/fact(3)

lotto = function(x) {
  return (choose(39, 6-x) * choose(6, x))
}

for (x in 0:6) {
  cat(x, '개를 맞출 경우의 수 : ', lotto(x), '\n')
}

lotto2 = function(x) {
  return( lotto(x) / choose(45,6))
}

for (x in 0:6) {
  cat(x, lotto2(x), '\n')
}

win = 0:6 #맞춘 개수
prob = sapply(win, lotto2) #맞출 확률

win_prob = as.table(prob) #prob 벡터를 테이블형태로 바꾸겠다 (1*n행렬)
win_prob
dimnames(win_prob) = list(win) #테이블의 열이름을 win으로 바꾸겠다
win_prob

barplot(win_prob, 
        main='로또의 당첨확률',
        xlab='맞춘 숫자 개수',
        ylab='당첨확률',
        col='orange')

plot(win, prob, type='o')

###############################################################

x=seq(0, 100, length=200) #0부터 100까지를 200개로 쪼갠다. 등차 0.5
plot(x, dnorm(x, mean=50, sd=10),
     type = 'l',
     main='Normal Distribution') #평균 50, 표편 10인 정규분포

###############################################################

x=seq(0,100,length=200)
dnorm(50, mean=50, sd=10)
plot(x, dnorm(x, mean=50, sd=10), type='l')

pnorm(40, mean=50, sd=10)  

qnorm(0.1586553, mean=50, sd=10)
qnorm(0.99, mean=0, sd=1)
  
pnorm(35000, 30000, 10000) - pnorm(25000, 30000, 10000)  
pnorm(70, 50, 10)  
pnorm(60, 50, 10)  
pnorm(80, 50, 10)

###############################################################

1-pnorm(70, 60, 10) #수학 상위
1-pnorm(80, 70, 20) #영어 상위

###############################################################

x=c('H', 'T')
count = 0
for (i in 1:1000) {
  result = sample(x, 2, replace=T)
  #if (length(result[result == 'H']) == 0) {
  #  count = count +1
  #}
  count = count + ifelse(length(result[result == 'H']) == 0, 1, 0)
}
count

x=seq(25, 75)
hist(rbinom(10000, 100, 0.5), prob=T, breaks=30, freq=F)
curve(dnorm(x, 50, 5), 25, 75, lwd=5, add=T)
lines(density(rbinom(10000, 100, 0.5)))






