# Code to initiate analyzing data.

## Ejemplo 1. 
## Alturas en hombres (pulgadas)

library(tidyverse)
library(dslabs)
library(dplyr)
data(heights)

h <-heights$height[heights$sex == "Male"]


avg <- mean(h)
stdev <- sd(h)

hist(h)
plot(ecdf(h))

p <- seq(0.05, 0.95, 0.05)
z <- scale(h)

obs_q <- quantile(h, p)

# Comprobando que los datos observados se ajusten a los teoricos,
# y por lo tanto a una distribucion normal.

teo_q <- qnorm(p, avg, stdev)

plot(teo_q, obs_q)
abline(0,1)




# From US Murders Data
## https://courses.edx.org/courses/course-v1:HarvardX+PH125.2x+1T2020/courseware/1772ea155e374ad99d45629d5a572854/890e07a938ed438fb28b48e9a27f6945/?activate_block_id=block-v1%3AHarvardX%2BPH125.2x%2B1T2020%2Btype%40sequential%2Bblock%40890e07a938ed438fb28b48e9a27f6945
## Boxplots

data(murders)

murders_rate <- murders$total/murders$population*10^5

hist(murders_rate, 6)

p <- seq(0.05, 0.95, 0.05)

obs_mr <- quantile(murders_rate, p)
theo_mr <- qnorm(p, mean(murders_rate), sd(murders_rate))

plot(theo_mr, obs_mr)
abline(0,1)




