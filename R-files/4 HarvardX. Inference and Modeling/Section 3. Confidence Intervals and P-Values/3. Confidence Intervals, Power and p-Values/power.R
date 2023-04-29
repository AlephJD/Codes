# Power

# 2022.08.15


## Code: 

## Confidence interval for the 'spread' with sample size of 25.

# Note that to compute the exact 95% confidence interval, we would use
# c(-qnorm(0.975), qnorm(0.975)) instead of 1.96.

# Ejemplo realizado con anterioridad en donde se obtuvo 'X_hat' 
# (o 'X_bar' diria yo).

N <- 25
X_hat <- 0.48
(2*X_hat - 1) + c(-2, 2)*2*sqrt(X_hat*(1 - X_hat)/sqrt(N))

