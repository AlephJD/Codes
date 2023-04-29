## Section 2: 
## 2.2 Assessment: Continuous Probability



# QUESTIONS 1 AND 2: 
## ACT SCORES, PART 1

# The ACT is a standardized college admissions test used in the United States. The four multi-part 
# questions in this assessment all involve simulating some ACT test scores and answering probability
# questions about them.

# For the three year period 2016-2018, ACT standardized test scores were approximately normally 
# distributed with a mean of 20.9 and standard deviation of 5.7. (Real ACT scores are integers between
# 1 and 36, but we will ignore this detail and use continuous values instead.)

# First we'll simulate an ACT test score dataset and answer some questions about it.

# Set the seed to 16, then use 'rnorm()' to generate a normal distribution of 10000 tests with a mean
# of 20.9 and standard deviation of 5.7. Save these values as 'act_scores'. You'll be using this 
# dataset throughout these four multi-part questions.


# IMPORTANT NOTE! If you use R 3.6 or later, you will need to use the command format:
# 'set.seed(x, sample.kind = "Rounding")' instead of 'set.seed(x)'. 
# Your R version will be printed at the top of the Console window when you start RStudio.

library(tidyverse)
set.seed(16, sample.kind = "Rounding")

avg <- 20.9
s <- 5.7
act_scores <- rnorm(10000, avg, s)

# Question 1a
# What is the mean of 'act_scores'?
mean(act_scores)
# [1] 20.84012 (correcto)

  
# Question 1b
# What is the standard deviation of 'act_scores'?
sd(act_scores)
# [1] 5.675237 (correcto)

# Question 1c
# A perfect score is 36 or greater (the maximum reported score is 36).
# In 'act_scores', how many perfect scores are there out of 10,000 simulated tests?
max(act_scores)                  # 41.99898

scores <- act_scores >= 36
mean(scores)                 # 0.0041
sum(scores)                  # 41 (correcto)
  
# question 1d
# In 'act_scores', what is the probability of an ACT score greater than 30?
scores <- act_scores >= 30
mean(scores)                 # 0.0527 (correcto)
  
  
# Question 1e
# In 'act_scores', what is the probability of an ACT score less than or equal to 10?
scores <- act_scores <= 10
mean(scores)                 # 0.0282 (correcto)
  
  
## Question 2
# Set 'x' equal to the sequence of integers 1 to 36. Use 'dnorm' to determine the value of the 
# probability density function over 'x' given a mean of 20.9 and standard deviation of 5.7; save the
# result as 'f_x'. Plot 'x' against 'f_x'.

x <- seq(1, 36)
f_x <- dnorm(x, avg, s)
plot(x, f_x, "b")

# Which of the following plots is correct?

# (b): a densitity function with 'x' values from: 0 to 36, and 'y' values from: 0.0 to 0.07.
  
###################################################################################################
###################################################################################################



## QUESTIONS 3 AND 4: 
## ACT SCORES, PART 2

# In this 3-part question, you will convert raw ACT scores to Z-scores and answer some questions about
# them.

# Convert 'act_scores' to Z-scores. Recall from Data Visualization (the second course in this series)
# that to standardize values (convert values into Z-scores, that is, values distributed with a mean
# of 0 and standard deviation of 1), you must subtract the mean and then divide by the standard deviation.
# Use the mean and standard deviation of 'act_scores', not the original values used to generate random
# test scores.

## Theory and Example (own):
# Suppose we ask the probability of X (e.g.: Alturas [inches] ) being smaller or equal to a. Remember 
# that, by definition, a is (a-m)/s  standard deviations s away from the average m. The probability is:
  
#   Pr(X ??? a)

# Now we subtract ?? to both sides and then divide both sides by ??:
  
#   Pr((X-m)/s ??? (a-m)/s)

# The quantity on the left is a standard normal random variable. It has an average of 0 and a standard
# error of 1. We will call it Z (¿z-scores?):
  
#   Pr(Z ??? (a-m)/s)


mu <- mean(act_scores)
sigma <- sd(act_scores)

z_scores <- (act_scores - mu)/sigma


# Question 3a
# What is the probability of a Z-score greater than 2 (2 standard deviations above the mean)?
mean(z_scores > 2)
# [1] 0.0233 (correcto) 
  

# Question 3b
# What ACT score value corresponds to 2 standard deviations above the mean (Z = 2)?
2*sigma + mu
# [1] 32.1906 (correcto)

  
# Question 3c
# A Z-score of 2 corresponds roughly to the 97.5th percentile.

# Use 'qnorm()' to determine the 97.5th percentile of normally distributed data with the mean and 
# standard deviation observed in 'act_scores'.

qnorm(0.975, avg, s)

# What is the 97.5th percentile of 'act_scores'?
  
# [1] 32.07179 (correcto)
  

## In this 4-part question, you will write a function to create a CDF for ACT scores.

# Write a function that takes a value and produces the probability of an ACT score less than or equal
# to that value (the CDF). Apply this function to the range 1 to 36.

seq_scores <- seq(1, 36)

fun_scores <- function(a){
  mean(act_scores <= a)
}

prob_scores <- sapply(seq_scores, fun_scores)
qplot(seq_scores, prob_scores)


# Question 4a
# What is the minimum integer score such that the probability of that score or lower is at least .95?
# Your answer should be an integer 1-36.

min(seq_scores[prob_scores >= 0.95])         # [1] 31 32 33 34 35 36
# [1] 31


# Question 4b
# Use 'qnorm()' to determine the expected 95th percentile, the value for which the probability of 
# receiving that score or lower is 0.95, given a mean score of 20.9 and standard deviation of 5.7.
# What is the expected 95th percentile of ACT scores?
  
qnorm(0.95, avg, s)
# [1] 30.27567

  
# Question 4c
# As discussed in the Data Visualization course, we can use 'quantile()' to determine sample quantiles
# from the data.

# Make a vector containing the quantiles for 'p <- seq(0.01, 0.99, 0.01)', the 1st through 99th 
# percentiles of the 'act_scores' data. Save these as 'sample_quantiles'.

p <- seq(0.01, 0.99, 0.01)
sample_quantiles <- quantile(act_scores, p)

# In what percentile is a score of 26?
# Your answer should be an integer (i.e. 60), not a percent or fraction. Note that a score between 
# the 98th and 99th percentile should be considered the 98th percentile, for example, and that quantile
# numbers are used as names for the vector 'sample_quantiles'.

tail(sample_quantiles[sample_quantiles <= 26], n = 1)
#      82% 
# 25.99266 


# Question 4d
# Make a corresponding set of theoretical quantiles using 'qnorm()' over the interval 'p <- seq(0.01, 0.99, 0.01)'
# with mean 20.9 and standard deviation 5.7. Save these as 'theoretical_quantiles'. Make a QQ-plot graphing 
# 'sample_quantiles' on the y-axis versus 'theoretical_quantiles' on the x-axis.

theoretical_quantiles <- qnorm(p, avg, s)

qqplot(theoretical_quantiles, sample_quantiles)

# Which of the following graphs is correct?

# d) (correcto)













