#4.13
library(ISLR2)
library(MASS)
#Weekly
dim(Weekly)
head(Weekly)
attach(Weekly)
##13-a
summary(Weekly)
tail(Weekly)
plot(Weekly$Volume)
#plot(Weekly$Lag1)
min<-Weekly$Lag1< -15
Weekly$Year[min]
Weekly[900:1000,]

##13-b
glm.fits<-glm(Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume ,data = Weekly , family = binomial)
summary(glm.fits)

##13-c
glm.probs<-predict(glm.fits,Weekly,type="response")
glm.pred <- rep ("Down", 1089)
glm.pred [ glm.probs > .5] <- "Up"
table(glm.pred,Weekly$Direction)
mean(glm.pred==Weekly$Direction)
430/(430+54)
48/(48+557)

##13-d
train<-Weekly$Year<2009
Weekly.0910<-Weekly[!train,]
Direction.0910<-Weekly$Direction[!train]
glm.fits<-glm(Direction ~Lag2,data = Weekly , family = binomial,subset = train)
# summary(glm.fits)
glm.probs<-predict(glm.fits,Weekly.0910,type="response")
glm.pred <- rep ("Down", 104)
glm.pred [ glm.probs > .5] <- "Up"
table(glm.pred,Direction.0910)
mean(glm.pred==Direction.0910)

##13-e
lda.fit<-lda(Direction ~Lag2,data = Weekly ,subset = train)
lda.fit
#plot(lda.fit)
lda.probs<-predict(lda.fit,Weekly.0910,type="response")
lda.class<- lda.probs$class
table(lda.class,Direction.0910)
mean(lda.class==Direction.0910)

##13-f
qda.fit<-qda(Direction ~Lag2,data = Weekly ,subset = train)
qda.fit
#plot(qda.fit)
qda.probs<-predict(qda.fit,Weekly.0910,type="response")
qda.class<- qda.probs$class
table(qda.class,Direction.0910)
mean(qda.class==Direction.0910)

##13-g
library(class)
train.X<-data.frame(Weekly$Lag2[train])
test.X<-data.frame(Weekly.0910$Lag2)
train.Direction<-Weekly$Direction[train]
set.seed(1234)
knn.pred<-knn(train=train.X,test=test.X,cl=train.Direction,k=1)
table(knn.pred,Direction.0910)
mean(knn.pred==Direction.0910)
##13-h
library(e1071)
nb.fit<-naiveBayes(Direction ~Lag2,data = Weekly ,subset = train)
nb.fit
nb.class<-predict(nb.fit, Weekly.0910)
table(nb.class,Direction.0910)
mean(nb.class==Direction.0910)

##13-i

##13-j
###knn 3 55.7%
knn.pred<-knn(train=train.X,test=test.X,cl=train.Direction,k=3)
table(knn.pred,Direction.0910)
mean(knn.pred==Direction.0910)

##trying use lag 1 2 as predictor
###GLM
glm.fits<-glm(Direction ~Lag1+Lag2,data = Weekly , family = binomial,subset = train)
glm.probs<-predict(glm.fits,Weekly.0910,type="response")
glm.pred <- rep ("Down", 104)
glm.pred [ glm.probs > .5] <- "Up"
table(glm.pred,Direction.0910)
mean(glm.pred==Direction.0910)

##LDA
lda.fit<-lda(Direction ~Lag1+Lag2,data = Weekly ,subset = train)
lda.fit
lda.probs<-predict(lda.fit,Weekly.0910,type="response")
lda.class<- lda.probs$class
table(lda.class,Direction.0910)
mean(lda.class==Direction.0910)

##QDA
qda.fit<-qda(Direction ~Lag1+Lag2,data = Weekly ,subset = train)
qda.fit
#plot(qda.fit)
qda.probs<-predict(qda.fit,Weekly.0910,type="response")
qda.class<- qda.probs$class
table(qda.class,Direction.0910)
mean(qda.class==Direction.0910)

##KNN
library(class)
test.X <- cbind ( Lag1 , Lag2 ) [! train , ]
train.X <- cbind ( Lag1 , Lag2 )[ train , ]
train.Direction <- Direction [ train ]
set.seed(1234)
knn.pred<-knn(train=train.X,test=test.X,cl=train.Direction,k=3)
table(knn.pred,Direction.0910)
mean(knn.pred==Direction.0910)
##NB
library(e1071)
nb.fit<-naiveBayes(Direction ~Lag1+Lag2,data = Weekly ,subset = train)
nb.fit
nb.class<-predict(nb.fit, Weekly.0910)
table(nb.class,Direction.0910)
mean(nb.class==Direction.0910)

##trying use lag 1 2 and volume as predictor
###GLM
glm.fits<-glm(Direction ~Lag1+Lag2+Volume,data = Weekly , family = binomial,subset = train)
glm.probs<-predict(glm.fits,Weekly.0910,type="response")
glm.pred <- rep ("Down", 104)
glm.pred [ glm.probs > .5] <- "Up"
table(glm.pred,Direction.0910)
mean(glm.pred==Direction.0910)

##LDA
lda.fit<-lda(Direction ~Lag1+Lag2+Volume,data = Weekly ,subset = train)
lda.probs<-predict(lda.fit,Weekly.0910,type="response")
lda.class<- lda.probs$class
table(lda.class,Direction.0910)
mean(lda.class==Direction.0910)

##QDA
qda.fit<-qda(Direction ~Lag1+Lag2+Volume,data = Weekly ,subset = train)
qda.probs<-predict(qda.fit,Weekly.0910,type="response")
qda.class<- qda.probs$class
table(qda.class,Direction.0910)
mean(qda.class==Direction.0910)

##KNN
library(class)
test.X <- cbind ( Lag1 , Lag2 ,Volume) [! train , ]
train.X <- cbind ( Lag1 , Lag2 ,Volume)[ train , ]
train.Direction <- Direction [ train ]
set.seed(1234)
knn.pred<-knn(train=train.X,test=test.X,cl=train.Direction,k=1)
table(knn.pred,Direction.0910)
mean(knn.pred==Direction.0910)
##NB
library(e1071)
nb.fit<-naiveBayes(Direction ~Lag1+Lag2+Volume,data = Weekly ,subset = train)
nb.fit
nb.class<-predict(nb.fit, Weekly.0910)
table(nb.class,Direction.0910)
mean(nb.class==Direction.0910)


##trying use lag 1as predictor
###GLM
glm.fits<-glm(Direction ~Lag1,data = Weekly , family = binomial,subset = train)
glm.probs<-predict(glm.fits,Weekly.0910,type="response")
glm.pred <- rep ("Down", 104)
glm.pred [ glm.probs > .5] <- "Up"
table(glm.pred,Direction.0910)
mean(glm.pred==Direction.0910)

##LDA
lda.fit<-lda(Direction ~Lag1,data = Weekly ,subset = train)
lda.probs<-predict(lda.fit,Weekly.0910,type="response")
lda.class<- lda.probs$class
table(lda.class,Direction.0910)
mean(lda.class==Direction.0910)

##QDA
qda.fit<-qda(Direction ~Lag1,data = Weekly ,subset = train)
qda.probs<-predict(qda.fit,Weekly.0910,type="response")
qda.class<- qda.probs$class
table(qda.class,Direction.0910)
mean(qda.class==Direction.0910)

##KNN
library(class)
train.X<-data.frame(Weekly$Lag1[train])
test.X<-data.frame(Weekly.0910$Lag1)
train.Direction<-Weekly$Direction[train]
set.seed(1234)
knn.pred<-knn(train=train.X,test=test.X,cl=train.Direction,k=1)
table(knn.pred,Direction.0910)
mean(knn.pred==Direction.0910)
##NB
library(e1071)
nb.fit<-naiveBayes(Direction ~Lag1,data = Weekly ,subset = train)
nb.class<-predict(nb.fit, Weekly.0910)
table(nb.class,Direction.0910)
mean(nb.class==Direction.0910)
