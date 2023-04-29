# Mathematical theory and a6demostration of Central Limit Theorem

# 2021.06.17

library(dslabs)

# The standard deviation of a list 'x' (below we use heights as an example) is defined as the square root
# of the average of the squared differences:

x <- heights$height
m <- mean(x)
s <- sqrt(mean((x-m)^2))


# However, be aware that the 'sd' function returns a slightly different result:

identical(s, sd(x))
# [1] FALSE
s-sd(x)
# [1] -0.001942661


# This is because the 'sd' function R does not return the 'sd' of the list, but rather uses a formula that
# estimates standard deviations of a population from a random sample X1,...,XN which, for reasons not discussed
# here, divide the sum of squares by the N-1:

# You can see that this is the case by typing:

n <- length(x)
s-sd(x)*sqrt((n-1)/n)













