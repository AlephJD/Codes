## Assessment: Continuous Probability

# 2021.05.05


## EXERCISE 1. 
## DISTRIBUTION OF FEMALE HEIGHTS - 1

# Assume the distribution of female heights is approximated by a normal distribution with a mean of
# 64 inches and a standard deviation of 3 inches. If we pick a female at random, what is the probability
# that she is 5 feet or shorter?
  
# Instructions
# Use 'pnorm' to define the probability that a height will take a value less than 5 feet given the
# stated distribution.

# CODE

# Assign a variable 'female_avg' as the average female height.
female_avg <- 64

# Assign a variable 'female_sd' as the standard deviation for female heights.
female_sd <- 3

# Using variables 'female_avg' and 'female_sd', calculate the probability that a randomly selected 
# female is shorter than 5 feet. Print this value to the console.
# Note: 1 foot is equivalent to 12 inches: 1 f - 12 in
# F(a):

pnorm(5*12, female_avg, female_sd)
# [1] 0.09121122 (correcto)



## EXERCISE 2. 
## DISTRIBUTION OF FEMALE HEIGHTS - 2

# Assume the distribution of female heights is approximated by a normal distribution with a mean of
# 64 inches and a standard deviation of 3 inches. If we pick a female at random, what is the probability
# that she is 6 feet or taller?
  
# Instructions

# Use 'pnorm' to define the probability that a height will take a value of 6 feet or taller.

# CODE

# Assign a variable 'female_avg' as the average female height.
female_avg <- 64

# Assign a variable 'female_sd' as the standard deviation for female heights.
female_sd <- 3

# Using variables 'female_avg' and 'female_sd', calculate the probability that a randomly selected
# female is 6 feet or taller. Print this value to the console.
# 1- F(a):

1 - pnorm(6*12, female_avg, female_sd)

# [1] 0.003830381 (correcto)



## EXERCISE 3. 
## DISTRIBUTION OF FEMALE HEIGHTS - 3

# Assume the distribution of female heights is approximated by a normal distribution with a mean of
# 64 inches and a standard deviation of 3 inches. If we pick a female at random, what is the probability
# that she is between 61 and 67 inches?
  
# Instructions

# a) Use 'pnorm' to define the probability that a randomly chosen woman will be shorter than 67 inches.

# b) Subtract the probability that a randomly chosen will be shorter than 61 inches.

# CODE

# Assign a variable 'female_avg' as the average female height.
female_avg <- 64

# Assign a variable 'female_sd' as the standard deviation for female heights.
female_sd <- 3

# Using variables 'female_avg' and 'female_sd', calculate the probability that a randomly selected
# female is between the desired height range. Print this value to the console.
# F(b) - F(a):

pnorm(67, female_avg, female_sd) - pnorm(61, female_avg, female_sd)
# [1] 0.6826895 (correcto)



## EXERCISE 4.
## DISTRIBUTION OF FEMALE HEIGHTS - 4

# Repeat the previous exercise, but convert everything to centimeters. That is, multiply every height,
# including the standard deviation, by 2.54. What is the answer now?
  
# Instructions

# a) Convert the average height and standard deviation to centimeters by multiplying each value by 2.54.

# b) Repeat the previous calculation using pnorm to define the probability that a randomly chosen woman
# will have a height between 61 and 67 inches, converted to centimeters by multiplying each value by 2.54.

# CODE

# Assign a variable 'female_avg' as the average female height. Convert this value to centimeters.
female_avg <- 64*2.54

# Assign a variable 'female_sd' as the standard deviation for female heights. Convert this value to
# centimeters.
female_sd <- 3*2.54

# Using variables 'female_avg' and 'female_sd', calculate the probability that a randomly selected female
# is between the desired height range. Print this value to the console.
# F(b) - F(a):

pnorm(67*2.54, female_avg, female_sd) - pnorm(61*2.54, female_avg, female_sd)
# [1] 0.6826895 (correcto)

# Notice that the answer to the question does not change when you change units. This makes sense because
# the answer to the question should not be affected by which units we use. In fact, if you look closely,
# you notice that 61 and 67 are both 1 SD away from the average.



## EXERCISE 5.
## PROBABILITY OF 1 SD FROM AVERAGE

# Compute the probability that the height of a randomly chosen female is within 1 SD from the average
# height.

# Instructions

# a) Calculate the values for heights one standard deviation taller and shorter than the average.

# b) Calculate the probability that a randomly chosen woman will be within 1 SD from the average height.

# CODE

# Assign a variable 'female_avg' as the average female height.
# mu(??)
female_avg <- 64

# Assign a variable 'female_sd' as the standard deviation for female heights.
# std(??)
female_sd <- 3

# To a variable named 'taller', assign the value of a height that is one SD taller than average.
# taller = mu + std = ?? + ??
taller <- female_avg + female_sd

# To a variable named 'shorter', assign the value of a height that is one SD shorter than average.
# shorter = mu - std =  ?? - ??
shorter <- female_avg - female_sd

# Calculate the probability that a randomly selected female is between the desired height range. Print
# this value to the console.
# F(b) - F(a)

pnorm(taller, female_avg, female_sd) - pnorm(shorter, female_avg, female_sd)
# [1] 0.6826895 (correcto)

# Esto quiere decir que el intervalo de alturas cae dentro del ~68% (1 SD) de los datos observados
# (en distribuciones normales).



## EXERCISE 6. 
## DISTRIBUTION OF MALE HEIGHTS

# Imagine the distribution of male adults is approximately normal with an average of 69 inches and a
# standard deviation of 3 inches. How tall is a male in the 99th percentile?
  
# Instructions

# a) Determine the height of a man in the 99th percentile, given an average height of 69 inches and a 
# standard deviation of 3 inches.

# CODE

# Assign a variable 'male_avg' as the average male height.
male_avg <- 69

# Assign a variable 'male_sd' as the standard deviation for male heights.
male_sd <- 3

# Determine the height of a man in the 99th percentile of the distribution.
qnorm(0.99, male_avg, male_sd)
# [1] 75.97904 (correcto)



## EXERCISE 7. 
## DISTRIBUTION OF IQ SCORES

# The distribution of IQ scores is approximately normally distributed. The average is 100 and the 
# standard deviation is 15. Suppose you want to know the distribution of the person with the highest
# IQ in your school district, where 10,000 people are born each year.

# Generate 10,000 IQ scores 1,000 times using a Monte Carlo simulation. Make a histogram of the 
# highest IQ scores.

# Instructions

# a) Use the function rnorm to generate a random distribution of 10,000 values with a given average
#    and standard deviation.
# b) Use the function max to return the largest value from a supplied vector.
# c) Repeat the previous steps a total of 1,000 times. Store the vector of the top 1,000 IQ scores 
#    as highestIQ.
# d) Plot the histogram of values using the function hist.

# CODE

# The variable `B` specifies the number of times we want the simulation to run.
B <- 1000

# Use the `set.seed` function to make sure your answer matches the expected result after random number
# generation.
set.seed(1)

# Create an object called `highestIQ` that contains the highest IQ score from each random distribution
# of 10,000 people.
avg <- 100
s <- 15
highestIQ <- replicate(B,{
  simulated_data <- rnorm(10000, avg, s)
  max(simulated_data)
})
mean(highestIQ)
# [1] 158.0463

# Make a histogram of the highest IQ scores.
hist(highestIQ, col = "blue")


