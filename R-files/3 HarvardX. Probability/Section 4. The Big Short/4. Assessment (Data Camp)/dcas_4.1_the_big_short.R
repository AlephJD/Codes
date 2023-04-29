## DataCamp Assessment: The Big Short

# 2021.07.15


set.seed(1, sample.kind = "Rounding")    # will make R 3.6 generate a seed as in R 3.5


## EXERCISE 1.
## BANK EARNINGS

# Say you manage a bank that gives out 10,000 loans. The default rate is 0.03 (3%) and you lose $200,000
# in each foreclosure (juicio hipotecario).

# Create a random variable 'S' that contains the earnings of your bank. Calculate the total amount of 
# money lost in this scenario.

# Instructions

# a) Using the 'sample' function, generate a vector called 'defaults' that contains 'n' samples from a 
#   vector of 'c(0,1)', where '0' indicates a payment and '1' indicates a default
# b) Multiply the total number of defaults by the loss per foreclosure.

# CODE

# Assign the number of loans to the variable `n`
n <- 10000

# Assign the loss per foreclosure to the variable `loss_per_foreclosure`
loss_per_foreclosure <- -200000

# Assign the probability of default to the variable `p_default`
p_default <- 0.03

# Use the `set.seed` function to make sure your answer matches the expected result after random sampling
set.seed(1)

# Generate a vector called `defaults` that contains the default outcomes of `n` loans
defaults <- sample(c(0,1), n, replace = TRUE, prob = c(1-p_default,p_default))

# Generate `S`, the total amount of money lost across all foreclosures. Print the value to the console.
S <- sum(defaults*loss_per_foreclosure)
S
# [1] -6.3e+07 = -63000000 (correcto)
  


## EXERCISE 2. 
## BANK EARNINGS MONTE CARLO

# Run a Monte Carlo simulation with 10,000 outcomes for 'S', the sum of losses over 10,000 loans. 
# Make a histogram of the results.

# Instructions

# a) Within a 'replicate' loop with 10,000 iterations, use 'sample' to generate a list of 10,000 loan 
#    outcomes: payment (0) or default (1). Use the outcome order 'c(0,1)' and probability of default 
#    'p_default'.
# b) Still within the loop, use the function 'sum' to count the number of foreclosures multiplied by 
#    'loss_per_foreclosure' to return the sum of all losses across the 10,000 loans. If you do not 
#    take the 'sum' inside the 'replicate' loop, DataCamp may crash with a "Session Expired" error.
# c) Plot the histogram of values using the function 'hist'.

# CODE

# Assign the number of loans to the variable `n`
n <- 10000

# Assign the loss per foreclosure to the variable `loss_per_foreclosure`
loss_per_foreclosure <- -200000

# Assign the probability of default to the variable `p_default`
p_default <- 0.03

# Use the `set.seed` function to make sure your answer matches the expected result after random sampling
set.seed(1)

# The variable `B` specifies the number of times we want the simulation to run
B <- 10000

# Generate a list of summed losses 'S'. Replicate the code from the previous exercise over 'B' iterations to generate a list of summed losses for 'n' loans.  Ignore any warnings for now.
S <- replicate(B, {
  defaults <- sample(c(0,1), n, replace = TRUE, prob = c(1-p_default, p_default))
  sum(defaults*loss_per_foreclosure)
})

# Plot a histogram of 'S'.  Ignore any warnings for now.
hist (S)    # (correcto)
# data.frame(S = S/10^6) %>% ggplot(aes(S)) + geom_histogram(binwidth = 0.6, col = "black")



## EXERCISE 3. 
## BANK EARNINGS EXPECTED VALUE

# What is the expected value of 'S', the sum of losses over 10,000 loans? For now, assume a bank makes
# no money if the loan is paid.

# Instructions

# Using the chances of default ('p_default'), calculate the expected losses over 10,000 loans.

# CODE

# Assign the number of loans to the variable `n`
n <- 10000

# Assign the loss per foreclosure to the variable `loss_per_foreclosure`
loss_per_foreclosure <- -200000

# Assign the probability of default to the variable `p_default`
p_default <- 0.03

# Calculate the expected loss due to default out of 10,000 loans
n * (loss_per_foreclosure*p_default + 0*(1-p_default))
# [1] -6e+07 = -60000000  (correcto)



## EXERCISE 4. 
## BANK EARNINGS STANDARD ERROR

# What is the standard error of 'S'?
  
# Instructions

# Compute the standard error of the random variable 'S' you generated in the previous exercise, the 
# summed outcomes of 10,000 loans.

# CODE

# Assign the number of loans to the variable `n`
n <- 10000

# Assign the loss per foreclosure to the variable `loss_per_foreclosure`
loss_per_foreclosure <- -200000

# Assign the probability of default to the variable `p_default`
p_default <- 0.03

# Compute the standard error of the sum of 10,000 loans
sqrt(n) * abs(0-loss_per_foreclosure) * sqrt(p_default * (1-p_default))
# [1] 3411744 (correcto)



## EXERCISE 5. 
## BANK EARNINGS INTEREST RATE - 1

# So far, we've been assuming that we make no money when people pay their loans and we lose a lot of
# money when people default on their loans. Assume we give out loans for $180,000. How much money do
# we need to make when people pay their loans so that our net loss is $0?

# In other words, what interest rate do we need to charge in order to not lose money?

# Instructions

# a) If the amount of money lost or gained equals 0, the probability of default times the total loss
#    per default equals the amount earned per probability of the loan being paid.
# b) Divide the total amount needed per loan by the loan amount to determine the interest rate.

# CODE

# Assign the loss per foreclosure to the variable `loss_per_foreclosure`
loss_per_foreclosure <- -200000

# Assign the probability of default to the variable `p_default`
p_default <- 0.03

# Assign a variable `x` as the total amount necessary to have an expected outcome of $0
x <- -(loss_per_foreclosure*p_default)/(1-p_default)
# x = 6185.567

# Convert `x` to a rate, given that the loan amount is $180,000. Print this value to the console.
r <- x/180000
r
# [1] 0.03436426 (~3.43%)



## EXERCISE 6. 
## BANK EARNINGS INTEREST RATE - 2

# With the interest rate calculated in the last example, we still lose money 50% of the time. What
# should the interest rate be so that the chance of losing money is 1 in 20?
  
# In math notation, what should the interest rate be so that Pr(S < 0) = 0.05?
  
# Remember that we can add a constant to both sides of the equation to get:
  
#  Pr ( (S - E[S]) / SE[E] < -E[S] / SE[S] )
  
# which is

#  Pr( Z < -[l*p + x*(1-p)]*n /  ( (x - l) * sqrt(n*p*(1-p)) ) = 0.05

# Let 'z = qnorm(0.05)' give us the value of z for which:
  
#  Pr( Z <= z) = 0.05

# Instructions

# a) Use the 'qnorm' function to compute a continuous variable at given quantile of the distribution 
#   to solve for 'z'.
# b) In this equation, 'l', 'p', and 'n' are known values. Once you've solved for 'z', solve for 'x'.
# c) Divide 'x' by the loan amount to calculate the rate.

# CODE
  
# Assign the number of loans to the variable `n`
n <- 10000
  
# Assign the loss per foreclosure to the variable `loss_per_foreclosure`
loss_per_foreclosure <- -200000
  
# Assign the probability of default to the variable `p_default`
p_default <- 0.03
  
# Generate a variable `z` using the `qnorm` function
z <- qnorm(0.05)  
  
# Generate a variable `x` using `z`, `p_default`, `loss_per_foreclosure`, and `n`
x <- -loss_per_foreclosure*(n*p_default - z*sqrt(n*p_default*(1-p_default)))/ ( n*(1-p_default) + z*sqrt(n*p_default*(1-p_default))) 
# x = 6783.728

# Convert `x` to an interest rate, given that the loan amount is $180,000. Print this value to the
# console.
r <- x/180000
r  
# [1] 0.03768738 (~ 3.77%)



## EXERCISE 7. 
## BANK EARNINGS - MINIMIZE MONEY LOSS

# The bank wants to minimize the probability of losing money. Which of the following achieves their
# goal without making interest rates go up?
  
# Instructions

# Possible Answers

# a) A smaller pool of loans

# b) A larger probability of default

## c) A reduced default rate     (correcto)

# d) A larger cost per loan default






