# Computing a p-Value for an observed value.

# 2022.08.19


# Code: Computing a p-value for observed spread of 0.02

N <- 100                     # sample size
z <- sqrt(N)*0.02/0.5        # spread of 0.02
1 - (pnorm(z) - pnorm(-z))
