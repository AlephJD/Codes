## Brexit Poll Analysis: In this project, you will analyze real Brexit polling data to develop polling
## models to forecast Brexit results.

## 2023.04.17


## OVERVIEW

# In June 2016, the United Kingdom (UK) held a referendum to determine whether the country would 
# "Remain" in the European Union (EU) or "Leave" the EU. This referendum is commonly known as Brexit.
# Although the media and others interpreted poll results as forecasting "Remain" (p > 0.5), the actual 
# proportion that voted "Remain" was only 48.1% (p = 0.481) and the UK thus voted to leave the EU. 
# Pollsters in the UK were criticized for overestimating support for "Remain". 


################################
## BREXIT POLL ANALYSIS - PART 1
################################


## IMPORTANT DEFINITIONS

# Data Import
# Import the 'brexit_polls' polling data from the 'dslabs' package and set options for the analysis:

# suggested libraries and options
library(tidyverse)
options(digits = 3)

# load brexit_polls object
library(dslabs)
data(brexit_polls)


# Final Brexit parameters
# Define 'p = 0.481' as the actual percent voting "Remain" on the Brexit referendum and 'd = 2p - 1 = -0.038'
# as the actual spread of the Brexit referendum with "Remain" defined as the positive outcome:

p <- 0.481
d <- 2*p - 1


## Q1: 
## EXPECTED VALUE AND STANDARD ERROR OF A POLL.
# The final proportion of voters choosing "Remain" was "p = 0.481'. Consider a poll with a sample of
# 'N = 1500' voters.

N <- 1500

# A) What is the expected total number of voters in the sample choosing "Remain"?
# E[total number of voters]
# N/2 = 750 pers. <-> 0.5   prop.
#         x pers. <-> 0.481 prop.

# x = (0.481 * 750) / 0.5
# x = 722 pers.


# B) What is the standard error of the total number of voters in the sample choosing "Remain"?
# SE[total number of voters]
# 0.481  prop. <-> 722 pers.
# 0.0129 prop. <->  x  pers.

# x = (0.0129 * 722) / 0.481
# x = 19.4 pers.


# C) What is the expected value of 'X_hat', the proportion of "Remain" voters?
# E[X]
B <- 10000

X <- sample(c(1,0), N, replace = TRUE, prob = c(p, 1-p))
mean(X)
# [1] 0.451

prop_remain <- replicate(B, {
  X <- sample(c(1,0), N, replace = TRUE, prob = c(p, 1-p))
  mean(X)
})
mean(prop_remain)
# E[X] = [1] 0.481


# D) What is the standard error of 'X_hat', the proportion of "Remain" voters?
# SE[X]
se_x <- sqrt(p*(1-p)/N)
# [1] 0.0129


# E) What is the expected value of 'd', the spread between the proportion of "Remain" voters and 
#    "Leave" voters?
# E[d] = E[spread] = -0.038


# F) What is the standard error of 'd', the spread between the proportion of "Remain" voters and 
#    "Leave" voters?
# SE[d]
# Primero probe con: se_d <- 2*sqrt(abs(d)*(1-abs(d))/N) = 0.00987  (incorrecto)
# Segundo intento: sqrt(abs(d)*(1-abs(d))/N) = 0.00494 (incorrecto)
# Tercer internto: se_d <- 4*sqrt(abs(d)*(1-abs(d))/N)  # 0.0197 (incorrecto)

# Busque en los apuntes, y encontre que el "standard error of the spread" es:
# SE[d] = SE[spread] = 2*SE[X] = 2 * sqrt(p*(1-p)/N)
se_d <- 2*se_x
# [1] 0.0258



## Q2:
## ACTUAL BREXIT POLL ESTIMATES

# Load and inspect the 'brexit_polls' dataset from "dslabs", which contains actual polling data for 
# the 6 months before the Brexit vote. Raw proportions of voters preferring "Remain", "Leave", and 
# "Undecided" are available ('remain', 'leave', 'undecided') The 'spread' is also available (spread),
# which is the difference in the raw proportion of voters choosing "Remain" and the raw proportion 
# choosing "Leave".
head(brexit_polls)

# Calculate 'x_hat' for each poll, the estimate of the proportion of voters choosing "Remain" on the
# referendum day ('p = 0.481'), given the observed 'spread' and the relationship 'd_hat = 2*X_hat - 1'.
# Use 'mutate()' to add a variable 'x_hat' to the 'brexit_polls' object by filling in the skeleton 
# code below:

# El 'spread' en 'brexit_polls', es el 'd_hat' ya que es un estimado de la dispersion real, para cada
# encuesta realizada.
# Se usa la relacion 'd_hat = 2*X_hat - 1' para obtener el estimado ('X_hat') de la proporcion real 'p =0.481'.
# X_hat = (d_hat + 1) / 2
# d_hat == spread
brexit_polls <- brexit_polls %>%
                mutate(x_hat = (spread + 1) / 2)
  

# A) What is the average of the observed spreads ('spread')?
mean(brexit_polls$spread)
# [1] 0.0201

# B) What is the standard deviation of the observed spreads?
sd(brexit_polls$spread)
# [1] 0.0588

# C) What is the average of 'x_hat', the estimates of the parameter 'p'?
mean(brexit_polls$x_hat)
# [1] 0.51

# D) What is the standard deviation of 'x_hat'?
sd(brexit_polls$x_hat)
# [1] 0.0294



## Q3:
##  CONFIDENCE INTERVAL OF A BREXIT POLL

# Consider the first poll in 'brexit_polls', a YouGov poll run on the same day as the Brexit referendum:
brexit_polls[1,]
#    startdate    enddate   pollster poll_type samplesize remain leave undecided spread x_hat
#    2016-06-23 2016-06-23   YouGov    Online       4772   0.52  0.48         0   0.04  0.52

# Use 'qnorm()' to compute the 95% confidence interval for 'X_hat'.
ci <- brexit_polls[1,]$x_hat + c(-1,1)*qnorm(0.975)*sqrt(brexit_polls[1,]$x_hat*(1-brexit_polls[1,]$x_hat)/brexit_polls[1,]$samplesize)

# A) What is the lower bound of the 95% confidence interval?
ci[1]
# [1] 0.506

# B) What is the upper bound of the 95% confidence interval?
ci[2]
# [1] 0.534

# Does the 95% confidence interval predict a winner (does not cover 'p = 0.5')? 
# Does the 95% confidence interval cover the true value of 'p' observed during the referendum?

# a) The interval predicts a winner and covers the true value of 'p'.

# b) The interval predicts a winner but does not cover the true value of 'p'. (correcto)

# c) The interval does not predict a winner but does cover the true value of 'p'.

# d) The interval does not predict a winner and does not cover the true value of 'p'.



################################
## BREXIT POLL ANALYSIS - PART 2
################################


## Q4:
## CONFIDENCE INTERVALS FOR POLLS IN JUNE

# Create the data frame 'june_polls' containing only Brexit polls ending in June 2016 ('enddate' of
# "2016-06-01" and later). We will calculate confidence intervals for all polls and determine how 
# many cover the true value of 'd'.

# First, use 'mutate()' to calculate a plug-in estimate 'se_x_hat' for the standard error of the 
# estimate "SE_hat[X]" for each poll given its sample size and value of "X_hat" ('x_hat'). Second,
# use 'mutate()' to calculate an estimate for the standard error of the spread for each poll given
# the value of 'se_x_hat'. Then, use 'mutate()' to calculate upper and lower bounds for 95% confidence
# intervals of the spread. Last, add a column 'hit' that indicates whether the confidence interval 
# for each poll covers the correct spread 'd = -0.038'.
june_polls <- brexit_polls %>% 
              filter(enddate >= "2016-06-01") %>%
              mutate(se_x_hat = sqrt(x_hat*(1-x_hat)/samplesize), 
                     se_d_hat = 2*se_x_hat,
                     upper = spread + qnorm(0.975)*se_d_hat, lower = spread - qnorm(0.975)*se_d_hat,
                     hit = lower <= d & d <= upper)


# A) How many polls are in 'june_polls'?
# 32

# B) What proportion of polls have a confidence interval that covers the value 0?
prop_0 <- june_polls %>% mutate(hit = lower <= 0 & 0 <= upper) %>% select(hit)
mean(prop_0$hit)
# [1] 0.625

# C) What proportion of polls predict "Remain" (confidence interval entirely above 0)?
prop_over_0 <- june_polls %>% mutate(hit = lower > 0) %>% select(hit)
mean(prop_over_0$hit)
# [1] 0.125

# D) What proportion of polls have a confidence interval covering the true value of 'd'?
prop_d <- june_polls %>% mutate(hit = lower <= d & d <= upper) %>% select(hit)
mean(prop_d$hit)
# [1] 0.562



## Q5:
## HIT RATE BY POLLSTER

# Group and summarize the 'june_polls' object by pollster to find the proportion of hits for each 
# pollster and the number of polls per pollster. Use 'arrange()' to sort by hit rate.
june_polls %>% 
  group_by(pollster) %>% 
  summarize(proportion_hits = mean(hit), n = n()) %>% 
  arrange(desc(proportion_hits))


# Which of the following are TRUE?

# a) Unbiased polls and pollsters will theoretically cover the correct value of the spread 50% of 
#    the time.

# b) Only one pollster had a 100% success rate in generating confidence intervals that covered the 
#    correct value of the spread.

# c) The pollster with the highest number of polls covered the correct value of the spread in their
#    confidence interval over 60% of the time.

# d) All pollsters produced confidence intervals covering the correct spread in at least 1 of their
#    polls.

# e) The results are consistent with a large general bias that affects all pollsters. (correcto)

# A tibble: 12 x 3
# pollster           proportion_hits       n
# <fct>                        <dbl>     <int>
# 1 ICM                          1          3
# 2 Survation/IG Group           1          1
# 3 TNS                          1          2
# 4 Opinium                      0.667      3
# 5 ORB                          0.667      3
# 6 YouGov                       0.556      9
# 7 Ipsos MORI                   0.5        2
# 8 Survation                    0.5        2
# 9 ComRes                       0.333      3
# 10 BMG Research                0          2
# 11 ORB/Telegraph               0          1
# 12 Populus                     0          1



## Q6:
## BOXPLOT OF BREXIT POLLS BY POLL TYPE

# Make a boxplot of the spread in 'june_polls' by poll type.
june_polls %>%
  ggplot(aes(poll_type, spread, fill = poll_type)) +
  geom_boxplot() +
  geom_point() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


# Which of the following are TRUE?

# a) Online polls tend to show support for "Remain" ('spread > 0'). 

# b) Telephone polls tend to show support "Remain" ('spread > 0'). (correcto)

# c) Telephone polls tend to show higher support for "Remain" than online polls (higher 'spread'). (correcto)

# d) Online polls have a larger interquartile range (IQR) for the spread than telephone polls, indicating that they are more variable. (correcto)

# e) Poll type introduces a bias that affects poll results. (correcto)



## Q7:
## COMBINED SPREAD ACROSS POLL TYPE

# Calculate the confidence intervals of the spread combined across all polls in 'june_polls', grouping
# by poll type. Recall that to determine the standard error of the spread, you will need to double the
# standard error of the estimate.

# Use this code (which determines the total sample size per poll type, gives each spread estimate a 
# weight based on the poll's sample size, and adds an estimate of 'p' from the combined spread) to begin
# your analysis:

combined_by_type <- june_polls %>%
                    group_by(poll_type) %>%
                    summarize(N = sum(samplesize),
                              spread = sum(spread*samplesize)/N, 
                              p_hat = (spread + 1)/2)


# 95% Confidence interval of the SPREAD ('d') for ONLINE voters
ci <- c(combined_by_type[1,]$spread + c(-1,1)*qnorm(0.975)*2*sqrt(combined_by_type[1,]$p_hat*(1-combined_by_type[1,]$p_hat)/combined_by_type[1,]$N))
# [1] -0.01648  0.00165

# 95% Confidence interval of the SPREAD ('d') for TELEPHONE voters
ci <- c(combined_by_type[2,]$spread + c(-1,1)*qnorm(0.975)*2*sqrt(combined_by_type[2,]$p_hat*(1-combined_by_type[2,]$p_hat)/combined_by_type[2,]$N))
# [1] -0.00414  0.02961


# A) What is the lower bound of the 95% confidence interval for online voters?
# [1] -0.01648

# B) What is the upper bound of the 95% confidence interval for online voters?
# [1] 0.00165



## Q8:
## INTERPRETING COMBINED SPREAD ESTIMATES ACROSS POLL TYPE

# Interpret the confidence intervals for the combined spreads for each poll type calculated in the
# previous problem.

# Which of the following are TRUE about the confidence intervals of the combined spreads for different
# poll types?

# a) Neither set of combined polls makes a prediction about the outcome of the Brexit referendum (a 
#    prediction is possible if a confidence interval does not cover 0). (correcto)

# b) The confidence interval for online polls is larger than the confidence interval for telephone 
#    polls.

# c) The confidence interval for telephone polls is covers more positive values than the confidence
#    interval for online polls. (correcto)

# d) The confidence intervals for different poll types do not overlap.

# e) either confidence interval covers the true value of 'd = -0.038'. (correcto)



################################
## BREXIT POLL ANALYSIS - PART 3
################################


## Q9:
## CHI-SQUARED P-VALUE

# Define 'brexit_hit', with the following code, which computes the confidence intervals for all Brexit
# polls in 2016 and then calculates whether the confidence interval covers the actual value of the 
# spread 'D = -0.038':

brexit_hit <- brexit_polls %>%
              mutate(p_hat = (spread + 1)/2,
                     se_spread = 2*sqrt(p_hat*(1-p_hat)/samplesize),
                     spread_lower = spread - qnorm(0.975)*se_spread,
                     spread_upper = spread + qnorm(0.975)*se_spread,
                     hit = spread_lower < -0.038 & -0.038 < spread_upper) %>%
              select(poll_type, hit)


# Use 'brexit_hit' to make a two-by-two table of poll type and hit status. Then use the 'chisq.test()'
# function to perform a chi-squared test to determine whether the difference in hit rate is significant.
brexit_table <- t(table(brexit_hit$poll_type, brexit_hit$hit))
brexit_table
#         Online Telephone
# FALSE     37        32
# TRUE      48        10

# Otra forma:
# two_by_two <- tibble(awarded = c("no", "yes"),
#                      men = c(totals$no_men, totals$yes_men),
#                      women = c(totals$no_women, totals$yes_women))
# two_by_two


# What is the p-value of the chi-squared test comparing the hit rate of online and telephone polls?
# chi-squared test
chisq.test(brexit_table)

#	Pearson's Chi-squared test with Yates' continuity correction

# data:  brexit_table
# X-squared = 11, df = 1, p-value = 0.001

# p-value = 0.001

## *** Empezar el calculo de lo que falta.

# Determine which poll type has a higher probability of producing a confidence interval that covers 
# the correct value of the spread. Also determine whether this difference is statistically significant
# at a p-value cutoff of 0.05. Which of the following is true?
  
# a) Online polls are more likely to cover the correct value of the spread and this difference is 
#    statistically significant. (correcto)

# b) Online polls are more likely to cover the correct value of the spread, but this difference is
#    not statistically significant.

# c) Telephone polls are more likely to cover the correct value of the spread and this difference is
#    statistically significant.

# d) Telephone polls are more likely to cover the correct value of the spread, but this difference 
#    is not statistically significant.  

  
  
## Q10:
## ODDS RATIO OF ONLINE AND TELEPHONE POLL HIT RATE
  
# Use the two-by-two table constructed in the previous exercise to calculate the odds ratio between
# the hit rate of online and telephone polls to determine the magnitude of the difference in performance
# between the poll types.

# A) Calculate the odds that an online poll generates a confidence interval that covers the actual 
#    value of the spread.

# [1] 1.3


# B) Calculate the odds that a telephone poll generates a confidence interval that covers the actual
#    value of the spread.

# [1] 0.312


# C) Calculate the odds ratio to determine how many times larger the odds are for online polls to hit
#    versus telephone polls.

# [1] 4.15



## Q11:
## PLOTTING SPREAD OVER TIME.

# Use 'brexit_polls' to make a plot of the spread ('spread') over time ('enddate') colored by poll 
# type ('poll_type'). Use 'geom_smooth()' with 'method = "loess"' to plot smooth curves with a 'span'
# of 0.4. Include the individual data points colored by poll type. Add a horizontal line indicating
# the final value of 'd = -0038'.
brexit_polls %>%
  ggplot(aes(enddate, spread, color = poll_type)) +
  geom_smooth(method = "loess", span = 0.4) +
  geom_point()

# *** Corregir, y anadir la linea negra que define a 'd'.

# Which of the following plots is correct?



## Q3:
## PLOTTING RAW PERCENTAGES OVER TIME.

# Use the following code to create the object 'brexit_long', which has a column 'vote' containing the
# three possible votes on a Brexit poll ("remain", "leave", "undecided") and a column 'proportion' 
# containing the raw proportion choosing that vote option on the given poll:

brexit_long <- brexit_polls %>%
               gather(vote, proportion, "remain":"undecided") %>%
               mutate(vote = factor(vote))

# Make a graph of proportion over time colored by vote. Add a smooth trendline with 'geom_smooth()' and 'method = "loess"' with a 'span' of 0.3.
brexit_long %>% 
  ggplot(aes(enddate, proportion, color = vote)) +
  geom_smooth(method = "loess", span = 0.3) +
  geom_point()


# Which of the following are TRUE?

# a) The percentage of undecided voters declines over time but is still around 10% throughout June. (correcto)

# b) Over most of the date range, the confidence bands for "Leave" and "Remain" overlap. (correcto)

# c) Over most of the date range, the confidence bands for "Leave" and "Remain" are below 50%. (correcto)

# d) In the first half of June, "Leave" was polling higher than "Remain", although this difference 
#    was within the confidence intervals. (correcto)

# e) At the time of the election in late June, the percentage voting "Leave" is trending upwards.


















  