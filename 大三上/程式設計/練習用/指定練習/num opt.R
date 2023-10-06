# numerical Opt

## 1 
f<- function(x) abs(x-3.2)+abs(x-3.5)+abs(x-2)+abs(x-1)

f(2)
curve(f,from=-3,to=6)


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
MyGolden(f = f, a = -3, b = 20)
MyGoldenWithPlot(f = f, a = -3, b = 20)


## 2

mid<-function(x){
  mean<-mean(x)
  output<-abs(a-mean) 
  return(a[which.min(output)])
}
a<-c(3,7,9,12,15)
median(a) # R build in function
mid(a) # self-writed function

b<-c(3,7,9,12,18,21)
median(b) # R build in function
mid(b) # self-writed function

## 3
my_dnorm<-function(x) -1*dnorm(x,sd=1,mean=5)
MyGolden(f = my_dnorm, a = -6, b = 6)


MyGoldenWithPlot <- function(f, a, b, tol =10^(-8) ){
  phi <- (sqrt(5)+1)/2
  ratio <- 1/phi
  #ratio <- 2/(sqrt(5)+1)
  x1 <- b - (b-a)*ratio
  x2 <- a + (b-a)*ratio
  f1 <- f(x1)
  f2 <- f(x2)
  
  while ( abs(b-a) > tol) {
    curve(f,from=a - (b-a)*ratio,to=b + (b-a)*ratio)
    abline(v=a,col="Red")
    abline(v=b,col="Blue")
    Sys.sleep(1)
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
