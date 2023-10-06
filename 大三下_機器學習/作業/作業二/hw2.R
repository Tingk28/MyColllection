#3.14
set.seed (1)
x1 <- runif (100)
x2 <- 0.5 * x1 + rnorm (100) / 10
y <- 2 + 2 * x1 + 0.3 * x2 + rnorm (100)

#14-b
cor(x1,x2)#correlation
plot(x1,x2,main="x1,x2")
confint(lm.fit)

#14-c
lm.fitc<-lm(y~x1+x2)
summary(lm.fitc)
confint(lm.fitc)
anova(lm.fitc)
#14-d
lm.fitd<-lm(y~x1)
summary(lm.fitd)

#14-e
lm.fite<-lm(y~x2)
summary(lm.fite)

#14-f
#14-g
x1_new<-c(x1,0.1)
x2_new<-c(x2,0.8)
y_new<-c(y,6)
plot(x1_new,x2_new)
points(x1_new[101],x2_new[101],col='red',lwd=3)

par(mfrow=c(2,2))
#14-c2
lm.fitc_new<-lm(y_new~x1_new+x2_new)
summary(lm.fitc_new)
confint(lm.fitc_new)
anova(lm.fitc_new)
plot(lm.fitc_new)

#14-d2
lm.fitd_new<-lm(y_new~x1_new)
summary(lm.fitd_new)
plot(x1_new,y_new,main="x1,y")
abline(lm.fitd_new,col='red')
abline(lm.fitd,lty=2)
points(x1_new[101],y_new[101],col='red',lwd=3)
text(x1_new[101],y_new[101],labels = '101',pos = 1)
legend(x='bottomleft',legend=c('with new obs.','excluded new obs.'),col=c('red','black'),lty=c(1,2))

plot(lm.fitd_new)
points(x1_new[101],y_new[101],col='red',lwd=3)

#14-e2
lm.fite_new<-lm(y_new~x2_new)
summary(lm.fite_new)

plot(x2_new,y_new,main="x2,y")
abline(lm.fite_new,col='red')
abline(lm.fite,lty=2)
points(x2_new[101],y_new[101],col='red',lwd=3)
text(x2_new[101],y_new[101],labels = '101',pos = 1)
legend(x='bottomleft',legend=c('with new obs.','excluded new obs.'),col=c('red','black'),lty=c(1,2))

plot(lm.fite_new)
     
#15

#15-a
library(MASS)
library(ISLR2)
head(Boston)
models = matrix(nrow=12,ncol=12)


fit_zn<-lm(crim~zn,data = Boston)
fit_indus<-lm(crim~indus,data = Boston)
fit_chas<-lm(crim~chas,data = Boston)
fit_nox<-lm(crim~nox,data = Boston)
fit_rm<-lm(crim~rm,data = Boston)
fit_age<-lm(crim~age,data = Boston)
fit_dis<-lm(crim~dis,data = Boston)
fit_rad<-lm(crim~rad,data = Boston)
fit_tax<-lm(crim~tax,data = Boston)
fit_ptratio<-lm(crim~ptratio,data = Boston)
fit_black<-lm(crim~black,data = Boston)
fit_lstat<-lm(crim~lstat,data = Boston)
fit_medv<-lm(crim~medv,data = Boston)

summary(fit_zn)
summary(fit_indus)
summary(fit_chas)#do not reject h0
summary(fit_nox)
summary(fit_rm)
summary(fit_age)
summary(fit_dis)
summary(fit_rad)#R^2 0.39
summary(fit_tax)#R^2 0.34
summary(fit_ptratio)
summary(fit_black)
summary(fit_lstat)
summary(fit_medv)#R^2 0.15

pairs(Boston)

plot(rad,crim,main="rad and crime rate")
plot(tax,crim,main="tax and crime rate")

##15-2
fit.all<-lm(crim~.,data = Boston)
summary(fit.all)

#15-3
simple_linear<-c(fit_zn$coefficients[2],fit_indus$coefficients[2],fit_chas$coefficients[2],
      fit_nox$coefficients[2],fit_rm$coefficients[2],fit_age$coefficients[2],
      fit_dis$coefficients[2],fit_rad$coefficients[2],fit_tax$coefficients[2],
      fit_ptratio$coefficients[2],fit_black$coefficients[2],fit_lstat$coefficients[2],fit_medv$coefficients[2])
multi_linear<-c(fit.all$coefficients[2:14])
plot(simple_linear,multi_linear,main="Simple and multiple reg. coeff.")
abline(a=0,b=1)
plot(nox,dis,main = "nox and dis")

#15-4
fit_zn3<-lm(crim~poly ( zn,3),data = Boston)
fit_indus3<-lm(crim~poly ( indus,3),data = Boston)
fit_chas3<-lm(crim~poly ( chas,3),data = Boston)#has error
fit_nox3<-lm(crim~poly ( nox,3),data = Boston)
fit_rm3<-lm(crim~poly ( rm,3),data = Boston)
fit_age3<-lm(crim~poly ( age,3),data = Boston)
fit_dis3<-lm(crim~poly ( dis,3),data = Boston)
fit_rad3<-lm(crim~poly ( rad,3),data = Boston)
fit_tax3<-lm(crim~poly ( tax,3),data = Boston)
fit_ptratio3<-lm(crim~poly ( ptratio,3),data = Boston)
fit_black3<-lm(crim~poly ( black,3),data = Boston)
fit_lstat3<-lm(crim~poly ( lstat,3),data = Boston)
fit_medv3<-lm(crim~poly ( medv,3),data = Boston)

summary(fit_zn3)
summary(fit_indus3)
summary(fit_chas3)#no such model
summary(fit_nox3)#R^2 0.3
summary(fit_rm3)#R^2 0.068
summary(fit_age3)#R^2 0.17
summary(fit_dis3)#R^2 0.28
summary(fit_rad3)#R^2 0.4
summary(fit_tax3)#R^2 0.37
summary(fit_ptratio3)
summary(fit_black3)
summary(fit_lstat3)
summary(fit_medv3)#R^2 0.42

plot(medv,crim,main = "medv and crim")
#points(Boston$medv,fitted(fit_medv3),lty=1,col='red')
lines(sort(Boston$medv),fitted(fit_medv3)[order(Boston$medv)],lty=1,col='red')
plot(nox,crim,main = "nox and crim")
lines(sort(Boston$nox),fitted(fit_nox3)[order(Boston$nox)],lty=1,col='red')
