## We simulate combine the results of many polls to simulate polls with a large sample size and 
## therefore generate more precise estimates than individual polls.

## POlls can be simulated with a Monte Carlo simulation and used to construct an estimate of the
## spread and confidence intervals.

## 2022.09.23



## Code: Simulating polls

# Note that to compute the exact 95% confidence interval, we would use qnorm(0.975)*SE_hat instead
# of 2*SE_hat.

d <- 0.039     # the difference, the spread
Ns <- c(1298, 533, 1342, 897, 774, 254, 812, 324, 1291, 1056, 2172, 516)    # sample sizes (selected to mimic regular polls)
p <- (d + 1)/2    # proportion of Democrats

# calculate confidence intervals of the spread

confidence_intervals <- sapply(Ns, function(N) {
    X <- sample(c(0,1), size = N, replace = TRUE, prob = c(1-p, p))   # for each poll, we are gonna generate a sample.
    X_hat <- mean(X)       # proportion of people voting for Democrats in that sample
    SE_hat <- sqrt(X_hat*(1-X_hat)/N)     # standard error
    2*c(X_hat, X_hat - 2*SE_hat, X_hat + 2*SE_hat) - 1     # the estimate X_hat, and the beginning and end of the confidence interval.
})


# generate a data frame storing results
polls <- data.frame(poll = 1:ncol(confidence_intervals),            # a data frame that has all the results
                    t(confidence_intervals), sample_size = Ns)
names(polls) <- c("poll", "estimate", "low", "high", "sample_size")
polls


## Code: Calculating the spread of combined polls

# Note that to compute the exact 95% confidence interval, we would use qnorm(0.975) instead of 1.96.

d_hat <- polls %>%
  summarize(avg = sum(estimate*sample_size) / sum(sample_size)) %>%        # se parece mucho a N*E[spread]/N
  .$avg

p_hat <- (1 + d_hat)/2
moe <- 2*1.96*sqrt(p_hat*(1 - p_hat) / sum(polls$sample_size))
round(d_hat*100, 1)
round(moe*100, 1)

