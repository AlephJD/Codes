## ASSESSMENT OF THE BIG SHORT.

## 2021.07.18


library(tidyverse)
library(dslabs)

data(death_prob)
head(death_prob)


## QUESTIONS 1 AND 2: INSURANCE RATES, PART 1

# Use the information below as you answer this 6-part question.

# An insurance company offers a one-year term life insurance policy that pays $150,000 in the event
# of death within one year. The premium (annual cost) for this policy for a 50 year old female is 
# $1,150. Suppose that in the event of a claim, the company forfeits the premium and loses a total 
# of $150,000, and if there is no claim the company gains the premium amount of $1,150. The company
# plans to sell 1,000 policies to this demographic.



# Question 1a
# The 'death_prob' data frame from the dslabs package contains information about the estimated probability
# of death within 1 year ('prob') for different ages and sexes.

# Use 'death_prob' to determine the death probability of a 50 year old female, 'p'.

#death_prob$prob[filter(death_prob, sex == "Female") == "50"]

fem <- filter(death_prob, sex == "Female")
p <- fem$prob[fem$age == "50"]
p
# [1] 0.003193 (correcto)


# Question 1b
# The loss in the event of the policy holder's death is -$150,000 and the gain if the policy holder 
# remains alive is the premium $1,150.

# What is the expected value of the company's net profit on one policy for a 50 year old female?   
# n * (ap + b*q)

# n <- 1
loss <- -150000
gain <- 1150

ev_fem_50 <- loss*p + gain*(1-p)
ev_fem_50
# [1] 667.3781


# Question 1c
# Calculate the standard error of the profit on one policy for a 50 year old female.   
# sqrt(n)*abs(b-a)*sqrt(p*q)

# n <- 1
se_fem_50 <- abs(gain-loss)*sqrt(p*(1-p))
se_fem_50
# [1] 8527.332 (correcto)


# Question 1d
# What is the expected value of the company's profit over all 1,000 policies for 50 year old females?   
# E[X] = n * (a*p + b*q)

n <- 1000
ev_1000 <- n * ev_fem_50
# [1] 667378.1 (correcto)


# Question 1e
# What is the standard error of the sum of the expected value over all 1,000 policies for 50 year old 
# females?
# SE[X]= sqrt(n) * abs(b-a) * sqrt(p*q)

se_1000 <- sqrt(n) * abs(gain - loss) * sqrt(p*(1-p))
# [1] 269657.9 (correcto)


# Question 1f
# Use the Central Limit Theorem to calculate the probability that the insurance company loses money on
# this set of 1,000 policies.

pnorm(0, ev_1000, se_1000)
# [1] 0.006663556 (correcto)


# 50 year old males have a different probability of death than 50 year old females. We will calculate
# a profitable premium for 50 year old males in the following four-part question.



# Question 2a
# Use 'death_prob' to determine the probability of death within one year for a 50 year old male.   
male <- filter(death_prob, sex == "Male")
p <- male$prob[male$age =="50"]
p
# [1] 0.005013 (correcto)


# Question 2b
# Suppose the company wants its expected profits from 1,000 50 year old males with $150,000 life 
# insurance policies to be $700,000. Use the formula for expected value of the sum of draws with the
# following values and solve for the premium 'b':


# E[S] = ??_S = 700000

# n = 1000

# p = death probability of age 50 male

# a = 150000

# b = premium


# What premium should be charged?
# E[S] = n * (a*p + b*q)
# (E[S]/n - a*p)/(1-p)
ev_male_50 <- 700000

gain <- (ev_male_50/n - loss*p)/(1-p)
gain
# [1] 1459.265 (correcto)


# Question 2c
# Using the new 50 year old male premium rate, calculate the standard error of the sum of 1,000 
# premiums.
se_male_50 <- sqrt(n) * abs(gain - loss) * sqrt(p*(1-p))
# [1] 338262.1 (correcto)



# Question 2d
# What is the probability of losing money on a series of 1,000 policies to 50 year old males?
# Use the Central Limit Theorem.
pnorm(0, ev_male_50, se_male_50)
# [1] 0.01925424 (correcto)


###################################################################################################
###################################################################################################



## QUESTIONS 3 AND 4: INSURANCE RATES, PART 2

# Life insurance rates are calculated using mortality statistics from the recent past. They are priced
# such that companies are almost assured to profit as long as the probability of death remains similar.
# If an event occurs that changes the probability of death in a given age group, the company risks 
# significant losses.

# In this 6-part question, we'll look at a scenario in which a lethal pandemic disease increases the 
# probability of death within 1 year for a 50 year old to 0.015. Unable to predict the outbreak, the
# company has sold 1,000 $150,000 life insurance policies for $1,150.

p_new <- 0.015
loss <- -150000
gain <- 1150

# Question 3a
# What is the expected value of the company's profits over 1,000 policies?

ev_new_50 <- n * (loss*p_new + gain*(1-p_new))
ev_new_50  
# [1] -1117250 (correcto)

# Question 3b
# What is the standard error of the expected value of the company's profits over 1,000 policies?   
se_new_50 <- sqrt(n) * abs(gain - loss) * sqrt(p_new * (1-p_new))
se_new_50
# [1] 580994.3 (correcto)


# Question 3c
# What is the probability of the company losing money?
pnorm(0, ev_new_50, se_new_50)
# [1] 0.9727597 (correcto)


# Question 3d
# Suppose the company can afford to sustain one-time losses of $1 million, but larger losses will 
# force it to go out of business.
# What is the probability of losing more than $1 million?
pnorm(-10^6, ev_new_50, se_new_50)
# [1] 0.5799671 (correcto)

  
# Question 3e
# Investigate death probabilities 'p <- seq(.01, .03, .001)'.
# What is the lowest death probability for which the chance of losing money exceeds 90%?   

p <- seq(.01, .03, .001)
p
# [1] 0.010 0.011 0.012 0.013 0.014 0.015 0.016 0.017 0.018 0.019 0.020 0.021 0.022 0.023 0.024 0.025 0.026 0.027 0.028
# [20] 0.029 0.030

ev <- n * (loss*p + gain*(1-p))
se <- sqrt(n) * abs(gain - loss) * sqrt(p*(1-p))

pnorm(0, ev, se)
# [1] 0.7764088 0.8480948 0.8989232 0.9338629 0.9573137 0.9727597 0.9827809 0.9892027 0.9932761 0.9958377 0.9974369
# [12] 0.9984289 0.9990410 0.9994167 0.9996465 0.9997864 0.9998713 0.9999226 0.9999536 0.9999723 0.9999834
min(p[pnorm(0, ev, se) > 0.9])
# [1] 0.013 (correcto)


# Question 3f
# Investigate death probabilities 'p <- seq(.01, .03, .0025)'.
# What is the lowest death probability for which the chance of losing over $1 million exceeds 90%?   

p <- seq(.01, .03, .0025)
p
#[1] 0.0100 0.0125 0.0150 0.0175 0.0200 0.0225 0.0250 0.0275 0.0300

ev <- n * (loss*p + gain*(1-p))
se <- sqrt(n) * abs(gain - loss) * sqrt(p*(1-p))

pnorm(-10^6, ev, se)
# [1] 0.08970652 0.31179203 0.57996705 0.78523309 0.90398581 0.96118786 0.98546733 0.99487271 0.99827462
min(p[pnorm(-10^6, ev, se) > 0.9])
# [1] 0.02 (correcto)



# Question 4, which has two parts, continues the scenario from Question 3.

# Question 4a
# Define a sampling model for simulating the total profit over 1,000 loans with probability of claim
# p_loss = .015, loss of -$150,000 on a claim, and profit of $1,150 when there is no claim. Set the 
# seed to 25, then run the model once.

set.seed(25, sample.kind = "Rounding")    # will make R 3.6 generate a seed as in R 3.5

# (IMPORTANT! If you use R 3.6 or later, you will need to use the command 'set.seed(x, sample.kind = "Rounding")' instead of 'set.seed(x)'.
# Your R version will be printed at the top of the Console window when you start RStudio.)

# What is the reported profit (or loss) in millions (that is, divided by 10^6)?
n <- 1000
loss <- -150000
gain <- 1150
p_loss <- 0.015

X <- sample(c(loss, gain), n, replace = TRUE, prob = c(p_loss, 1-p_loss))
S <- sum(X)
S
# [1] -1419550
S/10^6
# [1] -1.41955

   
# Question 4b
# Set the seed to 27, then run a Monte Carlo simulation of your sampling model with 10,000 replicates
# to simulate the range of profits/losses over 1,000 loans.

set.seed(27, sample.kind = "Rounding")    # will make R 3.6 generate a seed as in R 3.5

# (IMPORTANT! If you use R 3.6 or later, you will need to use the command set.seed(x, sample.kind = "Rounding") instead of set.seed(x).
# Your R version will be printed at the top of the Console window when you start RStudio.)

# What is the observed probability of losing $1 million or more?
B <- 10^4
S <- replicate(B, {
   X <- sample(c(loss, gain), n, replace = TRUE, prob = c(p_loss, 1-p_loss))
   sum(X)
})

mean(S <= -10^6)
# [1] 0.5388 (correcto)



###################################################################################################
###################################################################################################



## QUESTIONS 5 AND 6: INSURANCE RATES, PART 3

# Question 5, which has 4 parts, continues the pandemic scenario from Questions 3 and 4.
# Suppose that there is a massive demand for life insurance due to the pandemic, and the company wants
# to find a premium cost for which the probability of losing money is under 5%, assuming the death 
# rate stays stable at 'p = 0.015'.



# Question 5a
# Calculate the premium required for a 5% chance of losing money given 'n = 1000' loans, probability
# of death 'p = 0.015', and loss per claim 'l = -150000'. Save this premium as 'x' for use in further 
# questions.

# Pr(Z < z) = 0.05
z <- qnorm(0.05)
# [1] -1.644854

n <- 1000
p <- 0.015
l <- -150000

x <- -l*( n*p - z*sqrt(n*p*(1-p))) / ( n*(1-p) + z*sqrt(n*p*(1-p)))
x
# [1] 3268.063 (correcto)


# Question 5b
# What is the expected profit per policy at this rate?
# n * (a*p + b*q)
# n = 1

ev <- (l*p + x*(1-p))
ev   
# [1] 969.0422 (correcto)


# Question 5c
# What is the expected profit over 1,000 policies?
# n * (a*p + b*q)
# n = 1000

n <- 1000
ev <- n * (l*p + x*(1-p))
ev   
# [1] 969042.2


# Question 5d
# Run a Monte Carlo simulation with 'B = 10000' to determine the probability of losing money on 1,000
# policies given the new premium 'x', loss on a claim of $150,000, and probability of claim 'p = 0.015'.
# Set the seed to 28 before running your simulation.

set.seed(28, sample.kind = "Rounding")    # will make R 3.6 generate a seed as in R 3.5

# (IMPORTANT! If you use R 3.6 or later, you will need to use the command 'set.seed(x, sample.kind = "Rounding")' 
# instead of 'set.seed(x)'. Your R version will be printed at the top of the Console window when you start RStudio.)

# What is the probability of losing money here?
B <- 10000
n <- 1000
l <- -150000
x <- 3268.063
p <- 0.015 

S <- replicate(B, {
   X <- sample(c(l,x), n, replace = TRUE, prob = c(p, 1-p))
   sum(X)
})

mean(S < 0)  
# [1] 0.0554 (correcto)



# The company cannot predict whether the pandemic death rate will stay stable. Set the seed to 29, 
# then write a Monte Carlo simulation that for each of B=10000 iterations:

#	   * randomly changes 'p' by adding a value between -0.01 and 0.01 with 'sample(seq(-0.01, 0.01, length = 100), 1)'.

#	   * uses the new random 'p' to generate a sample of 'n = 1000' policies with premium 'x' and loss per claim 'l = -150000'

#    * returns the profit over 'n' policies (sum of random variable)

# (IMPORTANT! If you use R 3.6 or later, you will need to use the command 'set.seed(x, sample.kind = "Rounding")' instead of 'set.seed(x)'. 
# Your R version will be printed at the top of the Console window when you start RStudio.)


# The outcome should be a vector of 'B' total profits. Use the results of the Monte Carlo simulation 
# to answer the following three questions.

# (Hint: Use the process from lecture for modeling a situation for loans that changes the probability of default for all borrowers simultaneously.)


set.seed(29, sample.kind = "Rounding")    # will make R 3.6 generate a seed as in R 3.5

B <- 10000
n <- 1000
l <- -150000
x <- 3268.063
p <- 0.015 

S <- replicate(B, {
   new_p <- p + sample(seq(-0.01, 0.01, length = 100), 1)
   X <- sample(c(l,x), n, replace = TRUE, prob = c(new_p, 1-new_p))
   sum(X)
})



# Question 6a
# What is the expected value over 1,000 policies?
mean(S)
# [1] 968306.4 (correcto)


# Question 6b
# What is the probability of losing money?
mean(S < 0)  
# [1] 0.1908 (correcto)

# Question 6c
# What is the probability of losing more than $1 million?
mean(S < -10^6)
# [1] 0.0424 (correcto)

