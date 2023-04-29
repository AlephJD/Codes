## Sampling Models

# 2021.05.12


set.seed(1, sample.kind = "Rounding")    # will make R 3.6 generate a seed as in R 3.5

## Monte Carlo simulation: Chance of casino losing money on roulette
# We build a sampling model for the random variable S that represents the casino's total winnings. 

# sampling model 1: define urn, then sample
color <- rep(c("Black", "Red", "Green"), c(18, 18, 2)) # define the urn for the sampling model
n <- 1000
X <- sample(ifelse(color == "Red", -1, 1), n, replace = TRUE)       # Uppercase 'X'
X[1:10]

# > sum(X == 1)
# [1] 538
# > sum(X == -1)
# [1] 462

# sum(X == 1) - sum(X == -1)
# [1] 76


# sampling model 2: define urn inside sample function by noting probabilities
x <- sample(c(-1, 1), n, replace = TRUE, prob = c(9/19, 10/19))    # 1000 independent draws, lowercase 'x'
S <- sum(x)    # total winnings of casino = sum of draws
S


# We use the sampling model to run a Monte Carlo simulation and use the results to estimate the 
# probability of the casino losing money.

n <- 1000    # number of roulette players
B <- 10000    # number of Monte Carlo experiments
S <- replicate(B, {                       # Uppercase 'S'
    X <- sample(c(-1,1), n, replace = TRUE, prob = c(9/19, 10/19))    # simulate 1000 spins  # Uppercase 'X'
    sum(X)    # determine total profit
})


############
############
# Code: Other way to do it
# roulette_winnings <- function(n){
#     X <- sample(c(-1,1), n, replace = TRUE, prob=c(9/19, 10/19))
#     sum(X)
# }
# S <- replicate(B, roulette_winnings(n))
############
############


mean(S < 0)    # probability of the casino losing money
# [1] 0.0419

# mean(S)
# [1] 52.1342

# We can visualize the distribution of S by creating a histogram showing the probability F(b)-F(a) 
# for several intervals (a,b]  (i.e.max(S),min(S) ) (from Book).
# We can plot a histogram of the observed values of S as well as the normal density curve based on 
# the mean and standard deviation of S.

library(tidyverse)
s <- seq(min(S), max(S), length = 100)    # sequence of 100 values across range of S        # lowercase 's'
normal_density <- data.frame(s = s, f = dnorm(s, mean(S), sd(S))) # generate normal density for S, ESTE ES EL 'TEORICO'.
data.frame (S = S) %>%    # make data frame of S for histogram
    ggplot(aes(S, ..density..)) +                                 # ESTE ES EL DE LOS 'DATOS'.
    geom_histogram(color = "black", binwidth = 10) + 
    ylab("Probability") +
    geom_line(data = normal_density, mapping = aes(s, f), color = "blue")


# Q-Q Plot
p <- seq(0.01, 0.99, 0.01)
obs_quantiles <- quantile(S,p)
theo_quantiles <- qnorm(p, mean(S), sd(S))
plot(theo_quantiles, obs_quantiles)
abline(0,1)
qqplot(theo_quantiles, obs_quantiles)
abline(0,1)
