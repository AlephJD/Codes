# Confidence Intervals and p-Values

# 2022.09.13


## Exercise 1. 
## CONFIDENCE INTERVAL FOR P

# For the following exercises, we will use actual poll data from the 2016 election. The exercises 
# will contain pre-loaded data from the 'dslabs' package.

library(dslabs)
data("polls_us_election_2016")

# We will use all the national polls that ended within a few weeks before the election.

# Assume there are only two candidates and construct a 95% confidence interval for the election 
# night proportion 'p'.

#Instructions

# a) Use 'filter' to subset the data set for the poll data you want. Include polls that ended on or
#    after October 31, 2016 ('enddate'). Only include polls that took place in the United States. 
#    Call this filtered object 'polls'.

# b) Use 'nrow' to make sure you created a filtered object 'polls' that contains the correct number 
#    of rows.

# c) Extract the sample size 'N' from the first poll in your subset object 'polls'.

# d) Convert the percentage of Clinton voters ('rawpoll_clinton') from the first poll in 'polls' to 
#    a proportion, 'X_hat'. Print this value to the console.

# e) Find the standard error of 'X_hat' given 'N'. Print this result to the console.

# f) Calculate the 95% confidence interval of this estimate using the 'qnorm' function.

# g) Save the lower and upper confidence intervals as an object called 'ci'. Save the lower confidence
#    interval first.


# Code:

# Load the data.
data(polls_us_election_2016)

# Generate an object `polls` that contains data filtered for polls that ended on or after October 31, 2016
# in the United States.
polls <- filter(polls_us_election_2016, enddate >= "2016-10-31" & state == "U.S.")

# How many rows does `polls` contain? Print this value to the console.
nrow(polls)

# Assign the sample size of the first poll in `polls` to a variable called `N`. Print this value to 
# the console.
N <- polls[1,6]


# For the first poll in `polls`, assign the estimated percentage of Clinton voters to a variable called
# `X_hat`. Print this value to the console.
X_hat <- polls[1,8]/100
X_hat

# Calculate the standard error of `X_hat` and save it to a variable called `se_hat`. Print this value
# to the console.
se_hat <- sqrt(X_hat*(1 - X_hat)/N)
se_hat

# Use `qnorm` to calculate the 95% confidence interval for the proportion of Clinton voters. Save the
# lower and then the upper confidence interval to a variable called `ci`.
z <- 1 - ((1 - 0.95)/2)
qnorm(z)
ci <- c(X_hat - qnorm(0.975)*se_hat, X_hat + qnorm(0.975)*se_hat)   # en lugar de "qnorm(0.975)" se podria usar "qnorm(z)"



## Exercise 2. 
## POLLSTER RESULTS FOR 'p'

# Create a new object called 'pollster_results' that contains the pollster's name, the end date of the
# poll, the proportion of voters who declared a vote for Clinton, the standard error of this estimate,
# and the lower and upper bounds of the confidence interval for the estimate.

# Instructions

# a) Use the 'mutate' function to define four new columns: 'X_hat', 'se_hat', 'lower', and 'upper'. 
#    Temporarily add these columns to the 'polls' object that has already been loaded for you.

# b) In the 'X_hat' column, convert the raw poll results for Clinton to a proportion.

# c) In the 'se_hat' column, calculate the standard error of 'X_hat' for each poll using the 'sqrt' function.

# d) In the 'lower' column, calculate the lower bound of the 95% confidence interval using the 'qnorm' function.

# e) In the 'upper' column, calculate the upper bound of the 95% confidence interval using the 'qnorm' function.

# f) Use the 'select' function to select the columns from 'polls' to save to the new object 'pollster_results'.

# Code:

# The `polls` object that filtered all the data by date and nation has already been loaded. Examine
# it using the `head` function.

head(polls)

# Create a new object called `pollster_results` that contains columns for pollster name, end date, 
# X_hat, se_hat, lower confidence interval, and upper confidence interval for each poll.

pollster_results <- polls %>% 
                    mutate(X_hat = rawpoll_clinton/100, se_hat = sqrt(X_hat*(1-X_hat)/samplesize), 
                           lower = X_hat - qnorm(0.975)*se_hat, upper = X_hat + qnorm(0.975)*se_hat) %>% 
                    select(pollster, enddate, X_hat, se_hat, lower, upper)



## Exercise 3. 
## COMPARING TO ACTUAL RESULTS - p 

# The final tally for the popular vote was Clinton 48.2% and Trump 46.1%. Add a column called 'hit' 
# to 'pollster_results' that states if the confidence interval included the true proportion 'p = 0.482' or not. 
# What proportion of confidence intervals included 'p'?
  
# Instructions

# a) Finish the code to create a new object called 'avg_hit' by following these steps.

# b) Use the 'mutate' function to define a new variable called 'hit'.

# c) Use logical expressions to determine if each values in 'lower' and 'upper' span the actual proportion.

# d) Use the 'mean' function to determine the average value in 'hit' and summarize the results using 'summarize'.

# Code:

# The `pollster_results` object has already been loaded. Examine it using the `head` function.
head(pollster_results)

# Add a logical variable called `hit` that indicates whether the actual value exists within the 
# confidence interval of each poll. Summarize the average `hit` result to determine the proportion 
# of polls with confidence intervals include the actual value. Save the result as an object called `avg_hit`.
avg_hit <- pollster_results %>% mutate(hit = lower <= 0.482 & upper >= 0.482) %>% summarize(mean(hit))



## Exercise 4. 
## THEORY OF CONFIDENCE INTERVALS

# If these confidence intervals are constructed correctly, and the theory holds up, what proportion
# of confidence intervals should include 'p'?
  
# Instructions

# Possible Answers

# a) 0.05

# b) 0.31

# c) 0.50

# d) 0.95 (correcto)



## Exercise 5. 
## CONFIDENCE INTERVAL FOR 'd'

# A much smaller proportion of the polls than expected produce confidence intervals containing 'p'.
# Notice that most polls that fail to include 'p' are underestimating. The rationale for this is that
# undecided voters historically divide evenly between the two main candidates on election day.

# In this case, it is more informative to estimate the spread or the difference between the proportion
# of two candidates 'd', or '0.482 - 0.461 = 0.021' for this election.

# Assume that there are only two parties and that 'd = 2p - 1'. Construct a 95% confidence interval for
# difference in proportions on election night.

# Instructions

# a) Use the 'mutate' function to define a new variable called 'd_hat' in polls as the proportion of 
#    Clinton voters minus the proportion of Trump voters.

# b) Extract the sample size 'N' from the first poll in your subset object 'polls'.

# c) Extract the difference in proportions of voters 'd_hat' from the first poll in your subset object
#   'polls'.

# d) Use the formula above to calculate 'p' from 'd_hat'. Assign 'p' to the variable 'X_hat'.

# e) Find the standard error of the spread given 'N'. Save this as 'se_hat'.

# f) Calculate the 95% confidence interval of this estimate of the difference in proportions, 'd_hat',
#    using the 'qnorm' function.

# g) Save the lower and upper confidence intervals as an object called 'ci'. Save the lower confidence
#   interval first.

# Code:

# Add a statement to this line of code that will add a new column named `d_hat` to `polls`. The new column should contain the difference in the proportion of voters.
polls <- polls_us_election_2016 %>% filter(enddate >= "2016-10-31" & state == "U.S.") %>% mutate(d_hat = rawpoll_clinton/100 - rawpoll_trump/100)

# Assign the sample size of the first poll in `polls` to a variable called `N`. Print this value to the console.
N <- polls[1,6]
N

# Assign the difference `d_hat` of the first poll in `polls` to a variable called `d_hat`. Print this value to the console.
d_hat <- polls[1,16]
d_hat

# Assign proportion of votes for Clinton to the variable `X_hat`.
## X_hat = p
## X_hat = p = (d + 1)/2
X_hat <- (d_hat + 1)/2
X_hat

# Calculate the standard error of the spread and save it to a variable called `se_hat`. Print this value to the console.
se_hat1 = sqrt(X_hat*(1 - X_hat)/N)
## SE[spread] = 2 * SE[X_hat]
se_hat = 2 * se_hat1

# Use `qnorm` to calculate the 95% confidence interval for the difference in the proportions of voters. Save the lower and then the upper confidence interval to a variable called `ci`.
## q = 95%/100
## z = 1 - (1 - q)/2 = 1 - (1 - 0.95)/2 = 1 - 0.05/2 = 1 - 0.025 = 0.975
ci <- c(d_hat - qnorm(0.975)*se_hat, d_hat + qnorm(0.975)*se_hat)



## Exercise 6. 
## POLLSTER RESULTS FOR 'd'

# Create a new object called 'pollster_results' that contains the pollster's name, the end date of the
# poll, the difference in the proportion of voters who declared a vote either, and the lower and upper
# bounds of the confidence interval for the estimate.

# Instructions

# a) Use the 'mutate' function to define four new columns: 'X_hat', 'se_hat', 'lower', and 'upper'. 
#    Temporarily add these columns to the 'polls' object that has already been loaded for you.

# b) In the 'X_hat' column, calculate the proportion of voters for Clinton using 'd_hat'.

# c) In the 'se_hat' column, calculate the standard error of the spread for each poll using the 'sqrt' function.

# d) In the 'lower' column, calculate the lower bound of the 95% confidence interval using the 'qnorm' function.

# e) In the 'upper' column, calculate the upper bound of the 95% confidence interval using the 'qnorm' function.

# f) Use the 'select' function to select the 'pollster', 'enddate', 'd_hat', 'lower', 'upper' columns
#    from 'polls' to save to the new object 'pollster_results'.

# Code:

# The subset `polls` data with 'd_hat' already calculated has been loaded. Examine it using the `head` function.
head(polls)

# Create a new object called `pollster_results` that contains columns for pollster name, end date, 
# d_hat, lower confidence interval of d_hat, and upper confidence interval of d_hat for each poll.
pollster_results <- polls %>% 
                    mutate(X_hat = (d_hat + 1)/2, se_hat = 2 * sqrt(X_hat*(1-X_hat)/polls[,6]), 
                           lower = d_hat - qnorm(0.975)*se_hat, upper = d_hat + qnorm(0.975)*se_hat) %>% 
                    select(pollster, enddate, d_hat, lower, upper)



## Exercise 7. 
## COMPARING TO ACTUAL RESULTS - 'd'

# What proportion of confidence intervals for the difference between the proportion of voters included
# 'd', the actual difference in election day?
  
# Instructions

# a) Use the 'mutate' function to define a new variable within 'pollster_results' called 'hit'.

# b) Use logical expressions to determine if each values in 'lower' and 'upper' span the actual difference
#    in proportions of voters.

# c) Use the 'mean' function to determine the average value in 'hit' and summarize the results using 'summarize'.

# d) Save the result of your entire line of code as an object called 'avg_hit'.

# Code:

# The `pollster_results` object has already been loaded. Examine it using the `head` function.
head(pollster_results)

# Add a logical variable called `hit` that indicates whether the actual value (0.021) exists within 
# the confidence interval of each poll. Summarize the average `hit` result to determine the proportion
# of polls with confidence intervals include the actual value. Save the result as an object called `avg_hit`.
avg_hit <- pollster_results %>% mutate(hit = lower <= 0.021 & 0.021 <= upper) %>% summarize(mean(hit))



## Exercise 8. 
## COMPARING TO ACTUAL RESULTS BY POLLSTER

# Although the proportion of confidence intervals that include the actual difference between the proportion
# of voters increases substantially, it is still lower that 0.95. In the next chapter, we learn the 
# reason for this.

# To motivate our next exercises, calculate the difference between each poll's estimate 'd_bar'
 # and the actual 'd = 0.021'. Stratify this difference, or error, by pollster in a plot.

# Instructions

# a) Define a new variable errors that contains the difference between the estimated difference between
#    the proportion of voters and the actual difference on election day, 0.021.

# b) To create the plot of errors by pollster, add a layer with the function geom_point. The aesthetic
#    mappings require a definition of the x-axis and y-axis variables. So the code looks like the example
#    below, but you fill in the variables for x and y.

# c) The last line of the example code adjusts the x-axis labels so that they are easier to read.

# data %>% ggplot(aes(x = , y = )) +
#   geom_point() +
#   theme(axis.text.x = element_text(angle = 90, hjust = 1))

# Code:

# The `polls` object has already been loaded. Examine it using the `head` function.
head(polls)

# Add variable called `error` to the object `polls` that contains the difference between 'd_hat' and the
# actual difference on election day. Then make a plot of the error stratified by pollster.
polls <-  polls %>% mutate(errors = d_hat - 0.021)

polls %>% ggplot(aes(pollster, errors)) +
  geom_point() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))



## Exercise 9. 
## COMPARING TO ACTUAL RESULTS BY POLLSTER - MULTIPLE POLLS 

# Remake the plot you made for the previous exercise, but only for pollsters that took five or more
# polls.

# You can use dplyr tools 'group_by' and 'n' to group data by a variable of interest and then count
# the number of observations in the groups. The function 'filter' filters data piped into it by your
# specified condition.

# For example:
  
  data %>% group_by(variable_for_grouping) %>% 
    filter(n() >= 5)

# Instructions

# a) Define a new variable 'errors' that contains the difference between the estimated difference
#    between the proportion of voters and the actual difference on election day, 0.021.

# b) Group the data by pollster using the 'group_by' function.

# c) Filter the data by pollsters with 5 or more polls.

# d) Use 'ggplot' to create the plot of errors by pollster.

# e) Add a layer with the function 'geom_point'.

# Code:

# The `polls` object has already been loaded. Examine it using the `head` function.
head(polls)
  
# Add variable called `error` to the object `polls` that contains the difference between 'd_hat' and
# the actual difference on election day. Then make a plot of the error stratified by pollster, but
# only for pollsters who took 5 or more polls.
polls %>% mutate(d_hat = rawpoll_clinton/100 - rawpoll_trump/100, errors = d_hat - 0.021) %>% 
  group_by(pollster) %>% 
  filter(n() >= 5) %>% 
  ggplot(aes(pollster, errors)) + 
    geom_point() + 
    theme(axis.text.x = element_text(angle = 90, hjust = 1))

