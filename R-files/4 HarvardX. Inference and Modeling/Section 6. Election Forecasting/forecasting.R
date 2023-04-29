## Forecasting: prediction of the presidential Election of 2016, using variability on time (t).

## 2023.04.04


## CODE: Variability across one pollster. Model: 
# Y_ijt = d + b + ??_ijt, 
# h_i = 0, 
# i = 1.     # Confirmar que este correcto, lo puse yo tratando de inferir el modelo usado.

# select all national polls by one pollster
one_pollster <- polls_us_election_2016 %>%
  filter(pollster == "Ipsos" & state == "U.S.") %>%
  mutate(spread = rawpoll_clinton/100 - rawpoll_trump/100)

# the observed standard error is higher than theory predicts
se <- one_pollster %>%
  summarize(empirical = sd(spread), theoretical = 2*sqrt(mean(spread)*(1 - mean(spread))/min(samplesize)))

se

# the distribution of the data is not normal
one_pollster %>% ggplot(aes(spread)) +
  geom_histogram(binwidth = 0.01, color = "black")

#> `geom_smooth()` using formula 'y ~ x'


## CODE: Trend across time for several pollsters.
# Model: Y_ijt = d + b + h_j + b_t + f(t) + ??_ijt

polls_us_election_2016 %>%
  filter(state == "U.S." & enddate >= "2016-07-01") %>% 
  group_by(pollster) %>%
  filter(n() >= 10) %>%
  ungroup() %>%
  mutate(spread = rawpoll_clinton/100 - rawpoll_trump/100) %>%
  ggplot(aes(enddate, spread)) +
  geom_smooth(method = "loess", span = 0.1) +
  geom_point(aes(color = pollster), show.legend = FALSE, alpha = 0.6)


## CODE: Plotting raw percentages across time.
polls_us_election_2016 %>%
  filter(state == "U.S." & enddate >= "2016-07-01") %>%
  select(enddate, pollster, rawpoll_clinton, rawpoll_trump) %>%
  rename(Clinton = rawpoll_clinton, Trump = rawpoll_trump) %>%
  gather(candidate, percentage, -enddate, -pollster) %>%
  mutate(candidate = factor(candidate, levels = c("Trump", "Clinton"))) %>%
  group_by(pollster) %>%
  filter(n() >= 10) %>%
  ungroup() %>%
  ggplot(aes(enddate, percentage, color = candidate)) +
  geom_point(show.legend = FALSE, alpha = 0.4) +
  geom_smooth(method = "loess", span = 0.15) +
  scale_y_continuous(limits = c(30, 50))
  
  
  
  
  
  
  
  
  
  








