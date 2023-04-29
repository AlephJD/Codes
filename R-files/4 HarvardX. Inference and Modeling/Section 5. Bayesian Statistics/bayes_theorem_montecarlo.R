## We realize a Monte Carlo simulation using Bayes' Theorem in a hypothetical
## disease test to find the probability of this disease.

## 2022.02.26


## Web link: 
## https://learning.edx.org/course/course-v1:HarvardX+PH125.4x+3T2022/block-v1:HarvardX+PH125.4x+3T2022+type@sequential+block@81aaa84910454cda8db17816ca2cca66/block-v1:HarvardX+PH125.4x+3T2022+type@vertical+block@5d3eb97dd8ff4dcd955df8c581c471a5


# Bayesian Statistics: Bayes' Theorem

# Example: Cystic Fibrosis test probabilities 

## Equations:

## Pr(D=1|+) = ( Pr(+|D=1) * Pr(D=1) ) / (Pr(+))
## Pr(D=1|+) = ( Pr(+|D=1) * Pr(D=1) ) / ( Pr(+|D=1) * Pr(D=1) + Pr(+|D=0) * Pr(D=0) )


## Code: Monte Carlo Simulation

prev <- 0.00025    # disease prevalence  ## Rate of Cystic Fibrosis: Pr(D = 1), "(1-prev) = Pr(D = 1)"
N <- 100000    # number of tests
outcome <- sample(c("Disease", "Healthy"), N, replace = TRUE, prob = c(prev, 1-prev))

N_D <- sum(outcome == "Disease")    # number with disease
N_H <- sum(outcome == "Healthy")    # number healthy

# for each person, randomly determine if test is + or -
accuracy <- 0.99          # Accuracy of 99%,    Prob(+|D=1)=0.99, Prob(-|D=0)=0.99
test <- vector("character", N)
test[outcome == "Disease"] <- sample(c("+", "-"), N_D, replace=TRUE, prob = c(accuracy, 1-accuracy))
test[outcome == "Healthy"] <- sample(c("-", "+"), N_H, replace=TRUE, prob = c(accuracy, 1-accuracy))

table(outcome, test)

# Also, there are many without the disease, which makes it more probable that we will see
# some false positives given that the test is not perfect.

