'''k<-16
lamba<-20
pois <- (exp(-1*lamba)*lamba^k)/factorial(k)
accu<-0
P=c()
while(pois>10^-10){
  accu<-accu+pois
  k<-k+1
  pois<- (exp(-1*lamba)*(lamba^k))/factorial(k)
  P<-c(P,pois)
}
plot(P,type='l')
accu'''
score=95
if(score<60){cat("F")
}else if (score<70){cat('D')
}else if (score<80){cat('C')
}else if (score<90){cat('B')
}else{cat('A')
}
