x0 <- 0.1
x <- x0
myf <- -x+(1-(1+x)^-20)/19
num.iter <- 0
tempx<-c()
tolerance <- 0.00000000001
while ( abs(myf) > tolerance){
  myf_prime <- -1+20/(19*(x+1)^21)
  x <- x - myf/myf_prime
  myf <- -x+(1-(1+x)^-20)/19
  num.iter <- num.iter + 1
  tempx<-c(tempx,x)
}
x
plot(tempx,type='l',ylab='x',xlab='times')
