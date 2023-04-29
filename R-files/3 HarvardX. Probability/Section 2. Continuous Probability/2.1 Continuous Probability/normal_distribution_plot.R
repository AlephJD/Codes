# Normal Distribution Plot

# 2021.05.04


## Code: Plotting the normal distribution with dnorm
# Use 'd' to plot the density function of a continuous distribution. Here is the density function for
# the normal distribution (abbreviation norm()):
library(tidyverse)
  
x <- seq(-4, 4, length.out = 100)
data.frame(x, f = dnorm(x)) %>%
  ggplot(aes(x,f)) +
  geom_line()
