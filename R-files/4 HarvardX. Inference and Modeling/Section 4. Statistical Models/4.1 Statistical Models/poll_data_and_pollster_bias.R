## POll Data and Pollster Bias

## 2022.09.26


## Code: Generating simulated poll data

library(dslabs)      # load the file
data(polls_us_election_2016)    # load the data
names(polls_us_election_2016)   # show the variables inside the data

# keep only national polls from week before election with a grade considered reliable.
polls <- polls_us_election_2016 %>%            # filter the data with the specifications
  filter(state == "U.S." & enddate >= "2016-10-31" & 
           (grade %in% c("A+", "A", "A-", "B+") | is.na(grade))) 

# add spread estimate
polls <- polls %>%           # this is for the spread estimate in prportions
  mutate(spread = rawpoll_clinton/100 - rawpoll_trump/100)

# compute estimated spread for combined polls
d_hat <- polls %>%
  summarize(d_hat = sum(spread * samplesize) / sum(samplesize)) %>%
  .$d_hat

# compute margin of error (moe)
p_hat <- (d_hat + 1)/2
moe <- 1.96 * 2 * sqrt (p_hat * (1 - p_hat)/sum(polls$samplesize))

# histogram of the spread
polls %>%
  ggplot(aes(spread)) +
  geom_histogram(color = "black", binwidth = 0.01)


## Code: Investigating poll data and pollster bias,

# number of polls per pollster in week before election
polls %>% group_by(pollster) %>% summarize(n())

# plot results by pollster with at least 6 polls
polls %>% group_by(pollster) %>%
  filter(n() >= 6) %>%
  ggplot(aes(pollster, spread)) +
  geom_point() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

# standard errors within each pollster
polls %>% group_by(pollster) %>%
  filter(n() >= 6) %>%
  summarize(se = 2 * sqrt(p_hat * (1 - p_hat) / median(samplesize)))






