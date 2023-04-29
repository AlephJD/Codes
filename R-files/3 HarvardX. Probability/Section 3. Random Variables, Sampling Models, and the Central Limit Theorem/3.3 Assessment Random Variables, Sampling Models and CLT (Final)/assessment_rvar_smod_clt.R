## Section 3:
## 3.3 Assessment: Random Variables, Sampling Models and The Central Limit Theorem

# 2021.06.30



## QUESTIONS 1 AND 2: SAT TESTING

# The SAT is a standardized college admissions test used in the United States. The following two 
# multi-part questions will ask you some questions about SAT testing.

# This is a 6-part question asking you to determine some probabilities of what happens when a student
# guessed for all of their answers on the SAT. Use the information below to inform your answers for
# the following questions.

# An old version of the SAT college entrance exam had a -0.25 point penalty for every incorrect answer
# and awarded 1 point for a correct answer. The quantitative test consisted of 44 multiple-choice 
# questions each with 5 answer choices. Suppose a student chooses answers by guessing for all questions
# on the test.



# Question 1a
# What is the probability of guessing correctly for one question?
p <- 1/5
# [1] 0.2 (correcto)


  
# Question 1b
# What is the expected value of points for guessing on one question?
q <- 1 - p
ev <- (1*p + -0.25*q)
# [1] 0 (correcto)



# Question 1c
# What is the expected score of guessing on all 44 questions?
n <- 44
es <- n * (1*p + -0.25*q)
# [1] 0 (correcto)



# Question 1d
# What is the standard error of guessing on all 44 questions?
se <- sqrt(n)*abs((-0.25)-(1))*sqrt(p*q)
# [1] 3.316625 (correcto)



# Question 1e
# Use the Central Limit Theorem to determine the probability that a guessing student scores 8 points ("quantile 8")
# or higher on the test.
pnorm(8, es, se)         # [1] 0.9920693
prob_8plus <- 1 - pnorm(8, es, se)
# [1] 0.007930666 (correcto)



# Question 1f

# Set the seed to 21, then run a Monte Carlo simulation of 10,000 students guessing on the test.
# (IMPORTANT! If you use R 3.6 or later, you will need to use the command set.seed(x, sample.kind = "Rounding")
# instead of set.seed(x). Your R version will be printed at the top of the Console window when you start RStudio.)

set.seed(21, sample.kind = "Rounding")

# What is the probability that a guessing student scores 8 points ("quantile 8") or higher?
B <- 10^4
S <- replicate(B, {
  X <- sample(c(1,-0.25), n, replace = TRUE, prob = c(p,q))
  sum(X)      # Debemos hacer la suma para saber el resultado final de cada test, y tener 10^4 resultados finales para 
              # obtener las proporciones que se buscan.
})

mean(S >= 8)
# [1] 0.008 (correcto)


  
# The SAT was recently changed to reduce the number of multiple choice options from 5 to 4 and also to
# eliminate the penalty for guessing.

# In this two-part question, you'll explore how that affected the expected values for the test.


# Question 2a

# Suppose that the number of multiple choice options is 4 and that there is no penalty for guessing
# - that is, an incorrect question gives a score of 0.

# What is the expected value of the score when guessing on this new test?
p <- 1/4
q <- 1 - p
a <- 1
b <- 0
es <- n * (a*p + b*q)
# [1] 11 (correcto)



# Question 2b

# Consider a range of correct answer probabilities 'p <- seq(0.25, 0.95, 0.05)' representing a range
# of student skills.
p <- seq(0.25, 0.95, 0.05)
# [1] 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 {{0.85}} 0.90 0.95

# What is the lowest 'p' such that the probability of scoring over 35 exceeds 80%?     
es <- n*(a*p + b*(1-p))
es
# [1] 11.0 13.2 15.4 17.6 19.8 22.0 24.2 26.4 28.6 30.8 33.0 35.2 37.4 39.6 41.8

se <- sqrt(n)*abs(b-a)*sqrt(p*(1-p))
se
# [1] 2.872281 3.039737 3.163858 3.249615 3.300000 3.316625 3.300000 3.249615 3.163858 3.039737 2.872281 2.653300 2.368544
# [14] 1.989975 1.445683

1 - pnorm(35, es, se)
# [1] 0.000000e+00 3.704814e-13 2.914853e-10 4.290144e-08 2.051844e-06 4.433929e-05 5.325760e-04 4.066871e-03 2.154449e-02
# [10] 8.353214e-02 2.431172e-01 5.300430e-01 8.445370e-01 9.895998e-01 9.999987e-01

100*(1 - pnorm(35, es, se))
# [1] 0.000000e+00 3.704814e-11 2.914853e-08 4.290144e-06 2.051844e-04 4.433929e-03 5.325760e-02 4.066871e-01 2.154449e+00
# [10] 8.353214e+00 2.431172e+01 5.300430e+01 {{8.445370e+01}} 9.895998e+01 9.999987e+01


# The lowest 'p' such that the probability of scoring over 35 exceeds 80%
# p = 0.85, 
# es = 37.4, se = 2.368544, Pr(X > 35) = 0.8445370, % = 84.45



###################################################################################################
###################################################################################################



## QUESTION 3: BETTING ON ROULETTE

# A casino offers a House Special bet on roulette, which is a bet on five pockets (00, 0, 1, 2, 3) 
# out of 38 total pockets. The bet pays out 6 to 1. In other words, a losing bet yields -$1 and a 
# successful bet yields $6. A gambler wants to know the chance of losing money if he places 500 bets
# on the roulette House Special.

# The following 7-part question asks you to do some calculations related to this scenario.


# Question 3a
# What is the expected value of the payout for one bet?
a <- 6
b <- -1
p <- 5/38
q <- 1 - p    # q = 33/38

n <- 1
ev <- n * (a*p + b*q)
# [1] -0.07894737 (correcto)



# Question 3b
# What is the standard error of the payout for one bet?
se <- sqrt(n) * abs(b - a) * sqrt(p * q)
# [1] 2.366227 (correcto)


  
# Question 3c
# What is the expected value of the average payout over 500 bets?
# NOTE: Remember there is a difference between expected value of the average and expected value of
#       the sum.
(a*p + b*q)
# [1] -0.07894737 (correcto)



# Question 3d
# What is the standard error of the average payout over 500 bets?
# NOTE: Remember there is a difference between the standard error of the average and standard error 
#       of the sum.
n <- 500
(abs(b - a) * sqrt(p * q))/sqrt(n)
# [1] 0.1058209 (correcto)



# Question 3e
# What is the expected value of the sum of 500 bets?
n * (a*p + b*q)
# [1] -39.47368 (correcto)
  


# Question 3f
# What is the standard error of the sum of 500 bets?
sqrt(n) * abs(b - a) * sqrt(p * q)  
# [1] 52.91045 (correcto)


  
# Question 3g
# Use 'pnorm()' with the expected value of the sum and standard error of the sum to calculate the 
# probability of losing money over 500 bets, Pr???(X???0).
ev <- n * (a*p + b*q)
se <- sqrt(n) * abs(b - a) * sqrt(p * q)

pnorm(0, ev, se)

# [1] 0.7721805 (correcto)




