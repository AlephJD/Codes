# Codigo para comparar quantiles teoricos vs. quantiles observados, 
# y comprobar que tan bien se ajustan los datos a una distribucion normal.


# Define x and z
library(tidyverse)
# library(dplyr)
library(dslabs)
data(heights)
index <- heights$sex == "Male"
x <- heights$height[index]
z <- scale(x)

# Proportion of data below 69.5

mean(x <= 69.5)

# Calculate observed and theoretical quantiles

p <- seq(0.05, 0.95, 0.05)
observed_quantiles <- quantile(x, p)
theoretical_quantiles <- qnorm(p, mean = mean(x), sd = sd(x))

# Make QQ-plot

plot(theoretical_quantiles, observed_quantiles)
abline(0,1)

# Make QQ-plot with scaled values
observed_quantiles <- quantile(z, p)
theoretical_quantiles <- qnorm(p)
plot(theoretical_quantiles, observed_quantiles)
abline(0,1)







