install.packages('MASS')
library(MASS)
data("survey")
?survey
str(survey)

Smoke.tab = table(survey$Smoke)
barplot(Smoke.tab)

#################################################

install.packages('vcd')
library(vcd)
data('Arthritis')
str(Arthritis)

crs.tab = table(Arthritis$Improved, Arthritis$Treatment)
crs.tab


pulse.male = survey[survey$Sex == 'Male', ]
pulse.female = survey[survey$Sex == 'Female', ]
t=tapply(survey$Pulse, survey$Sex, mean, na.rm=T)