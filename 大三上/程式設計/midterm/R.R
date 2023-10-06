#P 0
#a  Write a R program to get all prime numbers up to a given number (based on the sieve of Eratosthenes).
'''x<-30 # given number
ans=c()
for(i in 1:x){
  print(i)
  if(i==1){
    next
  }else if (i>=2){
    ans=c(2)
  }
  for(j in ans){
    print(j)
    if(i%%j==0){
      break
    }
    cat("in")
    ans=c(ans,i)
  }
}
ans
#1
n<-100
x<-.61
k<-1:n
a<-(x^k)/k
suma=sum(a)
b<--1*log(base=exp(1),(1-x))
cat("n=",n,"x=",x)
cat("sigma:x^k/k=",suma,"\nlog...=",b,"\n")
#2
n<-200
x<-.61
k<-1:n
a<-(x^k)/k
suma=sum(a)
b<--1*log(base=exp(1),(1-x))
cat("n=",n,"x=",x)
cat("sigma:x^k/k=",suma,"\nlog...=",b,"\n")


#3
n<-100
x<-.71
k<-1:n
a<-(x^k)/k
suma=sum(a)
b<--1*log(base=exp(1),(1-x))
cat("n=",n,"x=",x)
cat("sigma:x^k/k=",suma,"\nlog...=",b,"\n")
#3
n<-200
x<-.71
k<-1:n
a<-(x^k)/k
suma=sum(a)
b<--1*log(base=exp(1),(1-x))
cat("n=",n,"x=",x)
cat("sigma:x^k/k=",suma,"\nlog...=",b,"\n")

N <- 30
Fibonacci <- numeric(N)
Fibonacci[1] <- 1
Fibonacci[2] <- 1
for (n in 3:N) Fibonacci[n] <- Fibonacci[n-1] + Fibonacci[n-2]
Fibonacci#f n
n_f<-c(1,Fibonacci[1:29])
n_f#f n-1
ratio=Fibonacci/n_f
plot(ratio)
# yes,it appear to be converging
(1+sqrt(5))/2
abline(h = (1+sqrt(5))/2, lwd=2, col="red", xlab="n", ylab="Ratio")
# yes,it appear to be converging to the ratio in (a)

#3b
pr<-function(x,p=.76){(1-p)^(x-1)*p}
x<-1
mean<-0
repeat{
  mean<-mean+x*pr(x)
  if(pr(x)<10^-20)break
  x<-x+1
}
mean'''

'''
#Q4
it <- 3
x0 <- 0.1 # initial guess
mycos<-c(x0,cos(x0)-x0*exp(x0))
while(abs(mycos[it-1]-mycos[it])>0.005){
  mycos<-c(mycos,cos(mycos[it-1])-mycos[it-1]*exp(mycos[it-1]))
  print(it)
  it<-it+1
  
}
plot(mycos)'''


#Q5
Myplot<-function(location, upper = TRUE){
  point<-exp(-1*seq(0,10,0.05))
  if(upper){
    col_range<- seq(location, 3, 0.05)
    header<-paste("Pr(X>",as.character(location),"), X ~ exp(1)")
  }else if(upper==FALSE){
    col_range<- seq(-3, location, 0.1)
    header<-paste("Pr(X<",as.character(location),"), X ~ N(0, 1)")
  }
  plot(seq(0,10,0.05),point,type="l")
  polygon(c(col_range,rev(col_range)),c(exp(-1*col_range)),rep(0,length(col_range))),col="green",border ="green" )
}
Myplot(location = 1, upper = TRUE)
Myplot(location = 5, upper = FALSE)



'''#(a)
it <- 3
x0 <- 0.1 # initial guess
mycos<-c(x0,cos(x0)-x0*exp(x0))
while(abs(mycos[it-1]-mycos[it])>0.005){
  mycos<-c(mycos,cos(mycos[it-1])-mycos[it-1]*exp(mycos[it-1]))
  print(it)
  it<-it+1
  
}
plot(mycos)'''