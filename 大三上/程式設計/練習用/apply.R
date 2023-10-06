set.seed(6030)
m <- matrix(rnorm(12), nrow = 3)
dim(m)
result1 <- apply(X = m, MARGIN = 2, FUN = mean) # mean of elements for each row
class(result1) # vector
result2 <- apply(X = m, MARGIN = 1, FUN = cumsum)
class(result2)
result3 <- apply(X = as.data.frame(m), MARGIN = 1, FUN = function(x) x[x>0] )
class(result3)

set.seed(1235)
m <- as.data.frame(matrix(rnorm(12), ncol = 4 ) )
list1 <- lapply(X = m, FUN = range)
# list
scores<-list(maths=c(64,45,89,67),
             english=c(79,84,62,80),
             physics=c(68,72,69,80),
             chemistry = c(99,91,84,89))
scores

list2 <- lapply(X = scores, FUN = mean)
class(list2)

dt <- list(a = 1:20, beta = exp(-3:3), logic = c(TRUE, FALSE, FALSE, TRUE))
lapply(dt, quantile, probs = c(0.25, 0.5, 0.75))
list1
result1 <- sapply(X = list1, FUN = mean)
class(result1)
result2 <- sapply(X = list1, FUN = range)
class(result2)
result3 <- sapply(X = list1, FUN = function(x) x[x>0]  )
class(result3)

set.seed(1235)
salary <- rpois(n = 8, lambda = 1000)
job<-c("Data Scientist",
       "Statistician",
       "Statistician",
       "Data Scientist",
       "Statistician",
       "Data Scientist",
       "Statistician",
       "Data Scientist")
gender <- c("M","F","F","M","M","F", "M","F")
result1 <- tapply(X = salary, INDEX = job, FUN = mean)
class(result1)
job=="Data Scientist"
mean(salary[job=="Data Scientist"])

result2 <- tapply(X = salary, INDEX = gender, FUN = var)
class(result2)
result3 <- tapply(X = salary, INDEX = list(job, gender), FUN = mean)
class(result3)

