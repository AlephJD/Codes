# Introduction to Inference. Central Limit Theorem (CLT) for Inference.
# 2022.07.27


# set.seed(1, sample.kind = "Rounding") 


## Exercise 1. 
## SAMPLE AVERAGE

# Write function called 'take_sample' that takes the proportion of Democrats 'p' and the sample size 'N' as
# arguments and returns the sample average of Democrats (1) and Republicans (0).

# Calculate the sample average if the proportion of Democrats equals 0.45 and the sample size is 100.

# Instructions

# 1) Define a function called 'take_sample' that takes 'p' and 'N' as arguments.
# 2) Use the 'sample' function as the first statement in your function to sample 'N' elements from a vector
#    of options where Democrats are assigned the value '1' and Republicans are assigned the value '0' 
#    in that order.
# 3) Use the 'mean' function as the second statement in your function to find the average value of the 
#    random sample.


# Code:

# Write a function called `take_sample` that takes `p` and `N` as arguements and returns the average value of a randomly sampled population.
take_sample <- function(p,N) {X < -sample(c(1,0), size = N, replace = TRUE, prob = c(p, 1-p));
                              mean(X)}

# Use the `set.seed` function to make sure your answer matches the expected result after random sampling
set.seed(1)  # corregir 'set.seed()' en el script, no da los resultados que se obtienen en 'Data Camp'

# Define `p` as the proportion of Democrats in the population being polled
p <- 0.45

# Define `N` as the number of people polled
N <- 100

# Call the `take_sample` function to determine the sample average of `N` randomly selected people 
# from a population containing a proportion of Democrats equal to `p`. Print this value to the console.

take_sample(p,N)
# [1] 0.449   ## [1] 0.46 (resultado en Data Camp)



## Exercise 2. 
## DISTRIBUTION OF ERRORS -1 

# Assume the proportion of Democrats in the population 'P' equals 0.45 and that your sample size 'N'
# is 100 polled voters. The 'take_sample' function you defined previously generates our estimate, 'X_bar'.

# Replicate the random sampling 10,000 times and calculate 'p - X_bar' for each random sample. Save 
# these differences as a vector called 'errors'. Find the average of 'errors' and plot a histogram 
# of the distribution.

# Instructions

# 1) The function 'take_sample' that you defined in the previous exercise has already been run for you.
# 2) Use the 'replicate' function to replicate subtracting the result of 'take_sample' from the value 
#    of 'p' 10,000 times.
# 3) Use the 'mean' function to calculate the average of the differences between the sample average 
#    and actual value of 'p'.

# Code

# Define `p` as the proportion of Democrats in the population being polled
p <- 0.45

# Define `N` as the number of people polled
N <- 100

# The variable `B` specifies the number of times we want the sample to be replicated
B <- 10000

# Use the `set.seed` function to make sure your answer matches the expected result after random sampling
set.seed(1)    # corregir 'set.seed()' en el script, no da los resultados que se obtienen en 'Data Camp'

# Create an objected called `errors` that replicates subtracting the result of the `take_sample` function 
# from `p` for `B` replications
errors <- replicate(B, {
                    X_bar <- take_sample(p,N)
                    p - X_bar
})

# Calculate the mean of the errors. Print this value to the console.
mean(errors)  # [1] -4.9 e-05 (resultado en Data Camp)

hist(errors)



## Exercise 3. 
## DISTRIBUTION OF ERRORS - 2

# In the last exercise, you made a vector of differences between the actual value for 'p' and an 
# estimate, 'X_bar'. We called these differences between the actual and estimated values 'errors'.

# The 'errors' object has already been loaded for you. Use the 'hist' function to plot a histogram
# of the values contained in the vector 'errors'. Which statement best describes the distribution 
# of the errors?

hist(errors)

# Instructions

# Possible Answers

# a) The errors are all about 0.05.

# b) The error are all about -0.05.

# c) The errors are symmetrically distributed around 0.  (correcto)

# d) The errors range from -1 to 1.



## Exercise 4. 
## AVERAGE SIZE OF ERROR 

# The error 'p - X_bar' is a random variable. In practice, the error is not observed because we do 
# not know the actual proportion of Democratic voters, . However, we can describe the size of the 
# error by constructing a simulation.

# What is the average size of the error if we define the size by taking the absolute value '|p - X_bar|'?

# Instructions

# 1) Use the sample code to generate 'errors', a vector of '|p - X_bar|'.
# 2) Calculate the absolute value of 'errors' using the 'abs' function.
# 3) Calculate the average of these values using the 'mean' function.

# Code:

# Define `p` as the proportion of Democrats in the population being polled
p <- 0.45

# Define `N` as the number of people polled
N <- 100

# The variable `B` specifies the number of times we want the sample to be replicated
B <- 10000

# Use the `set.seed` function to make sure your answer matches the expected result after random sampling
set.seed(1)

# We generated `errors` by subtracting the estimate from the actual proportion of Democratic voters
errors <- replicate(B, p - take_sample(p, N))

# Calculate the mean of the absolute value of each simulated error. Print this value to the console.
mean(abs(errors))   # [1] 0.039267 (resultado en Data Camp)

# hist(abs(errors))


## Exercise 5. 
## STANDARD DEVIATION OF THE SPREAD

# The standard error is related to the typical "size" of the error we make when predicting. We say "size" 
# because, as we just saw, the errors are centered around 0. In that sense, the typical error is 0. For
# mathematical reasons related to the central limit theorem, we actually use the standard deviation of 
# 'errors' rather than the average of the absolute values.

# As we have discussed, the standard error is the square root of the average squared distance '(X_bar - p)^2'.
# The standard deviation is defined as the square root of the distance squared.

# Calculate the standard deviation of the spread.

# Instructions

# 1) Use the sample code to generate 'errors', a vector of '|p - X_bar|'.
# 2) Use '^2' to square the distances.
# 3) Calculate the average squared distance using the 'mean' function.
# 4) Calculate the square root of these values using the 'sqrt' function.

# Code:

# Define `p` as the proportion of Democrats in the population being polled
p <- 0.45

# Define `N` as the number of people polled
N <- 100

# The variable `B` specifies the number of times we want the sample to be replicated
B <- 10000

# Use the `set.seed` function to make sure your answer matches the expected result after random sampling
set.seed(1)

# We generated `errors` by subtracting the estimate from the actual proportion of Democratic voters
errors <- replicate(B, (p - take_sample(p, N))^2 )

# Calculate the standard deviation of `errors`
sqrt(mean(errors))  # [1] 0.04949939 (resultado de Data Camp)

#hist(errors)



## Exercise 6. 
## ESTIMATING THE STANDARD ERROR

# The theory we just learned tells us what this standard deviation is going to be because it is the
# standard error of 'X_bar'.

# Estimate the standard error given an expected value of 0.45 and a sample size of 100.

# Instructions

# Calculate the standard error using the 'sqrt' function

# Code:

# Define `p` as the expected value equal to 0.45
p <- 0.45

# Define `N` as the sample size
N <- 100

# Calculate the standard error
sqrt(0.45*(1-0.45)/N)    # [1] 0.04974937  (resultado en Data Camp)



## Exercise 7. 
## STANDARS ERROR OF THE ESTIMATE

# In practice, we don't know 'p', so we construct an estimate of the theoretical prediction based
# by plugging in 'X_bar' for 'p'. Calculate the standard error of the estimate: 'SE_hat[X_bar]'

# Instructions

# 1) Simulate a poll 'X' using the 'sample' function.
# 2) When using the 'sample' function, create a vector using 'c()' that contains all possible polling 
#    options where '1' indicates a Democratic voter and '0' indicates a Republican voter.
# 3) When using the 'sample' function, use 'replace = TRUE' within the 'sample' function to indicate 
#    that sampling from the vector should occur with replacement.
# 4) When using the 'sample' function, use 'prob =' within the 'sample' function to indicate the probabilities
#    of selecting either element (0 or 1) within the vector of possibilities.
# 5) Use the 'mean' function to calculate the average of the simulated poll, 'X_bar'.
# 6) Calculate the standard error of the 'X_bar' using the 'sqrt' function and print the result.

# Code:

# Define `p` as a proportion of Democratic voters to simulate
p <- 0.45

# Define `N` as the sample size
N <- 100

# Use the `set.seed` function to make sure your answer matches the expected result after random sampling
set.seed(1)

# Define `X` as a random sample of `N` voters with a probability of picking a Democrat ('1') equal to `p`
X <- sample(c(1,0), size = N, replace = TRUE, prob = c(p, 1-p))

# Define `X_bar` as the average sampled proportion
X_bar <- mean(X)

# Calculate the standard error of the estimate. Print the result to the console.
se_hat <- sqrt(X_bar*(1-X_bar/N))
se_hat   

# [1] 0.04983974   (resultado en Data Camp)



## Exercise 8. 
## PLOTTING THE STANDARD ERROR 

# The standard error estimates obtained from the Monte Carlo simulation, the theoretical prediction, 
# and the estimate of the theoretical prediction are all very close, which tells us that the theory 
# is working. This gives us a practical approach to knowing the typical error we will make if we predict 'p'
# with 'X_bar'. The theoretical result gives us an idea of how large a sample size is required to obtain the 
# precision we need. Earlier we learned that the largest standard errors occur for 'p = 0.05'.

# Create a plot of the largest standard error for 'N' ranging from 100 to 5,000. Based on this plot, how 
# large does the sample size have to be to have a standard error of about 1%?
  
N <- seq(100, 5000, len = 100)
p <- 0.5
se <- sqrt(p*(1-p)/N)

# Instructions

# Possible Answers

# a) 100

# b) 500

# c) 2,500 (correcto)

# d) 4,000

plot(N, se)



## Exercise 9. 
## DISTRIBUTION OF 'X_hat'.

# For 'N=100', the central limit theorem tells us that the distribution of 'X_hat' is...

# Instructions

# Possible Answers

# a) practically equal to 'p'.

# b) approximately normal with expected value 'p' and standard error 'sqrt(p*(1-p)/N)'.     (correcto)

# c) approximately normal with expected value 'X_hat'
#    and standard error 'sqrt(X_hat*(1-X_hat)/N)'.

# d) not a random variable.



## Exercise 10. 
# DISTRIBUTION OF THE ERRORS 

### REVISAR LA DIFERENCIA ENTRE 'X_HAT' Y 'X_BAR', 
### O PORQUE PARECEN USARLO COMO COSAS IGUALES ###

# We calculated a vector 'errors' that contained, for each simulated sample, the difference between the
# actual value 'p' and our estimate 'X_hat'.

# The errors 'X_bar - p' are:

# Instructions

# Possible Answers

# a) practically equal to 0.

# b) approximately normal with expected value 0 and standard error 'sqrt(p*(1-p)/N)'.

# c) approximately normal with expected value 'p' and standard error 'sqrt(p*(1-p)/N)'.

# d) not a random variable.



## Exercise 11. 
## PLOTTING THE ERRORS 

# Make a qq-plot of the 'errors' you generated previously to see if they follow a normal distribution.

# Instructions

# 1) Run the supplied code
# 2) Use the 'qqnorm' function to produce a qq-plot of the errors.
# 3) Use the 'qqline' function to plot a line showing a normal distribution.

# cODE:

# Define `p` as the proportion of Democrats in the population being polled
p <- 0.45

# Define `N` as the number of people polled
N <- 100

# The variable `B` specifies the number of times we want the sample to be replicated
B <- 10000

# Use the `set.seed` function to make sure your answer matches the expected result after random sampling
set.seed(1)

# Generate `errors` by subtracting the estimate from the actual proportion of Democratic voters
errors <- replicate(B, p - take_sample(p, N))

# Generate a qq-plot of `errors` with a qq-line showing a normal distribution
qqnorm(errors); qqline(errors, col = 2)



## Exercise 12. 
## ESTIMATING THE PROBABILITY OF A SPECIFIC VALUE OF 'X_bar'

# If 'p = 0.45' and 'N = 100', use the central limit theorem to estimate the probability that 'X_bar > 0.5'.

# Instructions

# Use 'pnorm' to define the probability that a value will be greater than 0.5.

# Code:

# Define `p` as the proportion of Democrats in the population being polled
p <- 0.45

# Define `N` as the number of people polled
N <- 100

# Calculate the probability that the estimated proportion of Democrats in the population is greater 
# than 0.5. Print this value to the console.
se <- sqrt(p*(1-p)/N)
1 - pnorm(0.5, p, se)   # [1] 0.1574393  (calculado en Data Camp)

# pnorm(0.5, p, se) = 0.8425607



## Exercise 13. 
## ESTIMATING THE PROBABILITY OF A SPECIFIC ERROR SIZE

# Assume you are in a practical situation and you don't know 'P'. Take a sample of size 'N = 100' 
# and obtain a sample average of 'X_bar = 0.51'.

# What is the CLT approximation for the probability that your error size is equal or larger than 0.01?

# Instructions

# 1) Calculate the standard error of the sample average using the 'sqrt' function.
# 2) Use 'pnorm' twice to define the probabilities that a value will be less than -0.01 or greater than 0.01.
# 3) Combine these results to calculate the probability that the error size will be 0.01 or larger.

# Code:

# Define `N` as the number of people polled
N <-100

# Define `X_hat` as the sample average
X_hat <- 0.51

# Define `se_hat` as the standard error of the sample average
se_hat <- sqrt(X_hat*(1-X_hat)/N)

# Calculate the probability that the error is 0.01 or larger
(1 - pnorm(0.01, 0, se_hat)) + pnorm(-0.01, 0,se_hat)

# [1] 0.08414493 (como se ibtuvo en Data Camp)







