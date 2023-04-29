# A Monte Carlo Simulation for Confidence Intervals

# 2022.08.14


# Code: Monte Carlo simulation
# Note that to compute the exact 95% confidence interval, we would use 'qnorm(.975)*SE_hat' instead
# of '2*SE_hat'.

p <- 0.45
N <- 1000
B <- 10000
inside <- replicate(B, {
  X <- sample(c(0,1), size = N, replace = TRUE, prob = c(1-p, p))
  X_hat <- mean(X)
  SE_hat <- sqrt(X_hat*(1-X_hat)/N)
  between(p, X_hat - 2*SE_hat, X_hat + 2*SE_hat)    # TRUE if p in confidence interval
})
mean(inside)


### *** Intentar graficar parte de los intervalos de confianza con media 'p = 0.45' en el
# centro de la grafica.