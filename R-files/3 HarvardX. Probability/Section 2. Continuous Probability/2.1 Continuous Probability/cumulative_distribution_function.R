# Code that write the distribution function for continuous data 'x' (variables continuas) that reports
# the proportion of the data below 'a' for all values of 'a':

# 2021.04.30

# Code: Cumulative distribution function
# Define 'x' as male heights from the 'dslabs' heights dataset:
  
library(tidyverse)
library(dslabs)
data(heights)
x <- heights %>% filter(sex=="Male") %>% pull(height)

# Given a vector 'x', we can define a function for computing the CDF of x using:
F <- function(a) mean(x <= a)
1 - F(70)    # probability of male taller than 70 inches
