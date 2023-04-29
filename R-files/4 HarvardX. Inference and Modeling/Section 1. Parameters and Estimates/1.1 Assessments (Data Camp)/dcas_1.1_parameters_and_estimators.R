# Parameters andd Estimates
# 2022.05.22


## Exercise 1. 
## POLLING - EXPECTED VALUE OF S

# Suppose you poll a population in which a proportion 'p' of voters are Democrats and '1-p' are Republicans.
# Your sample size is 'N=25'. Consider the random variable 'S', which is the total number of Democrats in your 
# sample.

# What is the expected value of this random variable 'S'?

# Instructions

# Possible Answers
# a) E[S] = 25(1-p)
# b) E[S] = 25p             (correcto)
# c) E[S] = sqrt(25p(1-p)) 
# d) E[S] = p  
  

  
## Exercise 2. 
## POLLING - STANDARD ERROR OF S

# Again, consider the random variable 'S', which is the 'total' number of Democrats in your sample of 25
# voters. The variable 'p' describes the proportion of Democrats in the sample, whereas '1-p' describes the
# proportion of Republicans.

# What is the standard error of 'S'?
  
# Instructions

# Possible Answers
# a) SE[S] = 25*p(1-p)
# b) SE[S] = sqrt(25p)
# c) SE[S] = 25(1-p) 
# d) SE[S] = sqrt(25*p(1-p)) (correcto) 
  
  
  
## Exercise 3. 
## POLLING - EXPECTED VALUE OF X-bar

# Consider the random variable 'S/N', which is equivalent to the sample average that we have been denoting
# as 'X-bar (mean)'. The variable 'N' represents the sample size and 'p' is the proportion of Democrats in
# the population.

# What is the expected value of 'X-bar'?

# Instructions

# Possible Answers
# a) E[X-bar] = p      (correcto)
# b) E[X-bar] = N*p
# c) E[X-bar] = N*(1-p)
# d) E[X-bar] = 1-p



## Exercise 4. 
## POLLING - STANDARD ERROR OF X-BAR

# What is the standard error of the sample average, 'X-bar'?
  
# The variable 'N' represents the sample size and 'p' is the proportion of Democrats in the population.

# Instructions

#Possible Answers
# a) SE[X-bar] = sqrt(N*p(1-p))
# b) SE[X-bar] = sqrt(p*(1-p)/N) (correcto)
# c) SE[X-bar] = sqrt(p*(1-p))
# d) SE[X-bar] = sqrt(N)



## Exercise 5. 
## 'SE' VERSUS 'p'

# Write a line of code that calculates the standard error 'se' of a sample average when you poll 25 
# people in the population. Generate a sequence of 100 proportions of Democrats 'p' that vary from 0
# (no Democrats) to 1 (all Democrats).

# Plot 'se' versus 'p' for the 100 different proportions.

# Instructions

# Use the 'seq' function to generate a vector of 100 values of 'p' that range from 0 to 1.
# Use the 'sqrt' function to generate a vector of standard errors for all values of 'p'.
# Use the 'plot' function to generate a plot with 'p' on the x-axis and 'se' on the y-axis.

# Code:

# `N` represents the number of people polled
N <- 25

# Create a variable `p` that contains 100 proportions ranging from 0 to 1 using the `seq` function
p <- seq(0,1,length.out = 100)

# Create a variable `se` that contains the standard error of each sample average
se <- sqrt(p*(1-p)/N)

# Plot `p` on the x-axis and `se` on the y-axis
plot(p,se)



## Exercise 6. 
## MULTIPLE PLOTS OF 'SE' VERSUS 'p'

# Using the same code as in the previous exercise, create a 'for'-loop that generates three plots of 'p'
# versus 'se' when the sample sizes equal 'N = 25', 'N = 100', and 'N = 1000'.

# Instructions

# a) Your 'for'-loop should contain two lines of code to be repeated for three different values of 'N'.
# b) The first line within the 'for'-loop should use the 'sqrt' function to generate a vector of standard
#    errors 'se' for all values of 'p'.
# c) The second line within the 'for'-loop should use the 'plot' function to generate a plot with 'p' 
#    on the 'x'-axis and 'se' on the 'y'-axis.
# d) Use the 'ylim' argument to keep the 'y'-axis limits constant across all three plots. The lower limit
#    should be equal to '0' and the upper limit should equal '0.1' (it can be shown that this value is the
#    highest calculated standard error across all values of 'p' and 'N').

# Code:

# The vector `p` contains 100 proportions of Democrats ranging from 0 to 1 using the `seq` function
p <- seq(0, 1, length = 100)

# The vector `sample_sizes` contains the three sample sizes
sample_sizes <- c(25, 100, 1000)

# Write a for-loop that calculates the standard error `se` for every value of `p` for each of the three
# samples sizes `N` in the vector `sample_sizes`. Plot the three graphs, using the `ylim` argument 
# to standardize the y-axis across all three plots.
for(n in sample_sizes){
  se <- sqrt(p*(1-p)/sample_sizes)
  plot(p,se,ylim = c(0,0.1))
}



## Exercise 7. 
## EXPECTED VALUE OF 'd'

# Our estimate for the difference in proportions of Democrats and Republicans is 'd = X_bar - (1 - X_bar)'.

# Which derivation correctly uses the rules we learned about sums of random variables and scaled random
# variables to derive the expected value of 'd'?

# Instructions

# Possible Answers

# a) E[X_bar - (1 - X_bar)] = E[2*X_bar - 1] = 2*E[X_bar] - 1 = N*(2*p - 1) = N*p - N*(1-p)
# b) E[X_bar - (1 - X_bar)] = E[X_bar - 1] = E[X_bar] - 1 = p - 1
# c) E[X_bar - (1 - X_bar)] = E[2*X_bar - 1] = 2*E[X_bar] - 1 = 2*sqrt(p*(1-p)) - 1 = p - (1 - p)
# d) E[X_bar - (1 - X_bar)] = E[2*X_bar - 1] = 2*E[X_bar] - 1 = 2*p - 1 = p - (1 - p)   (correcto)



## Exercise 8. 
## STANDARD ERROR OF 'd'

# Our estimate for the difference in proportions of Democrats and Republicans is 'd = X_bar - (1 - X_bar)'
# Which derivation correctly uses the rules we learned about sums of random variables and scaled random
# variables to derive the standard error of 'd'?

# Instructions

# Possible Answers

# a) SE[X_bar - (1 - X_bar)] = SE[2*X_bar - 1] = 2*SE[X_bar] = 2*sqrt(p/N)
# b) SE[X_bar - (1 - X_bar)] = SE[2*X_bar - 1] = 2*SE[X_bar - 1] = 2*sqrt(p*(1-p)/N) - 1
# c) SE[X_bar - (1 - X_bar)] = SE[2*X_bar - 1] = 2*SE[X_bar] =  2*sqrt(p*(1-p)/N) (correcto)
# d) SE[X_bar - (1 - X_bar)] = SE[X_bar - 1] = SE[X_bar] = sqrt(p*(1-p)/N)



## Exercise 9. 
## STANDARD ERROR OF THE SPREAD

# Say the actual proportion of Democratic voters is 'p = 0.45'. In this case, the Republican party
# is winning by a relatively large margin of 'd = -0.1', or a 10% margin of victory. What is the 
# standard error of the spread '2*X-bar - 1' in this case?
  
# Instructions

# Use the 'sqrt' function to calculate the standard error of the spread '2*X_bar - 1'.

# Code

# `N` represents the number of people polled
N <- 25

# `p` represents the proportion of Democratic voters
p <- 0.45

# Calculate the standard error of the spread. Print this value to the console.
se_sprd <- 2*sqrt(p*(1-p)/N)
se_sprd   # [1] 0.1989975   (correcto)



## Exercise 10. 
## SAMPLE SIZE

# So far we have said that the difference between the proportion of Democratic voters and Republican
# voters is about '10%' and that the standard error of this spread is about '0.2' when 'N = 25'. Select the 
# statement that explains why this sample size is sufficient or not.

# Instructions

# Possible Answers

# a) This sample size is sufficient because the expected value of our estimate '2*X_bar - 1' is 'd' so
#    our prediction will be right on.

# b) This sample size is too small because the standard error is larger than the spread.    (correcto)

# c) This sample size is sufficient because the standard error of about '0.2' is much smaller than 
#    the spread of '10%'.

# d) Without knowing 'p', we have no way of knowing that increasing our sample size would actually 
#    improve our standard error.









