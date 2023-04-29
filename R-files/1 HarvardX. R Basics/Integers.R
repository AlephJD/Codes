# Question 5b (Section 3 Assesment)
# Which integer values are between the maximum and minimum heights (en una base de datos)? For example, if the minimum height is 10.2 and the maximum height is 20.8, your answer should be x <- 11:20 to capture the integers in between those values. (If either the maximum or minimum height are integers, include those values too.)

# Write code to create a vector x that includes the integers between the minimum and maximum heights.
# (There are multiple ways to solve this problem, but the grader expects you to use the format in the problem description.)

library(dslabs)
data("heights")
options(digits = 3)

mi <- min(heights$height) #50
ma <- max(heights$height) #82.7


# xx <- c(10.2,10.8,11.0,11.1,11.9,12.5,12.8,13.4,13.7,14.0,14.3,14.7,15.3,15.6,17.0,17.5,18.9,19.2,19.7,20.7,20.8)
# x <- round(min(xx):max(xx))


x <- 50:82 

ind <- match(int,heights$height)

ind2 <- !is.na(ind)

int[ind2]


# and 5c: sum(!x %in% heights$height)
