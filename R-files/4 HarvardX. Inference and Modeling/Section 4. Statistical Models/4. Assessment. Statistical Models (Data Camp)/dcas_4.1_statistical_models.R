##

## 2023.02


### El 'set.seed()' que se usa aqui no concuerda con los resultados obtenidos al aplicar la misma funcion
### en DataCamp.


## Exercise 1 
## HEIGHTS REVISITED

# We have been using 'urn models' to motivate the use of probability models. However, most data science
# applications are not related to data obtained from urns. More common are data that come from individuals.
# Probability plays a role because the data come from a random sample. The random sample is taken from
# a population and the urn serves as an analogy for the population.

# Let's revisit the heights dataset. For now, consider 'x' to be the heights of all males in the data set.
# Mathematically speaking, 'x' is our population. Using the urn analogy, we have an urn with the values of
# 'x' in it.

# What are the population average and standard deviation of our population?

# Instructions

# a) Execute the lines of code that create a vector 'x' that contains heights for all males in the 
#    population.

# b) Calculate the average of 'x'.

# c) Calculate the standard deviation of 'x'.

# Code:

# Load the 'dslabs'' package and data contained in 'heights'
library(dslabs)
data(heights)

# Make a vector of heights from all males in the population
x <- heights %>% filter(sex == "Male") %>%
  .$height

# Calculate the population average. Print this value to the console.
mean(x)
# [1] 69.31475

# Calculate the population standard deviation. Print this value to the console.
sd(x)
# [1] 3.611024



## Exercise 2 
## SAMPLE THE POPULATION OF HEIGHTS

# Call the population average computed above '??' (mu) and the standard deviation '??' (sigma). Now take
# a sample of size 50, with replacement, and construct an estimate for '??' (mu) and '??' (sigma).

# Instructions

# a) Use the 'sample' function to sample 'N' values from 'x'.

# b) Calculate the mean of the sampled heights.

# c) Calculate the standard deviation of the sampled heights.

# Code:

# The vector of all male heights in our population `x` has already been loaded for you. You can examine the first six elements using `head`.
head(x)

# Use the `set.seed` function to make sure your answer matches the expected result after random sampling
set.seed(1)

# Define `N` as the number of people measured
N <- 50

# Define `X` as a random sample from our population `x`
X <- sample(x, size = N, replace = TRUE)

# Calculate the sample average. Print this value to the console.
mean(X)
# [1] 68.73423 (de DataCamp)

# Calculate the sample standard deviation. Print this value to the console.
sd(X)
# [1] 3.761344 (de DataCamp)



## Exercise 3
## SAMPLE AND POPULATION AVERAGES

# What does the central limit theory (CLT) tell us about the sample average and how it is related to
# '??' (mu), the population average?
  
# Instructions

# Possible Answers

# a) It is identical to '??' (mu).

# b) It is a random variable with expected value '??' (mu) and standard error '?? (sigma)/sqrt(N)'. (correcto)

# c) It is a random variable with expected value '??' (mu) and standard error '??' (sigma).

# d) It underestimates '??' (mu).



## Exercise 4 
## CONFIDENCE INTERVAL CALCULATION

# We will use 'X_bar' as our estimate of the heights in the population from our sample size 'N'. 
# We know from previous exercises that the standard estimate of our error 'X_bar - ?? (mu)' is 
# '?? (sigma)/sqrt(N)'.

# Construct a 95% confidence interval for '?? (mu)'.

# Instructions

# a) Use the 'sd' and 'sqrt' functions to define the standard error 'se'.

# b) Calculate the 95% confidence intervals using the 'qnorm' function. Save the lower then the upper
#    confidence interval to a variable called 'ci'.

# Code:

# The vector of all male heights in our population `x` has already been loaded for you. You can examine
# the first six elements using `head`.
head(x)

# Use the `set.seed` function to make sure your answer matches the expected result after random sampling
set.seed(1)

# Define `N` as the number of people measured
N <- 50

# Define `X` as a random sample from our population `x`
X <- sample(x, N, replace = TRUE)

# Define `se` as the standard error of the estimate (X). Print this value to the console.
se_hat <- sd(X)/sqrt(N)
se_hat

# Construct a 95% confidence interval for the population average based on our sample. Save the lower
# and then the upper confidence interval to a variable called `ci`.
ci <- c(mean(X) - qnorm(0.975)*se_hat, mean(X) + qnorm(0.975)*se_hat)



## Exercise 5
## MONTE CARLO SIMULATION FOR HEIGHTS

# Now run a Monte Carlo simulation in which you compute 10,000 confidence intervals as you have just
# done. What proportion of these intervals include '??' (mu)?
  
# Instructions

# a) Use the 'replicate' function to replicate the sample code for 'B <- 10000' simulations. Save the
#    results of the replicated code to a variable called 'res'. The replicated code should complete 
#    the following steps: 
#        -1. Use the 'sample' function to sample 'N' values from 'x'. Save the sampled heights as a 
#            vector called 'X'. 
#        -2. Create an object called 'interval' that contains the 95% confidence interval for each of
#            the samples. Use the same formula you used in the previous exercise to calculate this 
#            interval. 
#        -3. Use the 'between' function to determine if '??' (mu) is contained within the confidence 
#            interval of that simulation.

# b) Finally, use the 'mean' function to determine the proportion of results in 'res' that contain '??' (mu).

# Code:

# Define `mu` as the population average
mu <- mean(x)

# Use the `set.seed` function to make sure your answer matches the expected result after random sampling
set.seed(1)

# Define `N` as the number of people measured
N <- 50

# Define `B` as the number of times to run the model
B <- 10000

# Define an object `res` that contains a logical vector for simulated intervals that contain mu
res <- replicate(B, {
  X <- sample(x, size = N, replace = TRUE)
  se_hat <- sd(X)/sqrt(N)
  interval <- c(mean(X) - qnorm(0.975)*se_hat, mean(X) + qnorm(0.975)*se_hat)
  between(mu, interval[1], interval[2])
})

# Calculate the proportion of results in `res` that include mu. Print this value to the console.
mean(res)

# [1] 0.9433 (de DataCamp)


## Exercise 6 
## VISUALIZING POLLING BIAS

# In this section, we used visualization to motivate the presence of pollster bias in election polls.
# Here we will examine that bias more rigorously. Lets consider two pollsters that conducted daily 
# polls and look at national polls for the month before the election.

# Is there a poll bias? Make a plot of the spreads for each poll.

# Instructions

# a) Use 'ggplot' to plot the spread for each of the two pollsters.

# b) Define the x- and y-axes usingusing 'aes()' within the 'ggplot' function.

# c) Use 'geom_boxplot' to make a boxplot of the data.

# d) Use 'geom_point' to add data points to the plot.

# Code:

# Load the libraries and data you need for the following exercises
library(dslabs)
library(dplyr)
library(ggplot2)
data("polls_us_election_2016")

# These lines of code filter for the polls we want and calculate the spreads
polls <- polls_us_election_2016 %>% 
  filter(pollster %in% c("Rasmussen Reports/Pulse Opinion Research","The Times-Picayune/Lucid") & 
           enddate >= "2016-10-15" & state == "U.S.") %>% 
  mutate(spread = rawpoll_clinton/100 - rawpoll_trump/100) 

# Make a boxplot with points of the spread for each pollster
polls %>% 
  ggplot(aes(pollster, spread)) + 
  geom_boxplot() + 
  geom_point()



## Exercise 7
## DEFINING POLSTER BIAS

# The data do seem to suggest there is a difference between the pollsters. However, these data are
# subject to variability. Perhaps the differences we observe are due to chance. Under the urn model,
# both pollsters should have the same expected value: the election day difference, 'd'.

# We will model the observed data 'Y_ij' in the following way:

#                            'Y_ij = d + b_i + ??_ij'
  
# with 'i = 1,2' indexing the two pollsters, 'b_i' the bias for pollster 'i', and '??_ij' poll to poll
# chance variability. We assume the '??' are independent from each other, have expected value '0' and
# standard deviation '??_i' (sigma_i) regardless of 'j'.

# Which of the following statements best reflects what we need to know to determine if our data fit
# the urn model?
  
# Instructions

# Possible Answers

# Is '??_ij = 0'?
  
# How close are 'Y_ij' to 'd'?
  
# Is 'b_1 ??? b_2' (b_1 not equal to b_2)?  (correcto)
  
# Are 'b_1 = 0' and 'b_2 = 0'?
  
  

## Exercise 8
## DERIVE EXPECTED VALUE

# We modelled the observed data 'Y_ij' as:

#                         'Y_ij = d + b_i + ??_ij'  
  
# On the right side of this model, only '??_ij' is a random variable. The other two values are constants.

# What is the expected value of 'Y_ij'?
  
# Instructions

# Possible Answers

# a) 'd + b_1'  (correcto)

# b) 'b_1 + ??_ij'

# c) 'd'

# d) 'd + b_1 + ??_ij'



## Exercise 9
## EXPECTED VALUE AND STANDARD ERROR OF POLL 1

# Suppose we define 'Y_bar_1' as the average of poll results from the first poll and '??_1' (sigma_1) as the standard deviation of the first poll.

# What is the expected value and standard error of 'Y_bar_1'?
  
# Instructions

# Possible Answers

# a) The expected value is 'd + b_1'  and the standard error is '??_1' (sigma_1).

# b) The expected value is 'd' and the standard error is '??_1 (sigma_1)/sqrt(N_1)'

# c) The expected value is 'd + b_1' and the standard error is '??_1 (sigma_1)/sqrt(N_1)'  (correcto)

# d) The expected value is 'd' and the standard error is '??_1 (sigma_1) + sqrt(N_1)'



## Exercise 10
## EXPECTED VALUE AND STANDARD ERROR OF POLL 2

# Now we define 'Y_bar_2' as the average of poll results from the second poll.

# What is the expected value and standard error of 'Y_bar_2'?
  
# Instructions

# Possible Answers

# a) The expected value is 'd + b_2' and the standard error is '??_2' (sigma_2)

# b) The expected value is 'd' and the standard error is '??_2 (sigma_2)/sqrt(N_2)'

# c) The expected value is 'd + b_2' and the standard error is '??_2 (sigma_2)/sqrt(N_2)'  (correcto)

# d) The expected value is 'd' and the standard error is '??_2 (sigma_2) + sqrt(N_2)'



## Exercise 11
## DIFFERENCE IN EXPECTED VALUES BETWEEN POLLS

# Using what we learned by answering the previous questions, what is the expected value of 'Y_bar_2 - Y_bar_1'?
  
# Instructions

# Possible Answers

# a) '(b_2 - b_1)^2'

# b) 'b_2 - b_1/sqrt(N)'

# c) 'b_2 + b_1'

# d) 'b_2 - b_1'  (correcto)



## Exercise 12
## STANDARD ERROR OF THE DIFFERENCE BETWEEN POLLS
# Using what we learned by answering the questions above, what is the standard error of 'Y_bar_2 - Y_bar_1'?
  
# Instructions

# Possible Answers

# a) 'sqrt( (??_2)^2 (sigma_2^2)/N_2 + (??_1)^2 (sigma_1^2)/N_1 )'  (correcto)

# b) 'sqrt( ??_2 (sigma_2)/N_2 + ??_1 (sigma_1)/N_1 )'

# c) '( (??_2)^2 (sigma_2^2)/N_2 + (??_1)^2 (sigma_1^2)/N_1 )^2'

# d) '(??_2)^2 (sigma_2^2)/N_2 + (??_1)^2 (sigma_1^2)/N_1 )'



## Exercise 13
## COMPUTE THE ESTIMATES

# The answer to the previous question depends on '??_1' (sigma_1) and '??_2' (sigma_2), which we don't
# know. We learned that we can estimate these values using the sample standard deviation.

# Compute the estimates of '??_1' (sigma_1) and '??_2' (sigma_2).

# Instructions

# a) Group the data by pollster.

# b) Summarize the standard deviation of the spreads for each of the two pollsters. Name the standard
#    deviation 's'.

# c) Store the pollster names and standard deviations of the spreads ('??' (sigma)) in an object called
#    'sigma'.

# Code:

# The `polls` data have already been loaded for you. Use the `head` function to examine them.
head(polls)

# Create an object called `sigma` that contains a column for `pollster` and a column for `s`, 
# the standard deviation of the spread
sigma <- polls %>% group_by(pollster) %>% summarize(s = sd(spread)) %>% select(pollster, s)


# Print the contents of sigma to the console
sigma

## A tibble: 2 x 2
# pollster                                      s
# <fct>                                     <dbl>
# 1 Rasmussen Reports/Pulse Opinion Research 0.0177
# 2 The Times-Picayune/Lucid                 0.0268



## Exercise 14
## PROBABILITY DISTRIBUTION OF THE SPREAD

# What does the central limit theorem tell us about the distribution of the differences between the
# pollster averages, 'Y_bar_2 - Y_bar_1'?
  
# Instructions

# Possible Answers

# a) The central limit theorem cannot tell us anything because this difference is not the average of
#    a sample.

# b) Because 'Y_ij' are approximately normal, the averages are normal too.

# c) If we assume 'N_1' and 'N_2' are large enough, 'Y_bar_2 - Y_bar_1', and their difference, are 
#    approximately normal.   (correcto)

# d) These data do not contain vectors of '0' and '1', so the central limit theorem does not apply.



## Exercise 15
## CALCULATE THE 95% CONFIDENCE INTERVAL OF THE SPREADS

# We have constructed a random variable that has expected value 'b_2 - b_1', the pollster bias difference.
# If our model holds, then this random variable has an approximately normal distribution. The standard
# error of this random variable depends on '??_1' (sigma_1) and '??_2' (sigma_2), but we can use the sample
# standard deviations we computed earlier. We have everything we need to answer our initial question:
# is 'b_2 - b_1' different from 0?
  
# Construct a 95% confidence interval for the difference 'b_2' and 'b_1'. Does this interval contain zero?
  
# Instructions

# a) Use pipes '%>%' to pass the data 'polls' on to functions that will group by pollster and summarize
#    the average spread, standard deviation, and number of polls per pollster.

# b) Calculate the estimate by subtracting the average spreads. Save this estimate to a variable called
#    'estimate'.

# c) Calculate the standard error using the standard deviations of the spreads and the sample size.
#    Save this value to a variable called 'se_hat'.

# d) Calculate the 95% confidence intervals using the 'qnorm' function. Save the lower and then the
#    upper confidence interval to a variable called 'ci'.

# Code:

# The `polls` data have already been loaded for you. Use the `head` function to examine them.
head(polls)

# Create an object called `res` that summarizes the average (spread), standard deviation (spread), 
# and number of polls for the two pollsters.
res <- polls %>% group_by(pollster) %>% summarize(avg = mean(spread), s = sd(spread), n = n())

# avg: b_bar (spread == bias); s: sigma_bar (standard deviation); n: N_total per pollster

# Store the difference between the larger average and the smaller in a variable called `estimate`.
# Print this value to the console.
estimate <- max(res[,2]) - min(res[,2])     # b_2 - b_1 (ambos tienen que ser promedios del spread)

# Store the standard error of the estimates as a variable called `se_hat`. Print this value to the
# console.
se_hat <- sqrt(res[1,3]^2/res[1,4] + res[2,3]^2/res[2,4])    # sqrt(sigma_1/N_1 + sigma_2/N_2)
se_hat

# Calculate the 95% confidence interval of the spreads. Save the lower and then the upper confidence
# interval to a variable called `ci`.
ci <- c(estimate - qnorm(0.975)*se_hat, estimate + qnorm(0.975)*se_hat)

# ci = 0.03851031, 0.06607302



## Exercise 16 
## CALCULATE THE P-VALUE

# The confidence interval tells us there is relatively strong pollster effect resulting in a difference
# of about 5%. Random variability does not seem to explain it.

# Compute a p-value to relay the fact that chance does not explain the observed pollster effect.

# Instructions

# a) Use the 'pnorm' function to calculate the probability that a random value is larger than the observed
#    ratio of the estimate to the standard error.

# b) Multiply the probability by 2, because this is the two-tailed test.

# Code:

# We made an object `res` to summarize the average, standard deviation, and number of polls for the two pollsters.
res <- polls %>% group_by(pollster) %>% 
  summarize(avg = mean(spread), s = sd(spread), N = n()) 

# The variables `estimate` and `se_hat` contain the spread estimates and standard error, respectively.
estimate <- res$avg[2] - res$avg[1]
se_hat <- sqrt(res$s[2]^2/res$N[2] + res$s[1]^2/res$N[1])

# Calculate the p-value
z <- estimate/se_hat
2 * (1 - pnorm(z))     # 2 * (1 - pnorm(z, mu = 0, sigma = 1)) 



## Exercise 17 
## COMPARING WITHIN-POLL AND BETWEEN-POLL VARIABILITY

# We compute statistic called the 't-statistic' by dividing our estimate of 'b_2 - b_1' by its estimated
# standard error:
  
#                   '(Y_bar_2 - Y_bar_1) / sqrt( (s_2^2)/N_2 +(s_1^2)/N_1 )'
  
# Later we learn will learn of another approximation for the distribution of this statistic for values
# of 'N_2' and 'N_1' that aren't large enough for the CLT.

# Note that our data has more than two pollsters. We can also test for pollster effect using all pollsters,
# not just two. The idea is to compare the variability across polls to variability within polls. We
# can construct statistics to test for effects and approximate their distribution. The area of statistics
# that does this is called Analysis of Variance or ANOVA. We do not cover it here, but ANOVA provides
# a very useful set of tools to answer questions such as: is there a pollster effect?

# Compute the average and standard deviation for each pollster and examine the variability across the
# averages and how it compares to the variability within the pollsters, summarized by the standard deviation.

# Instructions

# a) Group the 'polls' data by pollster.

# b) Summarize the average and standard deviation of the spreads for each pollster.

# c) Create an object called 'var' that contains three columns: pollster, mean spread, and standard
#    deviation.

# d) Be sure to name the column for mean 'avg' and the column for standard deviation 's'.

# Code:

# Execute the following lines of code to filter the polling data and calculate the spread
polls <- polls_us_election_2016 %>% 
  filter(enddate >= "2016-10-15" &
           state == "U.S.") %>%
  group_by(pollster) %>%
  filter(n() >= 5) %>% 
  mutate(spread = rawpoll_clinton/100 - rawpoll_trump/100) %>%
  ungroup()

# Create an object called `var` that contains columns for the pollster, mean spread, and standard 
# deviation. Print the contents of this object to the console.
var <- polls %>% group_by(pollster) %>% summarize(avg = mean(spread), s = sd(spread)) %>% select(pollster, avg, s)
var

var %>% ggplot(aes(pollster, avg)) + 
  geom_point() + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  geom_hline(yintercept = 0, linetype = "solid", color = "red") + 
  geom_hline(yintercept = 0.021, linetype = "dashed", color = "blue")


var %>% ggplot(aes(pollster, s)) + 
  geom_point() + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  geom_hline(yintercept = 0, linetype = "solid", color = "red") + 
  geom_hline(yintercept = 0.021, linetype = "dashed", color = "blue")





