# The Birthday problem (from Book)
# https://rafalab.github.io/dsbook/probability.html#examples

# 2021.04.09


# Suppose you are in a classroom with 50 people. If we assume this is a randomly selected group
# of 50 people, what is the chance that at least two people have the same birthday? Although it 
# is somewhat advanced, we can deduce this mathematically. We will do this later. Here we use a
# Monte Carlo simulation. For simplicity, we assume nobody was born on February 29. This actually
# doesn't change the answer much.

# First, note that birthdays can be represented as numbers between 1 and 365, so a sample of 50 
# birthdays can be obtained like this:


n <- 50
bday <- sample(1:365, n, replace = TRUE)


# To check if in this particular set of 50 people we have at least two with the same birthday, we
# can use the function duplicated, which returns TRUE whenever an element of a vector is a duplicate.
# Here is an example:


duplicated(c(1,2,3,1,4,3,5))


# The second time 1 and 3 appear, we get a TRUE. So to check if two birthdays were the same, we simply 
# use the any and duplicated functions like this:

any(duplicated(bday))

# [1] TRUE


# In this case, we see that it did happen. At least two people had the same birthday.

# To estimate the probability of a shared birthday in the group, we repeat this experiment by sampling 
# sets of 50 birthdays over and over:


B <- 10000

same_birthday <- function(n){
  bdays <- sample(1:365, n, replace = TRUE)
  any(duplicated(bdays))
}

results <- replicate(B, same_birthday(50))
mean(results)
# [1] 0.968


# Were you expecting the probability to be this high?
  
# People tend to underestimate these probabilities. To get an intuition as to why it is so high, think
# about what happens when the group size is close to 365. At this stage, we run out of days and the 
# probability is one.


# Say we want to use this knowledge to bet with friends about two people having the same birthday in a
# group of people. When are the chances larger than 50%? Larger than 75%?
  
# Let's create a look-up table. We can quickly create a function to compute this for any group size:


compute_prob <- function(n, B = 10000){
  results <- replicate(B, same_birthday(n))
  mean(results)
}


# Using the function "sapply", we can perform element-wise operations on any function:


n <- seq(1,60)
prob <- sapply(n, compute_prob)


# We can now make a plot of the estimated probabilities of two people having the same birthday in a group
# of size "n":

library(tidyverse)
prob <- sapply(n, compute_prob)
qplot(n, prob)




# Now let's compute the exact probabilities rather than use Monte Carlo approximations. Not only do we get
# the exact answer using math, but the computations are much faster since we don't have to generate experiments.

# To make the math simpler, instead of computing the probability of it happening, we will compute the 
# probability of it not happening. For this, we use the multiplication rule.

# Let's start with the first person. The probability that person 1 has a unique birthday is 1. The probability
# that person 2 has a unique birthday, given that person 1 already took one, is 364/365. Then, given that the
# first two people have unique birthdays, person 3 is left with 363 days to choose from. We continue this way
# and find the chances of all 50 people having a unique birthday is:


# 1x(364/365)x(363/365)x...x( (365 - n + 1)/365)

# We can write a function that does this for any number:


exact_prob <- function(n){
  prob_unique <- seq(365, 365-n+1)/365
  1 - prod(prob_unique)
}

eprob <- sapply(n, exact_prob)
qplot(n, prob) + geom_line(aes(n,eprob), col = "red")


# This plot shows that the Monte Carlo simulation provided a very good estimate of the exact probability. 
# Had it not been possible to compute the exact probabilities, we would have still been able to accurately
# estimate the probabilities.

