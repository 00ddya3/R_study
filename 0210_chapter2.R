v=1:10
answer = 0

#n층의 나무블럭의 개수
#1+4+9+...+n^2 = n(n+1)(2n+1)/6 = (2n^3+3n^2+n)/6
#1~10층의 나무블럭의 개수의 합
#sigma(1, 10){(2n^3+3n^2+n)/6}

for (n in v) {
  answer = answer + ((2*(n^3)+3*(n^2)+n)/6)
}

############################################

answer = 0

#n층의 나무블럭의 개수
#1+4+8+12+...+4(n-1) = 1+ 2n(n-1)
#1~10층의 나무블럭의 개수의 합
# 1+sigma(2, 10){4(n-1)}

for (n in v) {
  answer = answer + 1+2*n*(n-1)
}

answer4

############################################

v=c('H', 'T')
sample(x=v, size = 1, replace=T)

############################################

x=1:6
pool = sample(x, 1000, replace=T)

#홀수가 나올 확률
event = pool[pool%%2 == 1]
length(event)/length(pool)

#소수가 나올 확률
event = pool[pool %in% c(2,3,5)]
length(event)/length(pool)

#홀수&소수가 나올 확률
event = pool[pool %in% c(2,3,5) & pool%%2 == 1]
length(event)/length(pool)

#짝수&소수가 나올 확률
event = pool[pool %in% c(2,3,5) & pool%%2 == 0]
length(event)/length(pool)











