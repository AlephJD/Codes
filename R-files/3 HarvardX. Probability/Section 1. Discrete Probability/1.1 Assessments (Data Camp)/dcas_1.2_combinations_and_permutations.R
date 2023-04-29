# Independence and Multiplication Rules
# 2021.04.17


## Exercise 1. 
## INDEPENDENCE

# Imagine you draw two balls from a box containing colored balls. You either replace the first ball
# before you draw the second or you leave the first ball out of the box when you draw the second ball.

# Under which situation are the two draws independent of one another?
# Remember that two events A and B are independent if Pr(A and B) = Pr(A)P(B).

# Instructions:
# Possible Answers:
# a) You don't replace the first ball before drawing the next.
# b) You do replace the first ball before drawing the next. (correct)
# c) Neither situation describes independent events.
# d) Both situations describe independent events.



## Exercise 2. 
## SAMPLING WITH REPLACEMENT

# Say you've drawn 5 balls from the a box that has 3 cyan balls, 5 magenta balls, and 7 yellow balls,
# with replacement, and all have been yellow.

# What is the probability that the next one is yellow?

# Instructions:
# a) Assign the variable p_yellow as the probability of choosing a yellow ball on the first draw.
# b) Using the variable p_yellow, calculate the probability of choosing a yellow ball on the sixth draw.

# CODE

cyan <- 3
magenta <- 5
yellow <- 7

# Assign the variable 'p_yellow' as the probability that a yellow ball is drawn from the box.
N <- sum(cyan, magenta, yellow)
p_yellow <- yellow/N

# Using the variable 'p_yellow', calculate the probability of drawing a yellow ball on the sixth draw.
# Print this value to the console.
p_yellow



## Exercise 3. 
## ROLLING A DIE

# If you roll a 6-sided die once, what is the probability of not seeing a 6? If you roll a 6-sided die 
# six times, what is the probability of not seeing a 6 on any of those rolls?

# Instructions:

# a) Assign the variable p_no6 as the probability of not seeing a 6 on a single roll.
# b) Then, calculate the probability of not seeing a 6 on six rolls using p_no6.

# CODE

# Assign the variable 'p_no6' as the probability of not seeing a 6 on a single roll.
p_no6 <- 5/6

# Calculate the probability of not seeing a 6 on six rolls using `p_no6`. Print your result to the console: 
# do not assign it to a variable.
p_no6^6     # P(A???B???C???D???E???F)=P(A)*P(B)*P(C)*P(D)*P(E)*P(F)




## Exercise 4. 
## PROBABILITY THE CELTICS WIN A GAME
# Two teams, say the Celtics and the Cavs, are playing a seven game series. The Cavs are a better team and 
# have a 60% chance of winning each game.

# What is the probability that the Celtics win at least one game? Remember that the Celtics must win one of
# the first four games, or the series will be over!

# Instructions:

# a) Calculate the probability that the Cavs will win the first four games of the series.
# b) Calculate the probability that the Celtics win at least one game in the first four games of the series.

# CODE

# Assign the variable `p_cavs_win4` as the probability that the Cavs will win the first four games of the 
# series.
p_cavs_win4 <- 0.6^4
p_cavs_win4

# Using the variable `p_cavs_win4`, calculate the probability that the Celtics win at least one game in the
# first four games of the series.
# Revisar lo siguiente:
# [There are two ways to calculate the probablity of the Celtics winning at least one game. One way is: 
# Pr(Celtics win 1) + Pr(Celtics win 2) + Pr(Celtics win 3) + Pr(Celtics win 4). The other way to look at it
# is this: if the Celtics have won at least one game, that means the Cavs have not won all 4 games. So the 
# probability is simply 1-p_cavs_win4.] 
1 - p_cavs_win4



## Exercise 5. 
## MONTE CARLO SIMULATIONS FOR CELTICS WINNING A GAME

# Create a Monte Carlo simulation to confirm your answer to the previous problem by estimating how frequently
# the Celtics win at least 1 of 4 games. Use B <- 10000 simulations.

# The provided sample code simulates a single series of four random games, 'simulated_games'.

# Instructions:

# a) Use the 'replicate' function for B <- 10000 simulations of a four game series. The results of 'replicate' should
# be stored to a variable named 'celtic_wins'.

# b) Within each simulation, replicate the sample code to simulate a four-game series named 'simulated_games'. Then,
# use the 'any' function to indicate whether the four-game series contains at least one win for the Celtics. Perform
# these operations in two separate steps.

# c) Use the 'mean' function on 'celtic_wins' to find the proportion of simulations that contain at least one win for 
# the Celtics out of four games.

# CODE

# This line of example code simulates four independent random games where the Celtics either lose or win. Copy this
# example code to use within the `replicate` function.
simulated_games <- sample(c("lose","win"), 4, replace = TRUE, prob = c(0.6, 0.4))

# The variable 'B' specifies the number of times we want the simulation to run. Let's run the Monte Carlo simulation
# 10,000 times.
B <- 10000
replicate(B, {simulated_games <- sample(c("lose","win"), 4, replace = TRUE, prob = c(0.6, 0.4))})

# Use the `set.seed` function to make sure your answer matches the expected result after random sampling.
set.seed(1)

# Create an object called `celtic_wins` that replicates two steps for B iterations: (1) generating a random four-game
# series `simulated_games` using the example code, then (2) determining whether the simulated series contains at least
# one win for the Celtics.
celtic_wins <- replicate(B, {
  simulated_games <- sample(c("lose","win"), 4, replace = TRUE, prob = c(0.6, 0.4))
  any(simulated_games == "win")
})

# Calculate the frequency out of B iterations that the Celtics won at least one game. Print your answer to the console.
mean(celtic_wins)


