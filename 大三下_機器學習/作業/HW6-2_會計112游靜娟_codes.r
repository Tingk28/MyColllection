#8.9
install.packages("tree")
library ( tree )
install.packages("ISLR2 ")
library ( ISLR2 )
attach ( OJ )
View(OJ)

##a
set.seed (1)
train <- sample (1: nrow ( OJ ) , 800)
test <- OJ [- train , ]


##b
tree <- tree ( Purchase ~ . , OJ)
summary ( tree )

##c
tree

##d
plot ( tree )
text ( tree , pretty = 0 , cex = 0.6)

##e
set.seed(1)
tree.pred <- predict ( tree , test ,
                       type = "class")
table ( tree.pred , High.test )
(7+36)/(7+36+159+68)

##f
set.seed (1)
cv.OJ <- cv.tree ( tree , FUN = prune.misclass )
names ( cv.OJ )
cv.OJ

##g
plot ( cv.OJ $ size , cv.OJ $ dev  , type = "b")

##h
prune.OJ <- prune.misclass ( tree , best = 6)
plot ( prune.OJ )
text ( prune.OJ , pretty = 0)

##i
tree.pred.prune <- predict ( prune.OJ , test ,
                       type = "class")

##j
summary(prune.OJ)

##k
table ( tree.pred.prune , High.test )

#8.10
install.packages("MASS")
library(MASS)
install.packages("randomForest")
library(randomForest)

##a
View(Hitters)
Hitters = na.omit(Hitters)
Hitters$Salary = log(Hitters$Salary)

##b
train = 1:200
hitters.train = Hitters[train,]
hitters.test = Hitters[-train,]

##c
install.packages("gbm")
library(gbm)
set.seed(1)
pows = seq(-10, -0.2, by = 0.1)
lambdas = 10^pows
train.err = rep(NA, length(lambdas))
for (i in 1:length(lambdas)) {
  boost.hitters = gbm(Salary ~ ., data = hitters.train, distribution = "gaussian", n.trees = 1000, shrinkage = lambdas[i])
  pred.train = predict(boost.hitters, hitters.train, n.trees = 1000)
  train.err[i] = mean((pred.train - hitters.train$Salary)^2)
}
plot(lambdas, train.err, type = "b", xlab = "Shrinkage values", ylab = "Training MSE")


##d
set.seed(1)
test.err <- rep(NA, length(lambdas))
for (i in 1:length(lambdas)) {
  boost.hitters = gbm(Salary ~ ., data = hitters.train, distribution = "gaussian", n.trees = 1000, shrinkage = lambdas[i])
  yhat = predict(boost.hitters, hitters.test, n.trees = 1000)
  test.err[i] = mean((yhat - hitters.test$Salary)^2)
}
plot(lambdas, test.err, type = "b", xlab = "Shrinkage values", ylab = "Test MSE")

##e
install.packages("glmnet")
library(glmnet)
fit1 = lm(Salary ~ ., data = hitters.train)
pred1 = predict(fit1, hitters.test)
mean((pred1 - hitters.test$Salary)^2)
x = model.matrix(Salary ~ ., data = hitters.train)
x.test = model.matrix(Salary ~ ., data = hitters.test)
y = hitters.train$Salary
fit2 = glmnet(x, y, alpha = 0)
pred2 = predict(fit2, s = 0.01, newx = x.test)
mean((pred2 - hitters.test$Salary)^2)

##f
boost.hitters <- gbm(Salary ~ ., data = hitters.train, distribution = "gaussian", n.trees = 1000, shrinkage = lambdas[which.min(test.err)])
summary(boost.hitters)

##g
set.seed(1)
bag.hitters <- randomForest(Salary ~ ., data = hitters.train, mtry = 19, ntree = 500)
yhat.bag <- predict(bag.hitters, newdata = hitters.test)
mean((yhat.bag - hitters.test$Salary)^2)