## exercise
library(ggplot2movies)
data(movies, package = "ggplot2movies")

#str(movies)
getmaxrate<-function(x){# input score return max score name
  #a=x[7:16]==max(x[7:16])
  a=x==max(x)
  names(x)[a]
  return(names(x)[a][1])
}
#demo function
movies[1,7:16]
getmaxrate(movies[1,7:16])

# do by for loop
r<-c()
for(i in 1:dim(movies)[1]){
  r<-c(r,getmaxrate(movies[i,7:16]))
}
table(r)
factor(r)

# do by apply function
result=apply(X = movies[,7:16], MARGIN = 1, FUN = function(x) getmaxrate(x))
result<-unlist(result)
tresult<-table(result)
table.ind<-c("r1","r2","r3","r4","r5","r6","r7","r8","r9","r10")
tresult[table.ind]
#plot
result_factor<-factor(result,levels = c("r1","r2","r3","r4","r5","r6","r7","r8","r9","r10"))
#levels(result_factor)<-list("1"="r1","2"="r2","3"="r3","4"="r4","5"="r5","6"="r6","7"="r7","8"="r8","9"="r9","10"="r10")
levels(result_factor)<-c(1,2,3,4,5,6,7,8,9,10)
table(result_factor)
plot(table(result))

ratings <- movies[ , 7:16]
popular <- apply(ratings, 1, FUN = function(x) which.max(x)  )
popular
plot(table(popular), xlab="Rating", ylab="Counts", main="The most popular rating")
