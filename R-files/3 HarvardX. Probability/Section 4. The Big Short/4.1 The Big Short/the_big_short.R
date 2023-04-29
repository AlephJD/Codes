# THE BIG SHORT

# 2021.07.08


set.seed(1, sample.kind = "Rounding")    # will make R 3.6 generate a seed as in R 3.5

# The Central Limit Theorem states that the sum of independent draws of a random variable follows a 
# normal distribution. However, when the draws are not independent, this assumption does not hold.
# If an event changes the probability of default for all borrowers, then the probability of the bank 
# losing money changes.

# Monte Carlo simulations can be used to model the effects of unknown changes in the probability of 
# default.


# Code: Expected value with higher default rate and interest rate
p <- .04
loss_per_foreclosure <- -200000
r <- 0.05
x <- r*180000
loss_per_foreclosure*p + x*(1-p)

# Equations: Probability of losing money
# We can define our desired probability of losing money, Z, as:
  
#  Pr???(S<0)=Pr???(Z<-E[S]/SE[S] )=Pr???(Z<z)

# If ?? is the expected value of the urn (one loan) and ?? is the standard deviation of the urn (one loan),
# then E[S]=n?? and SE[S]=???n ??.

# As in the previous video, we define the probability of losing money z=0.01. In the first equation,
# we can see that:
  
#  z=-(E[S])/(SE[S])

# It follows that:

#  z=-n??/(???n ??)=-(???n ??)/??

# To find the value of n for which z is less than or equal to our desired value, we take z???-(???n ??)/?? 
# and solve for n:
  
#  n???(z^2 ??^2)/??^2 


# Code: Calculating number of loans for desired probability of losing money
# The number of loans required is:
z <- qnorm(0.01)
l <- loss_per_foreclosure
n <- ceiling((z^2*(x-l)^2*p*(1-p))/(l*p + x*(1-p))^2)
n    # number of loans required
n*(loss_per_foreclosure*p + x * (1-p))    # expected profit over n loans


# Code: Monte Carlo simulation with known default probability
# This Monte Carlo simulation estimates the expected profit given a known probability of default p = 0.04.
# Note that your results will differ from the video because the seed is not set.
B <- 10000
p <- 0.04
x <- 0.05 * 180000
profit <- replicate(B, {
  draws <- sample( c(x, loss_per_foreclosure), n, 
                   prob=c(1-p, p), replace = TRUE) 
  sum(draws)
})
mean(profit)


# Code: Monte Carlo simulation with unknown default probability
# This Monte Carlo simulation estimates the expected profit given an unknown probability of default
# 0.03 ??? p ??? 0.05, modeling the situation where an event changes the probability of default for all
# borrowers simultaneously. Note that your results will differ from the video because the seed is 
# not set.
p <- 0.04
x <- 0.05*180000
profit <- replicate(B, {
  new_p <- 0.04 + sample(seq(-0.01, 0.01, length = 100), 1)
  draws <- sample( c(x, loss_per_foreclosure), n, 
                   prob=c(1-new_p, new_p), replace = TRUE)
  sum(draws)
})

mean(profit)    # expected profit
mean(profit < 0)    # probability of losing money
mean(profit < -10000000)    # probability of losing over $10 million

