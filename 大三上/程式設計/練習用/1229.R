library(microbenchmark)
x <- seq(1, 100000)
x <- x + 1
for (i in 1:length(x) ) x[i] <- x[i]+1
# We have many function calls in for loop
microbenchmark( x+1,  for (i in 1:length(x) ) x[i] <- x[i]+1)

monte_carlo <- function(B) {
  result <- 0
  for (i in seq_len(B)) {
    u1 <- runif(1)
    u2 <- runif(1)
    if (u1 ^ 3 > u2)
      result <- result + 1
  }
  return(result / B)
}
B <- 10^6
system.time( monte_carlo(B = B) )

set.seed(1234)
y <- rnorm(100)
type <- sample(c("Small", "Medium", "Large"), 
               size = 100, prob = c(0.2, 0.3, 0.5), replace = TRUE )
boxplot(y~type)
type.f <- factor(type, levels = c( "Large","Small", "Medium") )
boxplot(y~type.f)

library(compiler)
Myxbar <- function(x) {
  xbar <- 0
  n <- length(x)
  for (i in seq_len(n))
    xbar <- xbar + x[i] / n
  xbar
}
cmp_Myxbar <- cmpfun(Myxbar)
cmp_Myxbar

library(gamclass)
data(FARS)
dim(FARS)
apply(FARS[3], 2, mean)
