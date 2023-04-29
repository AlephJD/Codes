## Election forecasting using mathematical representation of models

## 2023.03.28


set.seed(3)

#############
#############

# This code from previous videos defines the 'results' object used for empirical Bayes election
# forecasting.

library(tidyverse)
library(dslabs)
polls <- polls_us_election_2016 %>% 
  filter(state == "U.S." & enddate >= "2016-10-31" & (grade %in% c("A+", "A", "A-", "B+") | is.na(grade))) %>%
  mutate(spread = rawpoll_clinton/100 - rawpoll_trump/100)

one_poll_per_pollster <- polls %>% group_by(pollster) %>%
  filter(enddate == max(enddate)) %>%
  ungroup()

results <- one_poll_per_pollster %>%
  summarize(avg = mean(spread), se = sd(spread)/sqrt(length(spread))) %>%    # es posible tambien usar: sqrt(length(spread)) = sqrt(n())
  mutate(start = avg - 1.96*se, end = avg + 1.96*se)


#############
#############

# Set mu to '0' which is interpreted as a model that simply does not provide any information on who
# will win.


## Code: Simulated data with: X_j = d + eps_j
J <- 6           # number of polls
N <- 2000        # number of people in the poll
d <- 0.021       # difference the day of election
p <- (d + 1)/2   # proportion of success, p = 0.5105
X <- d + rnorm(J, 0, 2*sqrt(p*(1 - p)/N))   # 'X': each measurement, and 'eps_j' = 'rnorm' (random generation for the normal distribution): represents the random error associated with the i,jth poll.


## Code: Simulated data with: X_ij = d + eps_ij
I <- 5      # number of pollsters
J <- 6
N <- 2000
d <- 0.021
p <- (d + 1)/2
X <- sapply(1:I, function(i){
  d + rnorm(J, 0, 2*sqrt(p*(1 - p)/N))
})


## Code: Simulated data with: X_ij = d + h_i + ep_ij
# Assume standard error of pollster-to-pollster variability (??_h), house effect, is 0.025, ??_h = 0.025 ((based on historical data)).
I <- 5
J <- 6
N <- 2000
d <- 0.021
p <- (d + 1)/2
h  <- rnorm(I, 0, 0.025)   # h_i: represents the house effect for the i_th pollster (assume standard error of pollster-to-pollster variability is 0.025).
X <- sapply(1:I, function(i){
  d + h[i] + rnorm(J, 0, 2*sqrt(p*(1 - p)/N))
})


## Code: Calculating probability of 'd > 0' with general bias. Simulated data with model: X_ij = d + b + h_i + ??_ij 
# Note that 'sigma' (??) (standard error) now includes an estimate of the variability due to general bias 
# '??_b = 0.025' (based on historical data).
# Standard error of pollster-to-pollster variability (??_h), house effect, is 0, ??_h = 0, and expected
# value of b (E[b] = 0) is modeled to be 0.

mu <- 0                                # population parameter from historical data
tau <- 0.035                           # population parameter from historical data
sigma <- sqrt(results$se^2 + 0.025^2)    # se = sd(spread)/sqrt(length(spread))
Y <- results$avg                       # Y = 0.02898
B <- sigma^2 / (sigma^2 + tau^2)       # B = 0.3515164

posterior_mean <- B*mu + (1 - B)*Y               # posterior_mean = 0.01879305
posterior_se <- sqrt(1 / (1/sigma^2 + 1/tau^2))  # posterior_se = 0.02075109

1 - pnorm(0, posterior_mean, posterior_se)  # = 0.8174373

