## 1
A<-matrix(c(1,2,3,4,5,2,1,2,3,4,3,2,1,2,3,4,3,2,1,2,5,4,3,2,1),ncol=5)
A
ans<-matrix(c(7,-1,-3,5,17),ncol=1)
solve(A)%*%ans



##2
#a
A<-matrix(c(1,5,-2,1,2,-1,3,6,-3),nrow=3)
A%*%A%*%A
#b
A[,3]<-A[,2]+A[,3]
A

#3
set.seed(123)
n <- 5
X <- cbind( rep(1, n), rnorm(n))
X
#a
H<-X%*%solve(t(X)%*%X)%*%t(X)
H
#b
MyEig <- eigen(H)
cat("eigenvalues: ")
MyEig$values
cat("eigenvactors: ")
MyEig$vectors
##C
ans=diag(H)
sum(ans)
##D
H%*%H%*%H
H
## the H and H^3 are the same

## 4
#a
A<-matrix(c(0,-1,2,1,0,3,2,3,0),ncol=3)
A
##b
det(A)
##c
sum(diag(A))
##d
I<-diag(c(1,1,1))
I
det(I+A)
## because det(I+A) !=0, the matrix I+A is invertible

##5
A<-matrix(c(1,2,3,4,5,2,1,2,3,4,3,2,1,2,3,4,3,2,1,2,5,4,3,2,1),ncol=5)
det(A) #48
det(t(A))#48
B <- matrix(data = c(1,2,3,4,5,6,5,4,3,2,1,2,-3,2,5,20), ncol = 4)
det(B) #-144
det(t(B))#-144
C <- matrix(c(8,5,5,4), nrow = 2)
det(C)#7
det(t(C))#7

##6
P<-matrix(c(0.85,0.1,0.25,0.1,0.8,0.15,0.05,0.1,0.6),ncol=3)
#a
sum(P[1,])
sum(P[2,])
sum(P[3,])
# the sum of each row equal 1
#b
matrixpower<-function(A,power){
  MyEig <- eigen(A)
  Q <- MyEig$vectors
  Lambda <- diag( MyEig$values)
  Q %*% Lambda %*% solve(Q)
  return(Q %*% Lambda^power%*% solve(Q))
}
matrixpower(P,2)#n=2
matrixpower(P,3)#n=3
matrixpower(P,10)#n=10
matrixpower(P,50)#n=50
## yes it is emerging
#c
X<-matrix(c(.49,.36,.15), nrow = 3)
I<-diag(c(1,1,1))
(P-I)%*%X

