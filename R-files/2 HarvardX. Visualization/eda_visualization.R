# Code that make exploratory data analysis (EDA)[visualization] plotting "murders"
# data.

library(tidyverse)
library(dplyr)
library(ggplot2)
library(dslabs)

data("murders")

p <- murders %>% ggplot()   # p <- ggplot(data = murders)
# class (p)
# p

# add points layer to predefined ggplot object
p + geom_point(aes(x = population/10^6, y = total))


# change the size of the points, and add text layer to scatterplot
p + geom_point(aes(population/10^6, total), size = 3) + geom_text(aes(population/10^6, total, label = abb))


# move text labels slightly to the right
p + geom_point(aes(population/10^6, total), size = 3) + geom_text(aes(population/10^6, total, label = abb), nudge_x = 1.5)


# Doing the Global Aesthetic Mapping to simplify code

p <- murders %>% ggplot(aes(population/10^6, total, label = abb))
p + geom_point(size = 3) + geom_text(nudge_x = 1.5)


# Overriding global aesthetics mapping with local aesthetics definitions.

p + geom_point(size = 3) + geom_text(aes(x = 10, y = 800, label = "Hello there!"))



## Log-scale the x- and y-axis
# una vez definido 'p' cambiamos la escala de los ejes x e y.

# log base 10 scale the x-axis and y-axis
p + geom_point(size = 3) + geom_text(nudge_x = 0.5) + scale_x_continuos(trans = "log10") + scale_y_continuos(trans = "log10")

# efficient log scaling of the axes
p + geom_point(size = 3) + geom_text(nudge_x = 0.075) + scale_x_log10() + scale_y_log10()


## Add labels and title
p + geom_point(size = 3) + geom_text(nudge_x = 0.075) + scale_x_log10() + scale_y_log10() + xlab("Population in millions (log scale)") + ylab("Total number of murders(log scale)") + ggtitle("US Gun Murders in 2010")


## Change color of the points

# redefine 'p' to be everything except the points layer
p <- murders %>% ggplot(aes(population/10^6, total, label = abb)) + geom_text(nudge_x = 0.075) + scale_x_log10() + scale_y_log10() + xlab("Population in millions (log scale)") + ylab("Total number of murders(log scale)") + ggtitle("US Gun Murders in 2010")

# make all points blue
p + geom_point(size = 3, color = "blue")

# color points by region
p + geom_point(aes(col = region), size = 3)


## Add a line with average murder rate

# define average murder rate
r <- murders %>% summarize(rate = sum(total) / sum(population) * 10^6) %>% pull(rate)
# ó r <- murders %>% summarize(rate = sum(total) / sum(population) * 10^6) %>% .$rate

# basic line with average murder rate for the country
p + geom_point(aes(col = region), size = 3) + geom_abline(intercept = log10(r))   # slope is default of 1


# change line to dashed and dark grey, line under points
p  <-  geom_abline(intercept = log10(r), lty = 2, color ="dargrey") + geom_point(aes(col = region), size = 3)


## Change legend title
p <-  p + scale_color_discrete(name = "Region") # capitalize legend title



## ADDING THEMES
# theme used for graphs in the textbook and course
library(dslabs)
ds_theme_set()

# themes from ggthemes
library(ggthemes)
p + theme_economist()    # style of the Economist magazine
p + theme_fivethirtyeight()    # style of the FiveThirtyEight website


## PUTTING IT ALL TOGETHER TO ASSEMBLE THE PLOT
# load libraries
library(tidyverse)
library(ggrepel)
library(ggthemes)
library(dslabs)
data(murders)

# define the intercept
r <- murders %>%
  summarize(rate = sum(total) / sum(population) * 10^6) %>%
  .$rate

# make the plot, combining all elements
murders %>%
  ggplot(aes(population/10^6, total, label = abb)) +
  geom_abline(intercept = log10(r), lty = 2, color = "darkgrey") +
  geom_point(aes(col = region), size = 3) +
  geom_text_repel() +
  scale_x_log10() +
  scale_y_log10() +
  xlab("Population in millions (log scale)") +
  ylab("Total number of murders (log scale)") +
  ggtitle("US Gun Murders in 2010") +
  scale_color_discrete(name = "Region") +
  theme_economist()








