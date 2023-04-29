## Student t-Distribution for election forecasting.

## 2023.04.12

## t-statistic:  t = Z = (X_bar - d) / (s/sqrt(N))

## Code: Calculating 95% confidence intervals with the t-distribution.
z <- qt(0.975, nrow(one_poll_per_pollster) - 1)   # the second argument is the degrees of freedom (N - 1)
one_poll_per_pollster %>% 
  summarize(avg = mean(spread), moe = z*sd(spread)/sqrt(length(spread))) %>%    # it has to be like: moe = z * 's/sqrt(N)'
  mutate(start = avg - moe, end = avg + moe)

# quantile from t-distribution versus normal distribution
qt(0.975, 14)    # 14 = nrow(one_poll_per_pollster) - 1
qnorm(0.975)


