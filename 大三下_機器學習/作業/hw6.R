# 8.9
library(ISLR2)
data <- OJ
head(data)
dim(data)

## 9-a
set.seed(1)
train <- sample(1:nrow(data),800)
training_set <- data[train,]
test_set <- data[-train,]

##9-b
tree.oj <- tree(Purchase~.,data=training_set)
summary(tree.oj)
##9-c
tree.oj
##9-d
plot(tree.oj)
text(tree.oj,pretty=1)
##9-e
tree.pred <- predict ( tree.oj , test_set ,type = "class")
table ( tree.pred , test_set$Purchase )
(38+8)/270#17.03%
##9-f-h
set.seed(1)
cv.oj <- cv.tree(tree.oj, FUN = prune.misclass)
names(cv.oj)
cv.oj#dev is cross vaildatzion errors!!
## plot the pruning process
par(mfrow=c(1,3))
plot(cv.oj$size,cv.oj$dev,type='b')
plot(cv.oj$size,cv.oj$dev/800,type='b')
plot(cv.oj$k,cv.oj$dev,type='b')
##9-i-j
prune.oj <- prune.misclass ( tree.oj , best = 8)
plot ( prune.oj )
summary(prune.oj)
text ( prune.oj , pretty = 0)
## test the testing data
tree.pred <- predict ( prune.oj , test_set ,type = "class")
table ( tree.pred , test_set$Purchase )#the

#9-10
#10-a
data2 <- Hitters
summary(data2)#ori data have 59 rows have na 
dim(data2)#322*20
data2 <- data2[!is.na(data2$Salary),]
summary(data2)
dim(data2)#the new data have 322-59=263 rows
data2$Salary <- log(data2$Salary,base=10)

#10-b
train <- 1:200
training_set <- data2[train,]
test_set <- data2[-train,]

#10-c-d
library ( gbm )
set.seed (1)
lambda <- c(0.001,0.01,0.02,0.05,0.1,0.25,0.5,1,2,5,10,25,50,100,500,1000)
mse <- c()
for (i in lambda){
  boost.hitters <- gbm ( Salary ~ ., data = training_set ,distribution = "gaussian", n.trees = 1000 ,interaction.depth = 4,shrinkage =i )
  #summary(boost.hitters)
  #plot ( boost.hitters , i = "CAtBat")
  #plot ( boost.hitters , i = "CWalks")
  yhat.boost <- predict ( boost.hitters ,newdata = test_set, n.trees = 1000)
  mse <- c(mse,mean (( yhat.boost -  test_set$Salary) ^2))
  cat(i,'\t',mean (( yhat.boost -  test_set$Salary) ^2),'\n')
}
# when lambda >1 the testing MSE will increase significantly 
# so I redo it in smaller lambda
lambda <- 0.00001*(2^(1:16))
lambda <- c(lambda,1)
training_mse <- c()
testing_mse <- c()
for (i in lambda){
  boost.hitters <- gbm ( Salary ~ ., data = training_set ,distribution = "gaussian", n.trees = 1000 ,interaction.depth = 4,shrinkage =i )
  #summary(boost.hitters)
  
  yhat.boost_train <- predict ( boost.hitters ,newdata = training_set, n.trees = 1000)
  yhat.boost_test <- predict ( boost.hitters ,newdata = test_set, n.trees = 1000)
  training_mse <- c(training_mse,mean (( yhat.boost_train -  training_set$Salary) ^2))
  testing_mse <- c(testing_mse,mean (( yhat.boost_test -  test_set$Salary) ^2))
}
plot(x=lambda,y=training_mse,type='l',main='training error')
plot(x=lambda,y=testing_mse,type='l',main='testing error')



##10-e
### best subset method
library(leaps)
regfit.full <- regsubsets(Salary~.,data=training_set,nvmax = 19)
reg.summary <- summary(regfit.full)

par(mfrow=c(2,2))
plot ( reg.summary $ rss , xlab = " Number of Variables ",ylab = " RSS ", type = "l")
plot ( reg.summary $ adjr2 , xlab = " Number of Variables ", ylab = " Adjusted RSq ", type = "l")
which.max ( reg.summary $ adjr2 )#13
points (13 , reg.summary $ adjr2 [13] , col = " red ", cex = 2 ,pch = 20)
plot ( reg.summary $ cp , xlab = " Number of Variables ",ylab = "Cp", type = "l")
which.min ( reg.summary $ cp )#8
points (8 , reg.summary $ cp [8] , col = " red ", cex = 2,pch = 20)
which.min ( reg.summary $ bic )#5
plot ( reg.summary $ bic , xlab = " Number of Variables ", ylab = " BIC ", type = "l")
points (5 , reg.summary $ bic [5] , col = " red ", cex = 2,pch = 20)

#we choose the adj. r^2 for model selection. so the best model have 13 predictor
coef(regfit.full,13)
test.mat <- model.matrix(Salary~.,data = test_set)
pred <- test.mat[,names(coef(regfit.full,13))]%*%coef(regfit.full,13)
mean((test_set$Salary-pred)^2)#0.09416
#choose the model my cp
coef(regfit.full,8)
test.mat <- model.matrix(Salary~.,data = test_set)
pred <- test.mat[,names(coef(regfit.full,8))]%*%coef(regfit.full,8)
mean((test_set$Salary-pred)^2)#0.08835
#choose the model my bic
coef(regfit.full,5)
test.mat <- model.matrix(Salary~.,data = test_set)
pred <- test.mat[,names(coef(regfit.full,5))]%*%coef(regfit.full,5)
mean((test_set$Salary-pred)^2)#0.09395

##the 8 var have lowest testing MSE
##the pcr method in ch6
library (pls)
set.seed (1)
pcr.fit <- pcr ( Salary ~ ., data = training_set ,Scale = TRUE , validation = "CV")
validationplot ( pcr.fit , val.type = "MSEP")
summary(pcr.fit)
pcr.pred <- predict ( pcr.fit , test_set, ncomp = 4)
mean (( pcr.pred - test_set$Salary ) ^2)#0.09736
pcr.pred <- predict ( pcr.fit , test_set, ncomp = 18)
mean (( pcr.pred - test_set$Salary ) ^2)#0.09412

##10-f
boost.hitters <- gbm ( Salary ~ ., data = training_set ,distribution = "gaussian", n.trees = 1000 ,interaction.depth = 4 )
summary(boost.hitters)

##10-g
#bagging is a special case of a random forest with m = p
library ( randomForest )
set.seed (1)
bag.htiiers <- randomForest ( Salary ~ ., data = training_set , mtry = 19 , importance = TRUE )
bag.htiiers
yhat.bag <- predict ( bag.htiiers , newdata = test_set)
plot ( yhat.bag , test_set$Salary )
abline (0 , 1)
mean (( yhat.bag - test_set$Salary ) ^2)#0.04343
