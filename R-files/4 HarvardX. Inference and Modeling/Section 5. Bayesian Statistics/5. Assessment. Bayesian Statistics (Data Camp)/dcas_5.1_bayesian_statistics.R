##  BAYESIAN STATISTICS

## 2023.02.13


## El 'set.seed()' que se usa aqui no concuerda con los resultados obtenidos al aplicar la misma funcion
## en DataCamp.


## Exercise 1.
## STATISTICS IN THE COURTROOM

# In 1999 in England Sally Clark was found guilty of the murder of two of her sons. Both infants were
# found dead in the morning, one in 1996 and another in 1998, and she claimed the cause of death was
# sudden infant death syndrome (SIDS). No evidence of physical harm was found on the two infants so 
# the main piece of evidence against her was the testimony of Professor Sir Roy Meadow, who testified
# that the chances of two infants dying of SIDS was 1 in 73 million. He arrived at this figure by 
# finding that the rate of SIDS was 1 in 8,500 ( Pr(first case of SIDS) = 1/8500 = 0.0001176471 ) and 
# then calculating that the chance of two SIDS cases was 8,500 X 8,500 ~ 73 million.

# Based on what we've learned throughout this course, which statement best describes a potential flaw 
# in Sir Meadow's reasoning?
  
# Instructions

# Possible Answers

# a) Sir Meadow assumed the second death was independent of the first son being affected, thereby 
# ignoring possible genetic causes.   (correcto)

# b) There is no flaw. The multiplicative rule always applies in this way: Pr(A and B) = Pr(A)*Pr(B)
  
# c) Sir Meadow should have added the probabilities: Pr(A and B) = Pr(A) + Pr(B)
  
# d) The rate of SIDS is too low to perform these types of statistics.



## Exercise 2. 
## RECALCULATING THE SIDS STATISTICS

# Let's assume that there is in fact a genetic component to SIDS and the probability of 
# Pr(second case of SIDS | first case of SIDS) = 1/100, is much higher than 1 in 8,500 ( Pr(first case of SIDS ).

# What is the probability of both of Sally Clark's sons dying of SIDS?
  
# Instructions

# 1) Calculate the probability of both sons dying to SIDS.

# Code:

# BAYES THEOREM:
# Pr(A|B) = Pr(A and B) / Pr(B)
# Pr_2 = Pr_2n1 / Pr_1

# Define `Pr_1` as the probability of the first son dying of SIDS
Pr_1 <- 1/8500    # Pr_1 = Pr(B) = Pr(first case of SIDS)

# Define `Pr_2` as the probability of the second son dying of SIDS       ## [once the first son died].
Pr_2 <- 1/100     # Pr_2 = Pr(A|B) = Pr(second case of SIDS | first case of SIDS)

# Calculate the probability of both sons dying of SIDS. Print this value to the console.
Pr_2n1 <- Pr_2 * Pr_1    # Pr(A and B) = Pr(A|B) * Pr(B) ---> 
                         # Pr(second case of SIDS and first case of SIDS) = Pr(second case of SIDS | first case of SIDS) * Pr(first case of SIDS)

Pr_2n1                   # Pr_2n1 = Pr(A and B) = 1.176471e-06



## Exercise 3.
## BAYES'S RULE IN THE COURTROOM

# Many press reports stated that the expert claimed the probability of Sally Clark being innocent as 
# 1 in 73 million (1/73000000 = 0.00000001369863). Perhaps the jury and judge also interpreted the 
# testimony this way. This probability can be written like this:
  
# Pr(mother is a murderer | two children found dead with no evidence of harm)
  
# Bayes' rule tells us this probability is equal to:


### BAYES THEOREM:

### Pr(A|B) = Pr(A and B) / Pr(B)    --->    Pr(A and B) = Pr(B|A) * Pr(A)
### Pr(A|B) = Pr(B|A) * Pr(A) / Pr(B)

### Pr(A|B) = Pr(mother is a murderer | two children found dead with no evidence of harm)
### Pr(B|A) = Pr(two children found dead with no evidence of harm | mother is a murderer)
### Pr(A) =   Pr(mother is a murderer)
### Pr(B) =   Pr(two children found dead with no evidence of harm)

### Pr(mother is a murderer | two children found dead with no evidence of harm) = 
### = [Pr(two children found dead with no evidence of harm | mother is a murderer) * Pr(mother is a murderer)] / [Pr(two children found dead with no evidence of harm)]

  
# Instructions

# Possible Answers

# a) [Pr(two children found dead with no evidence of harm) * Pr(mother is a murderer)] / [Pr(two children found dead with no evidence of harm)]

# b) Pr(two children found dead with no evidence of harm) * Pr(mother is a murderer)

# c) [Pr(two children found dead with no evidence of harm | mother is a murderer) * Pr(mother is a murderer)] / [Pr(two children found dead with no evidence of harm)] (correcto)

# d) 1/8500



## Exercise 4.
## CALCULATE THE PROBABILITY.

# Assume that the probability of a murderer finding a way to kill her two children without leaving 
# evidence of physical harm is:

# Pr(two children found dead with no evidence of harm | mother is a murderer) = 0.50    # Pr(B|A)
  
# Assume that the murder rate among mothers is 1 in 1,000,000. ## 1/1000000 = 0.000001

# Pr(mother is a murderer) = 1/1000000 = 0.000001    # Pr(A)

# According to Bayes' rule, 


### BAYES THEOREM:

### Pr(A|B) = Pr(A and B) / Pr(B)    --->    Pr(A and B) = Pr(B|A) * Pr(A)
### Pr(A|B) = Pr(B|A) * Pr(A) / Pr(B)



# what is the probability of:

# Pr(mother is a murderer | two children found dead with no evidence of harm)

# Instructions

# 1) Use Bayes' rule to calculate the probability that the mother is a murderer, considering the rates
#    of murdering mothers in the population, the probability that two siblings die of SIDS, and the 
#    probability that a murderer kills children without leaving evidence of physical harm.

# 2) Print your result to the console.

# Code:

### Here starts the first, 1st, application of Bayes' Theorem (exercise 1-2):

# Define `Pr_1` as the probability of the first son dying of SIDS
Pr_1 <- 1/8500   # Pr(B)

# Define `Pr_2` as the probability of the second son dying of SIDS
## [once the first son died].
Pr_2 <- 1/100    # Pr(A|B)

# Define `Pr_B` as the probability of both sons dying of SIDS
Pr_B <- Pr_1*Pr_2    # Pr(A and B)

### Here starts the second, 2nd, application of Bayes' Theorem:

# Define Pr_A as the rate of mothers that are murderers
Pr_A <- 1/1000000    # Pr(A)

# Define Pr_BA as the probability that two children die without evidence of harm, given that their mother is a murderer
Pr_BA <- 0.50    # Pr(B|A)

# Define Pr_AB as the probability that a mother is a murderer, given that her two children died with no evidence of physical harm. Print this value to the console.
Pr_AB <- (Pr_BA * Pr_A) / Pr_B    # Pr(A|B)
Pr_AB    # 0.4249999 ~= 0.425



## Exercise 5. 
## MISUSE OF STATISTICS IN THE COURTS

# After Sally Clark was found guilty, the Royal Statistical Society issued a statement saying that 
# there was "no statistical basis" for the expert's claim. They expressed concern at the "misuse of
# statistics in the courts". Eventually, Sally Clark was acquitted in June 2003.

# In addition to misusing the multiplicative rule as we saw earlier, what else did Sir Meadow miss?

# Instructions

# Possible Answers

# a) He made an arithmetic error in forgetting to divide by the rate of SIDS in siblings.

# b) He did not take into account how rare it is for a mother to murder her children. (correcto)

# c) He mixed up the numerator and denominator of Bayes' rule.

# d) He did not take into account murder rates in the population.



## Exercise 6.
## BACK TO ELECTION POLLS

# Florida is one of the most closely watched states in the U.S. election because it has many electoral
# votes and the election is generally close. Create a table with the poll spread results from Florida
# taken during the last days before the election using the sample code.

# The CLT tells us that the average of these spreads is approximately normal. Calculate a spread average
# and provide an estimate of the standard error.

# Instructions:

# 1) Calculate the average of the spreads. Call this average 'avg' in the final table.

# 2) Calculate an estimate of the standard error of the spreads. Call this standard error 'se' in the final 
#    table.

# 3) Use the 'mean' and 'sd' functions nested within 'summarize' to find the average and standard deviation of
#    the grouped 'spread' data.

# 4) Save your results in an object called 'results'.

# Code:

# Load the libraries and poll data
library(dplyr)
library(dslabs)
data(polls_us_election_2016)

# Create an object `polls` that contains the spread of predictions for each candidate in Florida during
# the last polling days
polls <- polls_us_election_2016 %>% 
  filter(state == "Florida" & enddate >= "2016-11-04" ) %>% 
  mutate(spread = rawpoll_clinton/100 - rawpoll_trump/100)

# Examine the `polls` object using the `head` function
head(polls)

# Create an object called `results` that has two columns containing the average spread (`avg`) and 
# the standard error (`se`). Print the results to the console.
results <- polls %>% summarize(avg = mean(spread), se = sd(spread)/sqrt(n()))
results
#       avg      se_hat
#  0.004154545 0.007218692


## Exercise 7.
## THE PRIOR DISTRIBUTION

# Assume a Bayesian model sets the prior distribution for Florida's election night spread 'd' to be
# normal with expected value ?? ('mu') and standard deviation ?? ('tau').

# What are the interpretations of ?? ('mu') and ?? ('tau')?

# Instructions

# Possible Answers

# a) ?? ('mu') and ?? ('tau') are arbitrary numbers that let us make probability statements about 'd'.

# b) ?? ('mu') and ?? ('tau') summarize what we would predict for Florida before seeing any polls. (correcto)

# c) ?? ('mu') and ?? ('tau') summarize what we want to be true. We therefore set ?? at 0.10 and ?? at 0.01.

# d) The choice of prior has no effect on the Bayesian analysis.



## Exercise 8.
## ESTIMATE THE POSTERIOR DISTRIBUTION 

# The CLT tells us that our estimate of the spread 'd_hat' has a normal distribution with expected value 'd' and 
# standard deviation ?? ('sigma'), which we calculated in a previous exercise.

# Use the formulas for the posterior distribution to calculate the expected value of the posterior 
# distribution if we set ?? ('mu') = 0 and ?? ('tau') = 0.01.

# Instructions

# 1) Define ?? ('mu') and ?? ('tau').

# 2) Identify which elements stored in the object 'results' represent ?? ('sigma') and 'Y'. 

# 3) Estimate 'B' using ?? ('sigma') and ?? ('tau').

# 4) Estimate the posterior distribution using 'B', ?? ('sigma'), and 'Y'.

# Code:

# The results` object has already been loaded. Examine the values stored: `avg` and `se` of the spread
results

# Define `mu` and `tau`
mu <- 0
tau <- 0.01

# Define a variable called `sigma` that contains the standard error in the object `results`
sigma <- results$se    #results[,2]

# Define a variable called `Y` that contains the average in the object `results`
Y <- results$avg    #results[,1]

# Define a variable `B` using `sigma` and `tau`. Print this value to the console.
B <- sigma^2 / (sigma^2 + tau^2)

# Calculate the expected value of the posterior distribution
p <- mu + (1 - B)*(Y - mu)
p
# 0.002731286



## Exercise 9.
# STANDARD ERROR OF THE POSTERIOR DISTRIBUTION

#Compute the standard error of the posterior distribution.

# Instructions

# 1) Using the variables we have defined so far, calculate the standard error of the posterior distribution.

# 2) Print this value to the console.

# Code:

# Here are the variables we have defined
mu <- 0
tau <- 0.01
sigma <- results$se
Y <- results$avg
B <- sigma^2 / (sigma^2 + tau^2)

# Compute the standard error of the posterior distribution. Print this value to the console.
se <- sqrt(1 / ((1/sigma^2) + (1/tau^2)))
se
# 0.005853024



## Exercise 10.
## CONSTRUCTING A CREDIBLE INTERVAL

# Using the fact that the posterior distribution is normal, create an interval that has a 95% of 
# occurring centered at the posterior expected value. Note that we call these credible intervals.

# Instructions

# 1) Calculate the 95% credible intervals using the 'qnorm' function.
# 2) Save the lower and upper confidence intervals as an object called 'ci'. Save the lower confidence
#    interval first.

# Code:

# Here are the variables we have defined in previous exercises
mu <- 0
tau <- 0.01
sigma <- results$se
Y <- results$avg
B <- sigma^2 / (sigma^2 + tau^2)
se <- sqrt( 1/ (1/sigma^2 + 1/tau^2))

# Construct the 95% credible interval. Save the lower and then the upper confidence interval to a 
# variable called `ci`.
p <- mu + (1 - B)*(Y - mu) 
ci <- c(p - qnorm(0.975)*se, p + qnorm(0.975)*se)
p   # 0.002731286
ci  # -0.008740432,  0.014203003



## Exercise 11.
## ODDS OF WINNING FLORIDA

# According to this analysis, what was the probability that Trump wins Florida?
  
# Instructions

# Using the 'pnorm' function, calculate the probability that the spread in Florida was less than 0.

# Code:

# Assign the expected value of the posterior distribution to the variable `exp_value`
exp_value <- B*mu + (1-B)*Y 

# Assign the standard error of the posterior distribution to the variable `se`
se <- sqrt( 1/ (1/sigma^2 + 1/tau^2))

# Using the `pnorm` function, calculate the probability that the actual spread was less than 0 (in 
# Trump's favor). Print this value to the console.
pnorm(0, exp_value, se)    # 0.3203769



## Exercise 12.
## CHANGE THE PRIORS
 
# We had set the prior variance ?? ('tau') to 0.01, reflecting that these races are often close.

# Change the prior variance to include values ranging from 0.005 to 0.05 and observe how the probability
# of Trump winning Florida changes by making a plot.

# Instructions

# 1) Create a vector of values of 'taus' by executing the sample code.

# 2) Create a function using 'function(){}' called 'p_calc' that takes the value 'tau' as the only 
#    argument, then calculates 'B' from 'tau' and 'sigma', and then calculates the probability of
#    Trump winning, as we did in the previous exercise.

# 3) Apply your 'p_calc' function across all the new values of 'taus'.

# 4) Use the 'plot' function to plot ?? ('tau') on the x-axis and the new probabilities on the y-axis.

# Code:

# Define the variables from previous exercises
mu <- 0
sigma <- results$se
Y <- results$avg

# Define a variable `taus` as different values of tau
taus <- seq(0.005, 0.05, len = 100)

# Create a function called `p_calc` that generates `B` and calculates the probability of the spread being less than 0
p_calc <- function(x) {
  B <- sigma^2 / (sigma^2 + x^2)
  exp_value <- B * mu + (1 - B) * Y
  se <- sqrt(1 / (1/sigma^2 + 1/x^2))
  pnorm(0, exp_value, se)
}

# Create a vector called `ps` by applying the function `p_calc` across values in `taus`
ps <- p_calc(taus)

# Plot `taus` on the x-axis and `ps` on the y-axis
plot(taus, ps)


