# Normal Distribution

# Define x as vector o male heights
library(tidyverse)
library(dslabs)
data(heights)
ind <- heights$sex == "Male"
x <- heights$height[ind]

# Calculate the mean and standard deviation manually
average <- sum(x)/length(x)
SD <- sqrt( sum( (x - average)^2 ) / length(x))

# Built-in mean and sd functions
average <- mean(x)
SD <- sd(x)
c(average = average, SD = SD)

# Calculate standard units
z <- scale(x)

# Calculate proportions of values within 2 SD of mean
mean(abs(z) < 2) # 0.9495074, ~0.95 = 95%


