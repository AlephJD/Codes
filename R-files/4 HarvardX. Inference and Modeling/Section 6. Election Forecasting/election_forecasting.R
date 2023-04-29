## Election Forecasting using statistical modeling and Bayesian statistics.

## 2023.03.20


## CODE: Definition of 'results' object.

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



## CODE: Computing the posterior mean, standard error, credible interval and probability.

# Note that to compute and exact 95% credible interval, we could use 'qnorm(0.975' instead of 1.96.

mu <- 0
tau <- 0.035
Y <- results$avg
sigma <- results$se
B <- sigma^2 / (sigma^2 + tau^2)
posterior_mean <- B*mu +(1-B)*Y
posterior_se <- sqrt(1 / (1/sigma^2 + 1/tau^2))

posterior_mean
posterior_se

# 95% credible interval

posterior_mean + c(-1.96, 1.96)*posterior_se

# probability of d > 0

1 - pnorm(0, posterior_mean, posterior_se)

