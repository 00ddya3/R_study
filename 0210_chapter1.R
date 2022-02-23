v=c(10, 20, 30, 40, 50, 60, 70)
v[v>50]

f2 = factor(c(1 , 2 , 2 , 1 , 2 ), labels=c('M', 'F'))
f2
levels(f2)
table(f2)

v1=1:3
v2=c(T, F, T)
v3=c('Hello', 'R', 'World')
df = data.frame(col1=v1, col2=v2, col3=v3)
df

df[c(1, 2), c(1, 3)]