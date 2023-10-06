choose(52, 5) 
n.heads <- 0:10
CoinTossDist <- dbinom(x = n.heads, size = 10, prob = 0.5)
cbind(x=n.heads, p=CoinTossDist)

sum(n.heads*CoinTossDist)
sum(n.heads^2*CoinTossDist)- ( sum(n.heads*CoinTossDist) )^2
pbinom

set.seed(1234)
n.tosses <- rbinom(n = 1000, size = 1, prob = 0.5)
prob.heads <- cumsum(n.tosses)/1:1000
plot(x = 1:1000, y = prob.heads, type = "l", main = "Proportion of Heads in 1000 simulated coin tosses")
abline(h = 0.5)

n.deaths <- 0:30
deathsDist <- dpois(x = n.deaths, lambda = 12.7)
plot(x = n.deaths, y = deathsDist, type="h", 
     xlab="Number of Deaths", ylab="Probability")

n.failures <- 0:30
failuresDist <- dnbinom(x = n.failures, size = 1, prob = 0.2)
plot(x = n.failures, y = failuresDist, type="h", 
     xlab="Number of Failures", ylab="Probability")

x <- 0:1000
# the mean of the number wells that must be drilled
mu <- sum( x*dnbinom(x = x, size = 3, prob = 0.2) )
mu + 3 # 3/0.2

ztable <- matrix(NA, nrow = 31, ncol = 4)
n.row <- 1
n.col <- 1
for (i in seq(-3, 0, by = 0.1)) {
  for (j in c(0, 0.03, 0.06, 0.09)) {
    ztable[n.row, n.col] <- pnorm( q = (i+j), mean = 0, sd = 1)
    n.col <- n.col + 1 
  }
  n.col <- 1
  n.row <- n.row + 1
}

curve(expr = dt(x, df=2), from = -3, to = 3, 
      ylab="Density", main="t Distribution v.s standard normal Distribution", ylim=c(0, 0.4), col="red" )
curve(expr = dnorm(x), add = TRUE, col = "blue")
legend("topright", c("nomal(0,1)", "t(df=2)"), col=c("blue","red"), lty=1 )

curve(dchisq(x, df = 4), from = 0, to = 50, col="red",
      xlab="value of Chi-square", ylab="density", main="PDF of the Chi-square distribution")
curve(dchisq(x, df = 50), from = 0, to = 50, col="blue", add = TRUE)
legend("topright", c("df = 4", "df = 10"), col = c("red", "blue"), lty=1)

x=c(2,80)
pbinom(80,size=100,prob=0.01)-pbinom(1,size=100,prob=0.01)
p=0
for(i in 2:80){
  p=p+dbinom(i,size=100,prob=0.01)
}

n <- 100
p <- 0.01
mu <- n*p
sigma <- sqrt(n*p*(1-p))
x <- 0:qbinom(p = 0.9999, size = n, prob = p)
plot(x = x, y = pbinom(q = x, size = n, prob = p),
     type = "s", ylab="Probability", main = "Normal Approximation to the binomial Dist.")
abline(h = 0:1, col = "gray")
points(x = x, y = pbinom(q = x, size = n, prob = p), pch = 16, cex=0.75)
curve(expr = pnorm(x, mean = mu, sd = sigma), add = TRUE, col="blue")
points(x = x, pnorm(q = x, mean = mu, sd = sigma), col = "blue", pch = 16, cex =0.75)

# Difference between normal density and binomial probability
diff <- pnorm(q = x, mean = mu, sd = sigma) - pbinom(q = x, size = n, prob = p)
plot(x = x, y = diff, type = "b", ylim = c(-1, 1)*0.15,
     ylab="Difference in Probability")
abline(h = 0, col = "gray")
# Consider the continuity correction 
diff.correct <- pnorm(q = x+0.5, mean = mu, sd = sigma) - pbinom(q = x, size = n, prob = p)
points(x = x, y = diff.correct, col="red", type = "b")
legend("topright", 
       legend = c("Without continuity correction (CC)", "With CC"), 
       col = c("gray", "red"), pch = 1, lty = 1)

sd=0.99^0.5
z=c(1.5/sd,79.5/sd)
pnorm(z[2],mean=1,sd=sd)-pnorm(z[1],mean=1,sd=sd)

z=c(1.5/sd,80.5/sd)
pnorm(z[2],mean=1,sd=sd)-pnorm(z[1],mean=1,sd=sd)

n <- 100
p <- 0.05
lambda <- n*p
x <- 0:15
plot(x = x, y = dbinom(x = x, size = n, prob = p), type = "h", ylab="Probability", main = "Binomial(n=100, p=0.05)")
plot(x = x, y = dpois(x = x, lambda = lambda), 
     type = "h", ylab="Probability", main = "Poisson(lambda=5)")

k <- seq(0.01, 6, length = 101)
p_Cheb <- function(k) 1-1/k^2
plot(x = k, p_Cheb(k), ylim = c(0,1), ylab = "p(k)", type = "l",  )
p_norm <- function(k) pnorm(q = k, mean = 0, sd = 1) - pnorm(q = -k, mean = 0, sd = 1)
p_uniform <- function(k) ifelse(test = k<sqrt(3), yes = k/sqrt(3), no = 1)
matlines(x = k, cbind(p_norm(k), p_uniform(k) ), lty = 2:3 )
legend("bottomright", c("Normal","Uniform","Chebyshev"), lty = c(2:3, 1), col = c(2:3, 1) )


n <- 100
p <- 0.01
a <- 2
b <- 80
mu <- n*p
sigma <- sqrt(n*p*(1-p))
pbinom(b, size = n, prob = p) - pbinom( (a-1), size = n, prob = p)
pnorm( (b-mu)/sigma) - pnorm( (a-1-mu)/sigma)
pnorm( ((b-mu)+0.5)/sigma) - pnorm( ((a-1-mu)+0.5)/sigma)

pnorm(q=(150.5-128)/10.85,mean=0,sd=1)

d=read.csv(file = "librarian.csv",header = T)
head(d,3)
str(d)
d$base_score
t.test(base_score~randomization,data=d)

prop.test(table(d$sex,d$smoker))

table(d$pt_literacy)
fit<-aov(formula=base_score~as.character(pt_literacy),data=d)
summary(fit)
