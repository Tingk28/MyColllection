'''for(i in 1:5){
  for(j in 1:5){
    h<-c(h,(i+j-1)^-1)
  }
}
h
M3<-matrix(h,nrow=5,ncol=5)
M3

a0<-rep(1:5,5)
'''
h<-c()
for(i in 1:5){
  for(j in i:(i+4)){
    h<-c(h,j)
  }
}
h
M3<-matrix(h,nrow=5,ncol=5)
M3



x <- 1:20
M1 <- matrix(data = x, nrow = 4, ncol = 5)
M1
colnames(M1) <- c("c1", "c2", "c3", "c4", "c5") # set the column names of a matrix
rownames(M1) <- c("r1", "r2", "r3", "r4") # set the row names of a matrix
colnames(M1);rownames(M1)
typeof(dimnames(M1))
M2 <- matrix(data = x, nrow = 4, ncol = 5, byrow = TRUE)
M2
M2[,6]
M2[6]


a <- c(1, 3, 2, 3, 7)
A <- matrix(data = a, ncol = 1)
a
A
## ¦V¶q­¼ªk
A <- matrix(data = c(1, 3, 2, 2, 8, 9), nrow = 3, ncol = 2)
B <- matrix(data = c(5, 8, 4, 2), nrow = 2, ncol = 2)
A %*% B
C<-c()
for(i in 1:2){
  C<-cbind(C,A %*% B[,i])
}
C

diag( diag(x = c(1, 3, 4)) )

# obtain the lower triangular matrix
M1LowerTri <- M1 
M1LowerTri[upper.tri(x = M1)] <- 0
M1LowerTri

M4 <- matrix(data = c(1, 2, 3, 4), nrow = 2, ncol = 2)
inv_M4 <- solve(M4)
M4 %*% inv_M4

a<-c(1,5,-2,1,2,-1,3,6,-3)
A<-matrix(a,nrow=3)
A%*%A%*%A

x <- cbind(c(1,-1), c(-1,1))
x
MyEig <- eigen(x)
MyEig$values #  eigenvalues of matrix

A <- matrix(data = c(1,0.8,0.8,1), nrow = 2, ncol = 2)
A
MyEig <- eigen(A)
Q <- MyEig$vectors
Lambda <- diag( MyEig$values)
Q %*% Lambda %*% solve(Q)



A<- matrix(data=c(1,4,0,-2),nrow=2,ncol=2)
MyEig <- eigen(A)
Q <- MyEig$vectors
Lambda <- diag( MyEig$values)
Q %*% Lambda %*% solve(Q)
MyEig$values
det(A)



A <- matrix(data = c(1,2,3,4,
                     5,6,5,4,
                     3,2,1,2,
                     -3,2,5,20), ncol = 4)
library(matrixcalc)
L <- lu.decomposition(x = A)$L
U <- lu.decomposition(x = A)$U
L %*% U
x <- matrix(c(8,5,5,4), nrow = 2)
x_chol_L <- t(chol(x = x))

A_QR <- qr(x = A)
Q <- qr.Q(qr = A_QR) # find Q
Q1 <- qr.Q(qr = A_QR, complete = TRUE) # find Q
R <- qr.R(qr = A_QR) # find R
Q %*% t(Q)

B <- matrix(data = c(1, 2, 2, 1), nrow = 2)
B_QR <- qr(x = B)
B.Q <-  qr.Q(qr = B_QR, complete = TRUE)
B.R <-  qr.R(qr = B_QR, complete = TRUE)
R_cofactor <- matrix(data = c(B.R[2,2], -B.R[2,1],
                              -B.R[1,2], B.R[1,1]), nrow = 2)
B.R_inv <- R_cofactor/ det(B.R) # R^-1
B.R_inv %*% B.R # R^-1 R


A<-diag(c(1:10))
A^100

matrixpower<-function(A,power){
  MyEig <- eigen(A)
  Q <- MyEig$vectors
  Lambda <- diag( MyEig$values)
  Q %*% Lambda %*% solve(Q)
  return(Q %*% Lambda^power%*% solve(Q))
}

A <- matrix(data = c(1,0.8,0.8,1), nrow = 2, ncol = 2)
matrixpower(A,3)


'''
x <- c(1.00, 2.00, 3.00, 4.00, 5.00)
y <- c(3.70, 4.20, 4.90, 5.70, 6.00)
plot(x = x, y = y)
xbar <- mean(x)
ybar <- mean(y)
beta.hat <- sum( (x-xbar)*(y-ybar) ) / sum( (x-xbar)^2 )
alpha.hat <- ybar - beta.hat*xbar
fit <- lm(y~x)
coef(fit)
X <- cbind( rep(x = 1, 5), x)

solve((t(X)%*%X))%*%t(X)%*%Y

Y <- matrix(data = y, nrow = 5, ncol = 1)
crossprod(x = X, y = X)
'''

