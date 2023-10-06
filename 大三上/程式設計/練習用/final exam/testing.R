pnorm(1.96)#查表 累積機率
qnorm(.05)#反查表 
dnorm(0)#為0的機率
curve(dnorm(x),from = -5,to=5)
rnorm(10)#以常態產生十個樣本


#hist(rnorm(1000))
#pt(2.50,25)#qt


# single pop.
## single pop mean
my_t.test<- function(data,mu=0){
  cat("\n\tone sample t-test\n\n")
  cat("data: ",deparse(substitute(data)),"\n")
  sample_mean<-mean(data)
  var<-var(data)
  n<-length(data)
  df<-n-1
  t<-(sample_mean-mu)/(var/n)^0.5
  pvalue<- 2*pt(t,df)
  cat("t = ",t,", df = ",df,", p-value = ",pvalue)
  
  cat("\nalternative hypothesis: true mean is not equal to ",mu,"\n",
  "95 percent confidence interval:\n")
  cat(sample_mean-qt(.975,df)*(var/n)^.5,sample_mean+qt(.975,df)*(var/n)^.5)
  cat("\nsample estimates:\nmean of x\n",sample_mean)
}
## singal pop 比例
my_prop.test<- function(data,p=0.5){
  cat("\n\t1-sample proportions test with continuity correction\n\n")
  cat("data: ",deparse(substitute(data)),", null probability ",p)
  n<-sum(data)
  #sample_prop<-data[1]/sum(data)
  df<-1
  E<-c(n*p,n*(1-p))
  YATES=0.5
  t<- sum((abs(data - E) - YATES)^2/E)
  #pvalue<- 2*pt(t,df)
  cat("\nX-squared = ",t,", df = ",df,", p-value = ",1-pchisq(t,df))
  
  cat("\nalternative hypothesis: true p is not equal to ",p,"\n",
      "95 percent confidence interval:\n")
  
  
 #cat(sample_prop-qt(.975,df)*(var/n)^.5,sample_prop+qt(.975,df)*(var/n)^.5)
  #cat("\nsample estimates:\nmean of x\n",sample_prop)
}
# Two pop.
## two pop. mean
## two pop. 比例

## paired data
## 3+ group


#correlation
## Pearson’s correlation
## Spearman’s ρ correlation


# Linear Regression
# Logistic Regression


mydata <- read.csv("librarian.csv")
mydata

t.test(mydata$base_score, mu=8)

my_t.test(mydata$base_score, mu=8)

prop.test( table( mydata$smoker), p=0.6)
my_prop.test( table( mydata$smoker), p=0.6)
prop.test(447, 998, .1)
x=c(59,70)
n=128
p=.6
YATES=0.5


my_prop.test<-function (x, n, p = NULL, alternative = c("two.sided", "less", 
                                          "greater"), conf.level = 0.95, correct = TRUE) 
{
  DNAME <- deparse1(substitute(x))
  if (is.table(x) && length(dim(x)) == 1L) {
    if (dim(x) != 2L) 
      stop("table 'x' should have 2 entries")
    l <- 1
    n <- sum(x)
    x <- x[1L]
  }
  else if (is.matrix(x)) {
    if (ncol(x) != 2L) 
      stop("'x' must have 2 columns")
    l <- nrow(x)
    n <- rowSums(x)
    x <- x[, 1L]
  }
  else {
    DNAME <- paste(DNAME, "out of", deparse1(substitute(n)))
    if ((l <- length(x)) != length(n)) 
      stop("'x' and 'n' must have the same length")
  }
  OK <- complete.cases(x, n)
  x <- x[OK]
  n <- n[OK]
  if ((k <- length(x)) < 1L) 
    stop("not enough data")
  if (any(n <= 0)) 
    stop("elements of 'n' must be positive")
  if (any(x < 0)) 
    stop("elements of 'x' must be nonnegative")
  if (any(x > n)) 
    stop("elements of 'x' must not be greater than those of 'n'")
  if (is.null(p) && (k == 1)) 
    p <- 0.5
  if (!is.null(p)) {
    DNAME <- paste0(DNAME, ", null ", if (k == 1) 
      "probability "
      else "probabilities ", deparse1(substitute(p)))
    if (length(p) != l) 
      stop("'p' must have the same length as 'x' and 'n'")
    p <- p[OK]
    if (any((p <= 0) | (p >= 1))) 
      stop("elements of 'p' must be in (0,1)")
  }
  alternative <- match.arg(alternative)
  if (k > 2 || (k == 2) && !is.null(p)) 
    alternative <- "two.sided"
  if ((length(conf.level) != 1L) || is.na(conf.level) || (conf.level <= 
                                                          0) || (conf.level >= 1)) 
    stop("'conf.level' must be a single number between 0 and 1")
  correct <- as.logical(correct)
  ESTIMATE <- setNames(x/n, if (k == 1) 
    "p"
    else paste("prop", 1L:l)[OK])
  NVAL <- p
  CINT <- NULL
  YATES <- if (correct && (k <= 2)) 
    0.5
  else 0
  if (k == 1) {
    z <- qnorm(if (alternative == "two.sided") 
      (1 + conf.level)/2
      else conf.level)
    YATES <- min(YATES, abs(x - n * p))
    z22n <- z^2/(2 * n)
    p.c <- ESTIMATE + YATES/n
    p.u <- if (p.c >= 1) 
      1
    else (p.c + z22n + z * sqrt(p.c * (1 - p.c)/n + z22n/(2 * 
                                                            n)))/(1 + 2 * z22n)
    p.c <- ESTIMATE - YATES/n
    p.l <- if (p.c <= 0) 
      0
    else (p.c + z22n - z * sqrt(p.c * (1 - p.c)/n + z22n/(2 * 
                                                            n)))/(1 + 2 * z22n)
    CINT <- switch(alternative, two.sided = c(max(p.l, 0), 
                                              min(p.u, 1)), greater = c(max(p.l, 0), 1), less = c(0, 
                                                                                                  min(p.u, 1)))
  }
  else if ((k == 2) && is.null(p)) {
    DELTA <- ESTIMATE[1L] - ESTIMATE[2L]
    YATES <- min(YATES, abs(DELTA)/sum(1/n))
    WIDTH <- (switch(alternative, two.sided = qnorm((1 + 
                                                       conf.level)/2), qnorm(conf.level)) * sqrt(sum(ESTIMATE * 
                                                                                                       (1 - ESTIMATE)/n)) + YATES * sum(1/n))
    CINT <- switch(alternative, two.sided = c(max(DELTA - 
                                                    WIDTH, -1), min(DELTA + WIDTH, 1)), greater = c(max(DELTA - 
                                                                                                          WIDTH, -1), 1), less = c(-1, min(DELTA + WIDTH, 
                                                                                                                                           1)))
  }
  if (!is.null(CINT)) 
    attr(CINT, "conf.level") <- conf.level
  METHOD <- paste(if (k == 1) 
    "1-sample proportions test"
    else paste0(k, "-sample test for ", if (is.null(p)) 
      "equality of"
      else "given", " proportions"), if (YATES) 
        "with"
    else "without", "continuity correction")
  if (is.null(p)) {
    p <- sum(x)/sum(n)
    PARAMETER <- k - 1
  }
  else {
    PARAMETER <- k
    names(NVAL) <- names(ESTIMATE)
  }
  names(PARAMETER) <- "df"
  x <- cbind(x, n - x)
  E <- cbind(n * p, n * (1 - p))
  if (any(E < 5)) 
    warning("Chi-squared approximation may be incorrect")
  print(E)
  print(YATES)
  STATISTIC <- sum((abs(x - E) - YATES)^2/E)
  names(STATISTIC) <- "X-squared"
  if (alternative == "two.sided") 
    PVAL <- pchisq(STATISTIC, PARAMETER, lower.tail = FALSE)
  else {
    if (k == 1) 
      z <- sign(ESTIMATE - p) * sqrt(STATISTIC)
    else z <- sign(DELTA) * sqrt(STATISTIC)
    PVAL <- pnorm(z, lower.tail = (alternative == "less"))
  }
  RVAL <- list(statistic = STATISTIC, parameter = PARAMETER, 
               p.value = as.numeric(PVAL), estimate = ESTIMATE, null.value = NVAL, 
               conf.int = CINT, alternative = alternative, method = METHOD, 
               data.name = DNAME)
  class(RVAL) <- "htest"
  return(RVAL)
}
