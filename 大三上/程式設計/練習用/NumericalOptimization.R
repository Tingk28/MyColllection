curve(expr = abs(x-3.5)+(x-2)^2, from = 1, to = 5, ylab="f(x)" )
myf <- function(x) abs(x-3.5)+(x-2)^2
phi <- (sqrt(5)+1)/2
ratio <- 1/phi
a <- 1
b <- 5
# Iteration #1
# Locate the interior points
x2 <- a + (b-a)*ratio
x1 <- b - (b-a)*ratio
myf(x1)
curve(expr = myf, from = 0, to = 5, ylab="f(x)" )
abline(v=a, col='red', lwd=2)
abline(v=b, col='red', lwd=2)
points(x = x1, y = myf(x1), col="red", pch=16)
points(x = x2, y = myf(x2), col="blue", pch=16)
text(x = x1, y = myf(x1)+0.5, paste( round(myf(x1),2) ), pos = 3)
text(x = x1, y = myf(x1), "x1", pos = 3)
text(x = x2, y = myf(x2)+0.5, paste( round(myf(x2),2) ), pos = 3)
text(x = x2, y = myf(x2), "x2", pos = 3)

a <- 1
b <- x2
curve(expr = myf, from = 0, to = 5, ylab="f(x)" )
abline(v=a, col='red', lwd=2)
abline(v=b, col='red', lwd=2)
# Locate the interior points
x1 <- b - (b-a)*ratio
x2 <- a + (b-a)*ratio
myf(x1)
myf(x2)
points(x = x1, y = myf(x1), col="red", pch=16)
points(x = x2, y = myf(x2), col="blue", pch=16)
text(x = x1, y = myf(x1)+0.5, paste( round(myf(x1),2) ), pos = 3)
text(x = x1, y = myf(x1), "x1", pos = 3)
text(x = x2, y = myf(x2)+0.5, paste( round(myf(x2),2) ), pos = 3)
text(x = x2, y = myf(x2), "x2", pos = 3)

MyGolden <- function(f, a, b, tol =10^(-8) ){
  phi <- (sqrt(5)+1)/2
  ratio <- 1/phi
  #ratio <- 2/(sqrt(5)+1)
  x1 <- b - (b-a)*ratio
  x2 <- a + (b-a)*ratio
  f1 <- f(x1)
  f2 <- f(x2)
  while ( abs(b-a) > tol) {
    if (f2 > f1) {
      b <- x2
      x2 <- x1
      f2 <- f1
      x1 <- b - (b-a)*ratio
      f1 <- f(x1)
    } else {
      a <- x1
      x1 <- x2
      f1 <- f2
      x2 <- a + (b-a)*ratio
      f2 <- f(x2)
    }
  }
  return( (a+b)/2 )
}
myf2<-function(x) (-x-4)^2
MyGolden(f = myf2, a = 1, b = 5)
library(cmna)
goldsectmin(f=myf,a=1,b=5,)


myf <- function(x) exp(-x)+x^4
curve(expr = myf, from = -1, to = 4)
# the first 6 steps
myfprime1 <- function(x) -exp(-x)+4*x^3
myfprime2 <- function(x) exp(-x)+12*x^2
x <- c(0.5, rep(NA, 6) )
xn <- x[1]
x[2] <- xn - myfprime1(xn)/myfprime2(xn)
for (i in 2:6){
  xn <- x[i]
  x[i+1] <- xn - myfprime1(xn)/myfprime2(xn)
}
x
cbind(x, fval=myf(x))

myf2<-function(x) (-x-4)^2
myFn <- function(x) abs(x-3.5)+abs(x-2)+abs(x-1)
curve(expr = myFn, from = 0, to = 3)
optim(par = 1.5, fn =myf2, method = "Brent", lower=1, upper=10,control=list$fnscale=-1)
