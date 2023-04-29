# A Monte Carlo simulation for the CLT (Central Limit Theorem).

# 2022.07.20


## Monte Carlo simulation using a set value of 'p'.

p <- 0.45    # unknown 'p' to estimate
N <- 1000

# simulate ONE poll of size 'N' and determine 'X_hat'.

X <- sample(c(0,1), size = N, replace = TRUE, prob = c(1-p, p))
X_hat <- mean(X)


# Simulate 'B' polls of size 'N' and determine average 'X_hat'.

B <- 10000    # number of replicates
N <- 1000     # sample size per replicate

X_hat <- replicate(B, {
  X <- sample(c(0,1), size = N, replace = TRUE, prob = c(1-p, p))
  mean(X)
})


# mean (X_hat) = 0.4501404
# sd(X_hat) = 0.01572777


## Histogram and QQ-plot of Monte Carlo results.

library(tidyverse)
library(gridExtra)

p1 <- data.frame(X_hat = X_hat) %>%
      ggplot(aes(X_hat)) +
      geom_histogram(binwidth = 0.005, color = "black")
p2 <- data.frame(X_hat = X_hat) %>%
      ggplot(aes(sample = X_hat)) +
      stat_qq(dparams = list(mean = mean(X_hat), sd = sd(X_hat))) +
      geom_abline() +
      ylab("X_hat") +
      xlab("Theoretical normal")
grid.arrange(p1, p2, nrow = 1)





