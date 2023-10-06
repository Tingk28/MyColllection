library(e1071)
#9.5
##5-a
set.seed(1)
x1 <- runif (500) - 0.5
x2 <- runif (500) - 0.5
y <- 1 * ( x1 ^2 - x2 ^2 > 0)

data <- as.data.frame(cbind(x1,x2,y))

##5-b
plot(data[1:2],col=data$y+1)

##5-c logistic reg.
glm.fit <- glm(y~., data=data, family = binomial)
summary(glm.fit)

##5-d glm.predict

glm.prob <- predict(glm.fit,type = "response")

hist(glm.prob)
summary(glm.prob)

glm.pred <- rep (0, 500)
glm.pred [ glm.prob > .5] = 1
table(data$y,glm.pred)

for(i in seq(0.46,0.5,0.001)){
  glm.pred <- rep (0, 500)
  glm.pred [ glm.prob > i] = 1
  a=table(data$y,glm.pred)
  cat(i,'\t',a[2]+a[3],'\n')
}#best 0.489-0.49

plot(data[1:2],col=as.integer(glm.prob>0.49)+1)

##5-e~f
glm.fit <- glm(y~I(x1^2), data=data, family = binomial)
summary(glm.fit)
glm.prob <- predict(glm.fit,type = "response")
glm.pred <- rep (0, 500)
glm.pred [ glm.prob > 0.5] = 1
table(data$y,glm.pred)
plot(data[1:2],col=glm.pred+1)

glm.fit <- glm(y~I(x1^2)+log(x2), data=data, family = binomial)
summary(glm.fit)
glm.prob <- predict(glm.fit,type = "response")
glm.pred <- rep (0, 500)
glm.pred [ glm.prob > 0.5] = 1
table(data$y,glm.pred)
plot(data[1:2],col=glm.pred+1)

glm.fit <- glm(y~I(x1^2)+I(x2^2), data=data, family = binomial)
summary(glm.fit)
glm.prob <- predict(glm.fit,type = "response")
glm.pred <- rep (0, 500)
glm.pred [ glm.prob > 0.5] = 1
plot(data[1:2],col=glm.pred+1)
table(data$y,glm.pred)

##5-g
data$y <- as.factor(data$y)
svm.fit <- svm ( y ~ ., data = data , kernel = "linear",cost = .01 , scale = FALSE )
ypred <- predict ( svm.fit , data )
table ( predict = ypred , truth = data $y)
plot(svm.fit,data)
plot(data[1:2],col=ypred)

##5-h
###radial cost =1
svm.fit <- svm ( y ~ ., data = data, kernel = "radial",gamma = 1, cost = 1)
ypred <- predict ( svm.fit , data )
table ( predict = ypred , truth = data $y)
plot(svm.fit,data)
plot(data[1:2],col=ypred)
###radial cost =10000
svm.fit <- svm ( y ~ ., data = data, kernel = "radial",gamma = 1, cost = 10000)
ypred <- predict ( svm.fit , data )
table ( predict = ypred , truth = data $y)
plot(svm.fit,data)
plot(data[1:2],col=ypred)
###polynomial cost =1
svm.fit <- svm ( y ~ ., data = data, kernel = "polynomial",gamma = 1, cost = 1)
ypred <- predict ( svm.fit , data )
table ( predict = ypred , truth = data $y)
plot(svm.fit,data)
plot(data[1:2],col=ypred)

#9-7
##7-a
library(ISLR2)
data <- Auto
data$mpg <- as.factor(data$mpg>median(data$mpg))#tranform the mpg var to factor
summary(data)
##7-b

set.seed(1)
tune.out <- tune ( svm , mpg ~ ., data = data , kernel = "linear",ranges = list ( cost = c (0.001 , 0.01 , 0.1 , 1, 5, 10 , 100) ))
summary(tune.out)
#fit the best model cost = 0.1
bestmod <- svm ( mpg ~ ., data = data , kernel = "linear",cost = .01 , scale = FALSE )
ypred <- predict ( bestmod , data )
table ( predict = ypred , truth = data $mpg)
(9+23)/392#0.081632

##7-c
###radial
set.seed(1)
tune.out.radial <- tune ( svm , mpg ~ ., data = data,kernel = "radial",
                          ranges = list (cost = c(0.1 , 1, 10 , 100 , 1000) ,gamma = c(0.5 , 1, 2, 3, 4) ))
summary ( tune.out.radial )
#best model gamma=1, cost=10
bestmod.radial <- svm ( mpg ~ ., data = data, kernel = "radial",gamma = 1, cost = 10)
#summary(bestmod.radial)
ypred.radial <- predict ( bestmod.radial , data )
table ( predict = ypred.radial , truth = data $mpg)

###polynomial
set.seed(1)
tune.out.poly <- tune ( svm , mpg ~ ., data = data,kernel = "polynomial",
                        ranges = list (cost = c(0.1 , 1, 10 , 100 , 1000) ,gamma = c(0.5 , 1, 2, 3, 4) ))
summary ( tune.out.poly )
#best model gamma=0.5, cost=10
bestmod.poly <- svm ( mpg ~ ., data = data, kernel = "polynomial",gamma = 0.5, cost = 1)
#summary(bestmod.poly)
ypred.poly <- predict(bestmod.poly,data)
table ( predict = ypred.poly , truth = data $mpg)

##7-d
par(mfcol=c(2,2))
#linear
plot(bestmod,data, cylinders~weight)
plot(bestmod,data, displacement ~weight)
plot(bestmod,data, horsepower~displacement )
plot(bestmod,data, horsepower~weight )
#radial
plot(bestmod.radial,data, cylinders~weight)
plot(bestmod.radial,data, displacement ~weight)
plot(bestmod.radial,data, horsepower~displacement )
plot(bestmod.radial,data, horsepower~weight )
#poly
plot(bestmod.poly,data, cylinders~weight)
plot(bestmod.poly,data, displacement ~weight)
plot(bestmod.poly,data, horsepower~displacement )
plot(bestmod.poly,data, horsepower~weight )

