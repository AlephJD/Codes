# Confidence Intervals

# 2022.08.09

library(tidyverse)

## Code: geom_smooth confidence interval example
# The shaded area around the curve is related to the concept of confidence intervals

data("nhtemp")
data.frame(year = as.numeric(time(nhtemp)), temperature = as.numeric(nhtemp)) %>%
  ggplot(aes(year, temperature)) +
  geom_point() +
  geom_smooth() +
  ggtitle("Average Yearly Temperatures in New Heaven")
  
## Code: Monte Carlo simulation of confidence intervals
# Note that to compute the exact 95% confidence interval, we would use 'qnorm(0.975)*SE_hat' instead
# of '2*SE_hat'

p <- 0.45
N <- 1000
X <- sample(c(0,1), size = N, replace = TRUE, prob = c(1-p, p))  # generate 'N' observations
X_hat <- mean(X)   # calculate 'X_hat'
SE_hat <- sqrt(X_hat*(1-X_hat)/N)  # calculate 'SE_hat', SE of the mean of 'N' observations
c(X_hat - 2*SE_hat, X_hat + 2*SE_hat)  # build interval of '2*SE' above and below mean


## Code: Solving for 'z' with 'qnorm'

z <- qnorm(0.995)       # calculate 'z' to solve for 99% confidence interval
pnorm(qnorm(0.995))     # demonstrating that 'qnorm' gives the 'z' value for a given probability
pnorm(qnorm(1 - 0.995)) # demonstrating symmetry of '1-qnorm'
pnorm(z) - pnorm(-z)    # demonstrating that this 'z' value gives correct probability for interval

