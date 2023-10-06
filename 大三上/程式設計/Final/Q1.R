#1
X<-matrix(c(  1,1,1,1,1,-.56,-.43,-.62,.57,-1.48),ncol=2)
X
#a
H=X%*%solve(t(X)%*%X)%*%t(X)
H
E<-eigen(H)
print("eigenvalue")
E$values
print("eigenvector")
E$vectors
#c
sum(E$values)
sum(diag(H))
# both equal 2

#d
E$vectors%*%diag(E$values)^8%*%solve(E$vectors)