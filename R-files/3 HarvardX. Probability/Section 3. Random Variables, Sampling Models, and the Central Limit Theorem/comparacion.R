# A) From: Random Variables and Sampling

## EXERCISE 6. 
## AMERICAN ROULETTE WINNINGS EXPECTED VALUE

# In the previous exercise, you generated a vector of random outcomes, 'S', after betting on green 1,000
# times.

# What is the expected value of 'S'?

# Instructions

# a) Using the chances of winning $17 ('p_green') and the chances of losing $1 ('p_not_green'), calculate
#    the expected outcome of a bet that the ball will land in a green pocket over 1,000 bets.

# CODE

# The variables 'green', 'black', and 'red' contain the number of pockets for each color
green <- 2
black <- 18
red <- 18

# Assign a variable `p_green` as the probability of the ball landing in a green pocket
p_green <- green / (green+black+red)

# Assign a variable `p_not_green` as the probability of the ball not landing in a green pocket
p_not_green <- 1-p_green

# Define the number of bets using the variable 'n'
n <- 1000

# Calculate the expected outcome of 1,000 spins if you win $17 when the ball lands on green and you
# lose $1 when the ball doesn't land on green
n * ( (17)*p_green + (-1)*p_not_green )

# [1] -52.63158 (correcto)



# B) From: Central Limit Theorem

## EXERCISE 6. 
## AMERICAN ROULETTE PER BET EXPECTED VALUE

# What is the expected value of 'Y', the average outcome per bet after betting on green 10,000 times?

# Instructions

# a) Using the chances of winning $17 ('p_green') and the chances of losing $1 ('p_not_green'), calculate
#    the expected outcome of a bet that the ball will land in a green pocket.
# b) Use the expected value formula rather than a Monte Carlo simulation.
# c) Print this value to the console (do not assign it to a variable).

# CODE

# Assign a variable `p_green` as the probability of the ball landing in a green pocket
p_green <- 2 / 38

# Assign a variable `p_not_green` as the probability of the ball not landing in a green pocket
p_not_green <- 1 - p_green

# Calculate the expected outcome of `Y`, the mean outcome per bet in 10,000 bets
17 * p_green + -1 * p_not_green
# [1] -0.05263158 (correcto)



###################################################################################################
###################################################################################################

# A)

## EXERCISE 4. 
## AMERICAN ROULETTE STANDARD ERROR

# The standard error of a random variable 'X' tells us the difference between a random variable and its
# expected value. You calculated a random variable 'X' in exercise 2 and the expected value of that 
# random variable in exercise 3.

# Now, compute the standard error of that random variable, which represents a single outcome after one
# spin of the roulette wheel.

# Instructions

# a) Compute the standard error of the random variable you generated in exercise 2, or the outcome of any one spin of the roulette wheel.
# b) Recall that the payout for winning on green is $17 for a $1 bet.

# CODE

# The variables 'green', 'black', and 'red' contain the number of pockets for each color
green <- 2
black <- 18
red <- 18

# Assign a variable `p_green` as the probability of the ball landing in a green pocket
p_green <- green / (green+black+red)

# Assign a variable `p_not_green` as the probability of the ball not landing in a green pocket
p_not_green <- 1-p_green

# Compute the standard error of the random variable (or the outcome of any one spin of the
# roulette wheel)
abs((-1)-17)*sqrt(p_green*p_not_green)
# [1] 4.019344 (correcto)





# A)

## EXERCISE 7. 
## AMERICAN ROULETTE WINNINGS EXPECTED VALUE

# You generated the expected value of 'S', the outcomes of 1,000 bets that the ball lands in the green 
# pocket, in the previous exercise.

# What is the standard error of 'S'?

# Instructions

# a) Compute the standard error of the random variable you generated in exercise 5, or the outcomes
# of 1,000 spins of the roulette wheel.

# CODE

# The variables 'green', 'black', and 'red' contain the number of pockets for each color
green <- 2
black <- 18
red <- 18

# Assign a variable `p_green` as the probability of the ball landing in a green pocket
p_green <- green / (green+black+red)

# Assign a variable `p_not_green` as the probability of the ball not landing in a green pocket
p_not_green <- 1-p_green

# Define the number of bets using the variable 'n'
n <- 1000

# Compute the standard error of the sum of 1,000 outcomes (or the outcomes of 1000 spins of the
# roulette wheel)
sqrt(n) * abs((-1) - (17)) * sqrt(p_green * p_not_green)

# [1] 127.1028 (correcto)






# B)

## EXERCISE 7. 
## AMERICAN ROULETTE PER BET STANDARD ERROR

# What is the standard error of 'Y', the average result of 10,000 spins?

# Instructions

# Compute the standard error of 'Y', the average result of 10,000 independent spins.

# CODE

# Define the number of bets using the variable 'n'
n <- 10000

# Assign a variable `p_green` as the probability of the ball landing in a green pocket
p_green <- 2 / 38

# Assign a variable `p_not_green` as the probability of the ball not landing in a green pocket
p_not_green <- 1 - p_green

# Compute the standard error of 'Y', the mean outcome per bet from 10,000 bets.
(abs(-1 - (17)) * sqrt(p_green * p_not_green))/sqrt(n)
# [1] 0.04019344 (correcto)

