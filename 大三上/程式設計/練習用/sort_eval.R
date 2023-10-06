mySort.1 <- function(x,increase=1){
  sign=""
  if (increase) {
    sign<-">"
  }else{
    sign="<"
  }
  n <- length(x)-1
  if (n==0) {
    return(x)
  } else {
    for (k in 1:n) {
      for (j in 1:(n-k+1)) {
        cd<-paste("x[j]",sign,"x[j+1]")
        if (eval(parse(text=cd))){
          save <- x[j]
          x[j] <- x[j+1]
          x[j+1] <- save
        }
      }
    }
    return(x)
  }
}
mySort.1( c(5, 3, 1, 9, 8, 2, 4, 7) ,1)
mySort.1( c(5, 3, 1, 9, 8, 2, 4, 7) ,0)
