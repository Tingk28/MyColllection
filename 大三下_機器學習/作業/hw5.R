#6-8
set.seed(1)
##6-a
x <- rnorm(100)
noise <- rnorm(100)
##6-b
#betas(1,2,3,4)
y <- 1+2*x+3*x^2+4*x^3+noise
#plot(y)
##6-c
data <- c()
for(i in 1:10){
  data <- cbind(data,x^i)
}
data <- as.data.frame(data)
data$y <- y
names(data) <- c("X1","X2","X3","X4","X5","X6","X7","X8","X9","X10","y")
library(leaps)
regfit.full <- regsubsets(y~.,data)
summary(regfit.full)
reg.summary <- summary(regfit.full)
##plots for model selection
regfit.plot <- function(models){
  reg.summary <- summary(models)
  par(mfrow=c(2,2))
  plot ( reg.summary $ rss , xlab = " Number of Variables ",ylab = " RSS ", type = "l")
  rss.min <- which.min ( reg.summary $ rss )
  points (rss.min , reg.summary $ rss [rss.min] , col = " red ", cex = 2 ,pch = 20)
  plot ( reg.summary $ adjr2 , xlab = " Number of Variables ", ylab = " Adjusted RSq ", type = "l")
  adjr2.max<- which.max ( reg.summary $ adjr2 )
  points (adjr2.max , reg.summary $ adjr2 [adjr2.max] , col = " red ", cex = 2 ,pch = 20)
  plot ( reg.summary $ cp , xlab = " Number of Variables ",ylab = "Cp", type = "l")
  cp.min<- which.min ( reg.summary $ cp )
  points (cp.min , reg.summary $ cp [cp.min] , col = " red ", cex = 2,pch = 20)
  plot ( reg.summary $ bic , xlab = " Number of Variables ", ylab = " BIC ", type = "l")
  bic.min<- which.min ( reg.summary $ bic )
  points (bic.min , reg.summary $ bic [bic.min] , col = " red ", cex = 2,pch = 20)
}

regfit.plot(regfit.full)

coef( regfit.full , 4)
coef( regfit.full , 3)

##6-d
regfit.fwd <- regsubsets(y~.,data,nvmax = 10,method ="forward" )
summary(regfit.fwd)
regfit.plot(regfit.fwd)
coef( regfit.fwd , 4)
coef( regfit.fwd , 3)

regfit.bwd <- regsubsets(y~.,data,nvmax = 10,method ="backward" )
summary(regfit.bwd)
regfit.plot(regfit.bwd)
coef( regfit.bwd , 4)
coef( regfit.bwd , 3)


fit.full <- lm(y~X1+X2+X3+X5,data,subset = train)
fitvalue <- predict(fit.full,data[test,])
mean((fitvalue - y[test])^2)

##6-e
data <- c()
for(i in 1:10){
  data <- cbind(data,x^i)
}
data <- as.data.frame(data)
#names(data) <- c("X1","X2","X3","X4","X5","X6","X7","X8","X9","X10")
grid <- 10^seq(10,-2,lengt=100)
set.seed(1)
train <- sample (c( TRUE , FALSE ) , nrow ( data ) ,replace = TRUE )
test <- (! train )
y.test <- y[test]
lasso.mod <- glmnet (data, y, alpha = 1,lambda = grid )
plot ( lasso.mod )
cv.out <- cv.glmnet(data[train,],y[train],alpha=1)
plot(cv.out)
bestlam <- cv.out$lambda.min
lasso.pred <- predict (lasso.mod , s = bestlam ,newx = data[test, ])
mean (( lasso.pred - y.test ) ^2)

out <- glmnet (data, y , alpha = 1, lambda = grid )
lasso.coef <- predict ( out , type = "coefficients",s = bestlam ) [1:10 , ]
lasso.coef[lasso.coef!=0]


## 6-f
#b0=1 b7=8
y=1+8*x^7+noise
### best subset
regfit.full <- regsubsets(y~.,data,nvmax = 10)
summary(regfit.full)
regfit.plot(regfit.full)

set.seed (1)
train <- sample (c( TRUE , FALSE ) , nrow ( data ) ,replace = TRUE )
test <- (! train )
regfit.best <- regsubsets(y~.,data=data[train,],nvmax=10)
test.mat <- model.matrix(y~.,data = data[test,])
val.errors <- rep(NA,10)
for(i in 1:10){
  coefi <- coef(regfit.best,id=i)
  pred <- test.mat[,names(coefi)]%*%coefi
  val.errors[i] <- mean((data$y[test]-pred)^2)
}
val.errors
which.min(val.errors)#2
coef(regfit.best,2)
###lasso
x <- model.matrix(y~.,data)[,-1]
y <- data$y
cv.out <- cv.glmnet(x[train,],y[train],alpha=1)
plot(cv.out)
bestlam <- cv.out$lambda.min
lasso.pred <- predict (lasso.mod , s = bestlam ,newx = x[test, ])
#lasso.pred2=2.254081+7.693891*x[test]^7
mean (( lasso.pred - y[test] ) ^2)
#mean (( lasso.pred - y[test] )/y[test])#MAPE 50%
out <- glmnet (data, y , alpha = 1, lambda = grid )
lasso.coef <- predict ( out , type = "coefficients",s = bestlam ) [1:10 , ]
lasso.coef[lasso.coef!=0]

#6-9
set.seed(1)
##9-a
data <- College
train <- sample (c( TRUE , FALSE ) , nrow ( data ) ,replace = TRUE )
test <- (! train )
x <- model.matrix(Apps~.,data)[,-1]
y <- data$Apps
##9-b
lm.fit <- lm(Apps~.,data = data,subset = train)
summary(lm.fit)
fitvalue <- predict(lm.fit,data[test,])
mean((fitvalue - data$Apps[test])^2)
##9-c
library(glmnet)
grid <- 10^seq(10,-2,lengt=100)
ridge.mod <- glmnet(x,y,alpha = 0,lambda = grid)#alpha=0 rdige =1 LASSO
## cross validation
set.seed (1)
ridge.mod <- glmnet (x[ train , ], y[ train ], alpha = 0,lambda = grid , thresh = 1e-12)
cv.out <- cv.glmnet (x[ train , ], y[ train ], alpha = 0)
summary(cv.out)
plot ( cv.out )
Sbestlam <- cv.out $ lambda.min
bestlam
ridge.pred <- predict ( ridge.mod , s = bestlam ,newx = x[ test , ])
mean (( ridge.pred - y[test] ) ^2)
out <- glmnet (x , y , alpha = 0)
predict ( out , type = "coefficients", s = bestlam ) [1:18 , ]

##9-d LASSO
lasso.mod <- glmnet (x[ train , ], y[ train ], alpha = 1,lambda = grid )
plot ( lasso.mod )
set.seed (1)
cv.out <- cv.glmnet (x[ train , ], y[ train ], alpha = 1)
plot ( cv.out )
bestlam <- cv.out $ lambda.min
bestlam
lasso.pred <- predict ( lasso.mod , s = bestlam ,newx = x[ test , ])
mean (( lasso.pred - y[test] ) ^2)
out <- glmnet (x , y , alpha = 1, lambda = grid )
lasso.coef <- predict ( out , type = "coefficients",s = bestlam ) [1:18 , ]
lasso.coef

##9-e PCR
set.seed (1)
pcr.fit <- pcr (Apps ~ ., data = data , subset = train ,Scale = TRUE , validation = "CV")
summary(pcr.fit)
pcr.fit$
validationplot ( pcr.fit , val.type = "MSEP")
pcr.pred <- predict ( pcr.fit , x[ test , ], ncomp = 16)
mean (( pcr.pred - y[test] ) ^2)
pcr.fit <- pcr (y ~ x , scale = TRUE , ncomp = 16)
summary ( pcr.fit )

##9-f
set.seed (1)
pls.fit <- plsr (Apps ~ ., data = data , subset = train ,Scale = TRUE , validation = "CV")
summary ( pls.fit )
validationplot ( pls.fit , val.type = "MSEP")
pls.pred <- predict ( pls.fit , x[ test , ], ncomp = 14)
mean (( pls.pred - y[test] ) ^2)
pls.fit <- plsr ( Salary ~ ., data = Hitters , scale = TRUE ,ncomp = 14)
summary ( pls.fit )




