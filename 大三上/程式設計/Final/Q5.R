data<-mtcars
data
##a
apply(X=data,2,FUN=max)
lapply(X=data,2,FUN=max)
sapply(X=data,2,FUN=max)

## b
MyCheck <- function(x, threshold=50) x > threshold
Mythreshold<-function(data,threshold){
  #temp<-apply(X=data,MARGIN = 2,FUN=function(x) MyCheck(x,threshold))
  result<-sum(MyCheck(data,threshold))
  return(result)
}
Mythreshold(data,50)

## c
pokemon<-read.csv("pokemon.csv")
pokemon

#ind=as.factor(pokemon$Type.1)
#ind=levels(as.factor(pokemon$Type.1))

tapply(X = pokemon$HP, INDEX = pokemon$Type.1, FUN = function(x) Mythreshold(x,30))
tapply(X = pokemon$HP, INDEX = pokemon$Type.1, FUN = function(x){ sum(x>30)})

