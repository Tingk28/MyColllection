my.x2021 <- round( runif(2), 2)
my.n2021 <- sort(sample(c(50, 100, 200, 500), 2))
my.lambda2021 <- round( rpois(1, lambda = 1.5), 2)
my.p2021 <- round(runif(1), 2)
my.r <- sample(1:10, 1)
my.alpha <- round(rgamma(1,1,1), 2)
my.beta <- round(rgamma(1,1,1), 2)
my.power2022 <- sample(3:8,1)
df1 <- data.frame(name = c("Mary", "Thor", "Sven", "Jane", "Ake", "Stephan", 
                           "Bjorn", "Oden", "Dennis"),
                  treatment_gr = c(rep(c(1, 2, 3), each = 3)), 
                  weight_p1 = round(runif(9, 100, 200), 0))
df2 <- data.frame(name = c("Sven", "Jane", "Ake", "Mary", "Thor", "Stephan", 
                           "Oden", "Bjorn"), 
                  weight_p2 = round(runif(8, 100, 200), 0))                           
df3 <- data.frame(treatment_gr = c(1, 2, 3), 
                  type = c("dog-lovers", "cat-lovers", "all-lovers"))

my.power1.2022 <- sample(2:3,1)
my.apply<- sample( c("minimum","maximun","mean"), 1)
my.PH <- sample(c(30,40,50),1)
####
n <- 5
X <- cbind( rep(1, n), round(rnorm(n),2) )