## BACKGROUND

# Astronomy is one of the oldest data-driven sciences. In the late 1800s, 
# the director of the Harvard College Observatory hired women to analyze 
# astronomical data, which at the time was done using photographic glass 
# plates. These women became known as the "Harvard Computers". They computed 
# the position and luminosity of various astronomical objects such as stars 
# and galaxies. (If you are interested, you can learn more about the Harvard 
# Computers [https://platestacks.cfa.harvard.edu/women-computers]). Today, 
# astronomy is even more of a data-driven science, with an inordinate amount 
# of data being produced by modern instruments every day.

# In the following exercises we will analyze some actual astronomical data to 
# inspect properties of stars, their absolute magnitude (which relates to a 
# star's luminosity, or brightness), temperature and type (spectral class).


# 2020.11.18


## MEJORAS:

# Q7: Intentar restringir más el numero de estrellas que solo representan a 
#     las gigantes:
#         Ej.1: temp < 5000 & magnitude < 2.5
#         Ej.2: temp %in% (5000:10000) & magnitude < -2.5
# Q8: The dirty hack to the question about the Sun would be to use 
#     color=star=="Sun", then the dot of the Sun would stand out in the chart.
# Q9: Usar: '... + scale_colour_brewer(palette="Set1")', o 
#           '... %>% ggplot(aes(temp, magnitude, color=type)) + ... + geom_text_repel
#                    (aes(temp, magnitude, label=type))




## LIBRARIES AND OPTIONS

library(tidyverse)
library(ggforce)
library(ggrepel)
library(ggthemes)
library(dslabs)
data(stars)
options(digits = 3)   # report 3 significant digits
#library(Rcpp)
#library(Amelia)
#library(GGally)

# IMPORTANT: These exercises use 'dslabs' datasets that were added in a July 2019 
# update. Make sure your package is up to date by reinstalling the package with 
# the command 'install.packages("dslabs")'.


## EXPLORATORY

# NA's. Verificar que no haya datos perdidos

sum(is.na(stars))  # [1] 0, no hay datos perdidos.
stars %>% missmap(col = c("black", "grey"))

# Revisando la correlacion entre variables

ggcorr(stars,
       nbreaks = 6,
       label = TRUE,
       label_size = 3,
       color = "grey50")

# Type
# 1.1.1 Histogram
p <- stars %>% 
  ggplot(aes(type, fill = type)) + 
  geom_histogram(stat = "count") +
  xlab("Type") + 
  ylab("Count") +
  ggtitle("Number of Type of Stars")  # + theme(legend.position = "none") [remueve toda leyenda]
  
p + scale_fill_discrete(name = "Type")


# 1.1.2
df <- data.frame(sort(table(stars$type)))
p <- df %>% 
  ggplot(aes(Var1, Freq, fill = Var1)) + 
  geom_col() +
  coord_flip() +
  xlab("Type") +
  ylab("Frequency") +
  ggtitle("Number of Type of Stars") +
  scale_fill_discrete(name = "Type")  # + theme(legend.position = "none") [remueve toda leyenda]
  
  

# 1.2 Points and Lines
var_type <- sort(table(stars$type))
plot(var_type, "b", ann = FALSE)
title(main = "No. de casos de Tipo de Estrellas",
      xlab = "Tipo", ylab = "Frecuencia")



# Magnitude
# 2.1 Histograma
stars %>% 
  ggplot(aes(magnitude)) + 
  geom_histogram(binwidth = 1, 
                 color = "black", 
                 fill = "coral") +
  scale_x_continuous(breaks = c(-10, -8, -6, -4, -2, 0, 2, 4, 6, 8, 10, 12, 14, 16, 18)) +
  xlab("Magnitude") +
  ylab("Count")


max(stars$magnitude)

min(stars$magnitude)


# 2.2 Distribucion de Densidad
stars %>% 
  ggplot(aes(magnitude)) + 
  geom_density(fill = "brown") +
  scale_x_continuous(breaks = c(-10, -5, 0, 5, 10, 15, 20)) +
  xlab("Magnitude") +
  ylab("Density") +
  ggtitle("Distribucion de Densidad de probabilidad
        en tipos de estrellas") +
  theme(plot.title = element_text(hjust = 0.5))



# Temperature
# 3. Distribucion de Densidad
stars %>% 
  ggplot(aes(temp/10^4)) + 
  geom_density(fill = "blue") +
  xlab("Temperature * 10000 [K]") +
  ylab("Density") +
  ggtitle("Distribucion de Densidad de probabilidad
        en tipos de estrellas") +
  theme(plot.title = element_text(hjust = 0.5))





## QUESTION 1

# Load the stars data frame from dslabs. This contains the name, absolute 
# magnitude, temperature in degrees Kelvin, and spectral class of selected 
# stars. Absolute magnitude (shortened in these problems to simply "magnitude") 
# is a function of star luminosity, where negative values of magnitude have 
# higher luminosity.

# 1. What is the mean magnitude?
mean(stars$magnitude)

# 2. What is the standard deviation of magnitude?
sd(stars$magnitude)





## QUESTION 2

# Make a density plot of the magnitude.
# Graph 2.2 

# How many peaks are there in the data?
# R = 2





## QUESTION 3

# Examine the distribution of star temperature.
# Which of these statements best characterizes the temperature distribution?

# Graph 3. 

# a) The majority of stars have a high temperature.
# b) The majority of stars have a low temperature. (correcto)
# c) The temperature distribution is normal.
# d) There are equal numbers of stars across the temperature range.





## QUESTION 4

# Make a scatter plot of the data with temperature on the x-axis and 
# magnitude on the y-axis and examine the relationship between the variables. 
# Recall that lower magnitude means a more luminous (brighter) star.

# Correlation Luminosity ('Magnitude') vs Temperature
# 4. Scatterplot

stars %>% 
  ggplot(aes(temp/10^4, magnitude)) +
  geom_point(size = 1, color = "purple") +
  geom_hline(yintercept = 0) +
#  scale_x_continuous(breaks = c(0.5, 1, 1.5, 2, 2.5, 3)) +
  xlab("Temperature * 10^4 [k]") +
  scale_y_continuous(breaks = c(-10, -5, 0, 5, 10, 15)) +
  ylab("Magnitude ") +
  ggtitle("Correlation Luminosity vs Temperature") + 
  theme(plot.title = element_text(size = 15, hjust = 0.5))
#  theme_classic()


# When considering the plot of magnitude vs. temperature, most stars follow 
# a _______________ trend. These are called main sequence stars.

# Fill in the blank:
#   decreasing linear
#   increasing linear
#   decreasing exponential (correcto)
#   increasing exponential





## QUESTION 5

# For various reasons, scientists do not always follow straight conventions 
# when making plots, and astronomers usually transform values of star luminosity
# and temperature before plotting. Flip the y-axis so that lower values of 
# magnitude are at the top of the axis (recall that more luminous stars have 
# lower magnitude) using scale_y_reverse(). Take the log base 10 of temperature 
# and then also flip the x-axis.

# Correlation Luminosity ('Magnitude') vs Temperature (reverse scales)
# 5. Scatterplot
p <- stars %>% 
  ggplot(aes(temp, magnitude)) +
  geom_point(size = 1, color = "purple") +
  geom_hline(yintercept = 0) +
  scale_x_continuous(trans = trans_reverser("log10")) +
  annotation_logticks(sides = "tb") +
  xlab("Temperature [K] (scale log) (reverse scale)") +
  scale_y_reverse(limits = c(20, -10), 
                  breaks = c(-10, -5, 0, 5, 10, 15)) +
  ylab("Magnitude (reverse scale)") +
  ggtitle("Correlation Luminosity vs Temperature") + 
  theme(plot.title = element_text(size = 15, 
                                  hjust = 0.5))

p + theme_bw()


# Fill in the blanks in the statements below to describe the resulting plot:
  
# The brighest, highest temperature stars are in the ______________ corner of 
# the plot.

#   lower left
#   lower right
#   upper left (correcto)
#   upper right

# For main sequence stars, hotter stars have __________ luminosity.

#   higher (correcto)
#   lower





## QUESTION 6

# The trends you see allow scientists to learn about the evolution and lifetime 
# of stars. The primary group of stars to which most stars belong we will call 
# the main sequence stars (discussed in question 4). Most stars belong to this 
# main sequence, however some of the more rare stars are classified as "old" 
# and "evolved" stars. These stars tend to be hotter stars, but also have low 
# luminosity, and are known as white dwarfs.

# How many white dwarfs are there in our sample?
# R = 4





## QUESTION 7

# Consider stars which are not part of the Main Group but are not old/evolved 
# (white dwarf) stars. These stars must also be unique in certain ways and are 
# known as giants. Use the plot from Question 5 to estimate the average temperature
# of a giant.

stars %>% 
  filter(temp < 10000 & magnitude < 2) %>% 
  summarize(average = mean(temp))              # average = 6984

# Which of these temperatures is closest to the average temperature of a giant?:

# a) 5000K (correcto)
# b) 10000K
# c) 15000K
# d) 20000K





## QUESTION 8

# We can now identify whether specific stars are main sequence stars, red giants 
# or white dwarfs. Add text labels to the plot to answer these questions. You may
# wish to plot only a selection of the labels, repel the labels, or zoom in on the
# plot in RStudio so you can locate specific stars.

# Correlation Luminosity ('Magnitude') vs Temperature (reverse scales)
# 5.1 Scatterplot with text labels
p <- stars %>% 
  ggplot(aes(log10(temp), magnitude, label = star)) +
  geom_point(aes(color = type), size = 1) +
  geom_text_repel(size = 3) +
  geom_hline(yintercept = 0) +
  scale_x_reverse(limits = c(4.7, 3.0)) +
  annotation_logticks(sides = "tb") +
  xlab("Temperature [K] (scale log) (reverse scale)") +
  scale_y_reverse(limits = c(20, -10), 
                  breaks = c(-10, -5, 0, 5, 10, 15)) +
  ylab("Magnitude (reverse scale)") +
  ggtitle("Correlation Luminosity vs Temperature") + 
  scale_color_discrete(name = "Type") +
  theme(plot.title = element_text(size = 15, 
                                  hjust = 0.5))

p + theme_bw()


# Fill in the blanks in the statements below:
  
# The least lumninous star in the sample with a surface temperature over 5000K 
# is _________.

# a) Antares
# b) Castor
# c) Mirfak
# d) Polaris
# e) van Maanen's Star (correcto)

# The two stars with lowest temperature and highest luminosity are known as supergiants. 
# The two supergiants in this dataset are ____________.

# a) Rigel and Deneb
# b) *SiriusB and van Maanen's Star
# c) Alnitak and Alnitam
# d) Betelgeuse and Antares (correcto)
# e) Wolf359 and G51-I5

# The Sun is a ______________.

# a) main sequence star (correcto)
# b) giant
# c) white dwarf





## QUESTION 9

# Remove the text labels and color the points by star type. This classification describes 
# the properties of the star's spectrum, the amount of light produced at various wavelengths.

# Correlation Luminosity ('Magnitude') vs Temperature (reverse scales)
# 5.2 Scatterplot with points by type of stars
p <- stars %>% 
  ggplot(aes(log10(temp), magnitude)) +
  geom_point(aes(color = type), size = 2) +
  geom_hline(yintercept = 0) +
  scale_x_reverse(limits = c(4.7, 3.0)) +
  annotation_logticks(sides = "tb") +
  xlab("Temperature [K] (scale log) (reverse scale)") +
  scale_y_reverse(limits = c(20, -10), 
                  breaks = c(-10, -5, 0, 5, 10, 15)) +
  ylab("Magnitude (reverse scale)") +
  ggtitle("Correlation Luminosity vs Temperature") + 
  scale_color_discrete(name = "Type") +
  theme(plot.title = element_text(size = 15, 
                                  hjust = 0.5))

p + theme_bw()


# a) Which star type has the lowest temperature?
#    R = M

# b) Which star type has the highest temperature?
#    R = O

# c) The Sun is classified as a G-type star. Is the most luminous G-type star in this dataset 
# also the hottest?
#    R = No




