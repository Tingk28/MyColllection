fx<- function(x){x^3+2*x^2-7}
fx_prime<-function(x){3*x^2+4*x}


Newton_method <- function(fx,fx_prime,tor=10^-8,x0=0.1){
  point<- c(x0)
  equ<- c()
  iter<-0
  while (abs(fx(x0))>tor){
    x0<- x0-fx(x0)/fx_prime(x0)
    point<-c(point,x0)
    iter<-iter+1
  }
  print(equ)
  plot(point,type='l',main="Plot of iteration",xlab="times",ylab="x0")
  curve(expr = x^3+2*x^2-7,main="f(x)",from=-2,to=2)
  return(x0)
}

Newton_method(fx,fx_prime)


My_func <- function(lambda=100){
  x <- 0
  sum <- 0
  k <- (x-lambda)^2
  poi_pro <- x*(exp(-1*lambda)*lambda^x/factorial(x))
  poi_var <- k*(exp(-1*lambda)*lambda^x/factorial(x))
  #print(poi_pro)
  while (poi_pro > 10^-10){
    poi_pro <- x*(exp(-1*lambda)*lambda^x/factorial(x))
    x <- x+1
    sum <- sum +poi_pro
  }
  cat("mean =", sum,"variance =", poi_var)
}
My_func(100)
