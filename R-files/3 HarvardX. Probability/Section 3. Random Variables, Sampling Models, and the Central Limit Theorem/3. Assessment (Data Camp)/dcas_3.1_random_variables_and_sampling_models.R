## DataCamp Assessment: Random Variables and Sampling Models

# 2021.06.17


set.seed(1, sample.kind = "Rounding")    # will make R 3.6 generate a seed as in R 3.5


## EXERCISE 1. 
## AMERICAN ROULETTE PROBABILITIES.

# An American roulette wheel has 18 red, 18 black, and 2 green pockets. Each red and black pocket is
# associated with a number from 1 to 36. The two remaining green slots feature "0" and "00". Players
# place bets on which pocket they think a ball will land in after the wheel is spun. Players can bet
# on a specific number (0, 00, 1-36) or color (red, black, or green).

# What are the chances that the ball lands in a green pocket?
  
# Instructions
# a) Define a variable 'p_green' as the probability of the ball landing in a green pocket.
# b) Print the value of 'p_green'.

# CODE

# The variables `green`, `black`, and `red` contain the number of pockets for each color
green <- 2
black <- 18
red <- 18

# Assign a variable `p_green` as the probability of the ball landing in a green pocket
p_green <- green/(green + black + red)

# Print the variable `p_green` to the console
p_green
# [1] 0.05263158 (correcto)



## EXERCISE 2. 
## AMERICAN ROULETTE PAYOUT

# In American roulette, the payout for winning on green is $17. This means that if you bet $1 and it
# lands on green, you get $17 as a prize.

# NOTE: Si yo gano, recibo $17dll (positivo 17,  +17 ); 
# si yo pierdo, el casino se queda con mi $1 dll (negativo 1, -1 ) 


# Create a model to predict your winnings from betting on green one time.
# NOTA: Quiere decir que 'winnings' son los resultados ("outcomes") al hacer las extracciones (+17 o -1)

# Instructions

# a) Use the 'sample' function return a random value from a specified range of values.
# b) Use the 'prob =' argument in the 'sample' function to specify a vector of probabilities for 
#    returning each of the values contained in the vector of values being sampled.
# c) Take a single sample (n = 1).

# CODE

# Use the `set.seed` function to make sure your answer matches the expected result after random sampling.
set.seed(1, sample.kind = "Rounding")    # will make R 3.6 generate a seed as in R 3.5

# The variables 'green', 'black', and 'red' contain the number of pockets for each color
green <- 2
black <- 18
red <- 18

# Assign a variable `p_green` as the probability of the ball landing in a green pocket
p_green <- green / (green+black+red)

# Assign a variable `p_not_green` as the probability of the ball not landing in a green pocket
p_not_green <- (black+red) / (green+black+red)       # p_not_green <- 1 - p_green

# Create a model to predict the random variable `X`, your winnings from betting on green. Sample one time.
X <- sample(c(-1,17), 1, replace = TRUE, prob = c(p_not_green, p_green))

# Print the value of `X` to the console
X
#[1] -1 (correcto)



## EXERCISE 3. 
## AMERICAN ROULETTE EXPECTED VALUE

# In American roulette, the payout for winning on green is $17. This means that if you bet $1 and it
# lands on green, you get $17 as a prize. In the previous exercise, you created a model to predict your
# winnings from betting on green.

# Now, compute the expected value of 'X' (uppercase), the random variable you generated previously.

# Instructions

# a) Using the chances of winning $17 ('p_green') and the chances of losing $1 ('p_not_green'), calculate
# the expected outcome of a bet that the ball will land in a green pocket.

# CODE

# The variables 'green', 'black', and 'red' contain the number of pockets for each color
green <- 2
black <- 18
red <- 18

# Assign a variable `p_green` as the probability of the ball landing in a green pocket
p_green <- green / (green+black+red)

# Assign a variable `p_not_green` as the probability of the ball not landing in a green pocket
p_not_green <- 1-p_green

# Calculate the expected outcome if you win $17 if the ball lands on green and you lose $1 if the ball
# doesn't land on green
(17)*p_green + (-1)*(p_not_green)
# [1] -0.05263158 (correcto)



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



## EXERCISE 5. 
## AMERICAN ROULETTE SUM OF WINNINGS

# You modeled the outcome of a single spin of the roulette wheel, 'X, in exercise 2.

# Now create a random variable 'S' that sums your winnings (this means, the total sum of win and lose)
# after betting on green 1,000 times.

# Instructions

# a) Use 'set.seed' to make sure the result of your random operation matches the expected answer for
#    this problem.
# b) Specify the number of times you want to sample from the possible outcomes.
# c) Use the 'sample' function to return a random value from a vector of possible values.
# d) Be sure to assign a probability to each outcome and to indicate that you are sampling with 
#    replacement.
# e) Do not use 'replicate' as this changes the output of random sampling and your answer will not 
#    match the grader.

# CODE

# The variables 'green', 'black', and 'red' contain the number of pockets for each color
green <- 2
black <- 18
red <- 18

# Assign a variable `p_green` as the probability of the ball landing in a green pocket
p_green <- green / (green+black+red)

# Assign a variable `p_not_green` as the probability of the ball not landing in a green pocket
p_not_green <- 1-p_green

# Use the `set.seed` function to make sure your answer matches the expected result after random sampling
set.seed(1)

# Define the number of bets using the variable 'n'
n <- 1000

# Create a vector called 'X' that contains the outcomes of 1000 samples
X <- sample(c(-1, 17), n, replace = TRUE, prob = c(p_not_green, p_green))

# Assign the sum of all 1000 outcomes to the variable 'S'
S <- sum(X)   # ?Sample Sum?

# Print the value of 'S' to the console
S
# [1] -10 (correcto)

# Dato extra:
# sum(X==17)
# [1] 55



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

