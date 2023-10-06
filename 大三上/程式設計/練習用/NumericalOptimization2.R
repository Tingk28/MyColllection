x<-c(22.0,23.9,20.9,23.8,25.0,24.0,21.7,23.8,22.8,23.1,23.1,23.5,23.0,23.0)
x.bar<-mean(x) # sample mean
x.bar
xbar <- mean(x)
#the likelihood function
lnL<-function(alpha,x){
  n<-length(x)
  x.bar<-mean(x)
  beta.hat<-x.bar/alpha
  prod( dgamma(x,shape=alpha, scale=(x.bar/alpha) ))
}
alpha.hat<-optimize(lnL,c(0.0001, 800), x=x, maximum=T)
alpha.hat

x <- 0:3
y <- 0:3
c <- 10
plot(x = x, y = y, type = "n", xlab="x1", ylab="x2", main=paste("C =",c))
abline(a = 2, b = -1, col="green")
abline(a = 3/2, b = -1/2, col="blue")
abline(a = c/8, b = -5/8, lty=2, col="red")
legend("topright", c("Const. 1", "Const. 2"), col=c("green", "blue"), lty =1, bty="n")

#install.packages(c("lpSolve", "Rtools"))
library(lpSolve)
res<-lp(objective.in = c(5,8),
        const.mat = matrix(c(1,1,1,2), nrow = 2),
        const.rhs = c(2,3), const.dir = c(">=", ">="), 
        direction = "min")
res
res$solution

#install.packages(c("lpSolve", "Rtools"))
library(lpSolve)
res<-lp(objective.in = c(5,8),
        const.mat = matrix(c(1,1,1,2), nrow = 2),
        const.rhs = c(2,3), const.dir = c("<=", "="), direction = "max")
res
res$solution

