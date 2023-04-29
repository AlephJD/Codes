## Code to compare distributions of average annual income in space 
## (between countries) and time.
## From chapter of the book:
## https://rafalab.github.io/dsbook/gapminder.html#example-1970-versus-2010-income-distributions

# 2020.08.19

library(tidyverse)
library(dplyr)
library(ggplot2)
library(ggridges)
library(dslabs)
data(gapminder)

# let's start by quickly examining the data by region. 
# We reorder the regions by the median value and use a log scale 
# in a points plot.

past_year <- 1970

gapminder <- gapminder %>% mutate(dollars_per_day = gdp/population/365)

p <- gapminder %>% 
  filter(year == past_year & !is.na(gdp)) %>%
  mutate(region = reorder(region, dollars_per_day, FUN = median)) %>%
  ggplot(aes(dollars_per_day, region)) + 
  geom_point() +
  scale_x_continuous(trans = "log2")
p

# We can already see that there is indeed a "west versus the rest" dichotomy.
# We define groups based on this observation:

gapminder <- gapminder %>% mutate(group = case_when(
  region %in% c("Western Europe", "Northern Europe", "Southern Europe", "Northern America", "Australia and New Zealand") ~ "West",
  region %in% c("Eastern Asia", "South-Eastern Asia") ~ "East Asia",
  region %in% c("Caribbean", "Central America", "South America") ~ "Latin America",
  continent == "Africa" & region != "Northern Africa" ~ "Sub-Saharan",
  TRUE ~ "Others"))

# We turn this group variable into a factor to control the order of the levels:

gapminder <- gapminder %>% 
  mutate(group = factor(group, levels = c("Others", "Latin America",
                                          "East Asia", "Sub-Saharan",
                                          "West")))


# We now want to compare the distribution across these five groups to confirm the "west versus the rest" dichotomy
# We therefore start by stacking boxplots next to each other.

p <- gapminder %>% 
  filter(year == past_year & !is.na(gdp)) %>%
  ggplot(aes(group, dollars_per_day)) +
  geom_boxplot() +
  scale_y_continuous(trans = "log2") +
  xlab("") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
p


# Boxplots have the limitation that by summarizing the data into five numbers, 
# we might miss important characteristics of the data. 
# One way to avoid this is by showing the data.

p + geom_point(alpha = 0.5)


# Boxplots help with this by providing a five-number summary, 
# but this has limitations too. 
# For example, boxplots will not permit us to discover bimodal distributions.
# In cases in which we are concerned that the boxplot summary is too simplistic, 
# we can show stacked smooth densities or histograms. 
# We refer to these as ridge plots.

p <- gapminder %>%
  filter(year == past_year & !is.na(dollars_per_day)) %>%
  ggplot(aes(dollars_per_day, group)) +
  scale_x_continuous(trans = "log2")
p + geom_density_ridges()


# If the number of data points is small enough, we can add them to the ridge plot using the following code:

p + geom_density_ridges(jittered_points = TRUE)


# By default, the height of the points is jittered and should not be interpreted in any way. 
# To show data points, but without using jitter we can use the following code to add what 
# is referred to as a rug representation of the data.

p + geom_density_ridges(jittered_points = TRUE,
                        position = position_points_jitter(height = 0),
                        point_shape = "|",
                        point_size = 3,
                        point_alpha = 1,
                        alpha = 0.7)



##################################
##################################
##################################


# we are going to define a vector that defines the regions in the West.

west <- c("Western Europe", 
             "Northern Europe", 
             "Southern Europe", 
             "Northern America", 
             "Australia and New Zealand")

# Now we want to focus on comparing the differences in distribution across time.
# We start by confirming that the bi-modality observed in 1970
# is explained by a West vs. Developing world economy.
# We do this by creating a histogram for the groups previously defined.

# first west vs. developing
gapminder %>%
  filter(year == past_year & !is.na(gdp)) %>%
  mutate(group = ifelse(region %in% west, "West", "Developing")) %>%
  ggplot(aes(dollars_per_day)) +
  geom_histogram(binwidth = 1, color = "black") +
  scale_x_continuous(trans = "log2") +
  facet_grid(. ~ group)

# second west vs. developing in 1970 and 2010

present_year <- 2010
years <- c(past_year, present_year)
gapminder %>%
  filter(year %in% years & !is.na(gdp)) %>%
  mutate(group = ifelse(region %in% west, "West", "Developing")) %>%
  ggplot(aes(dollars_per_day)) +
  geom_histogram(binwidth = 1, color = "black") +
  scale_x_continuous(trans = "log2") +
  facet_grid(year ~ group)


## Del capitulo del libro:
## https://rafalab.github.io/dsbook/gapminder.html#example-1970-versus-2010-income-distributions

# present_year <- 2010
# years <- c(past_year, present_year)
# gapminder %>%
#   filter(year %in% years & !is.na(gdp)) %>%
#   mutate(west = ifelse(group == "West", "West", "Developing")) %>%
#   ggplot(aes(dollars_per_day)) +
#   geom_histogram(binwidth = 1, color = "black") +
#   scale_x_continuous(trans = "log2") +
#   facet_grid(year ~ west)


# A partir de ~1990 surgieron mas naciones, lo cual se ve reflejado en la 
# grafica del 2010 en el "conteo"; por lo tanto, vamos a seleccionar los paises que 
# aparecen en ambos años tomando como referencia el año 1970.

country_list_1 <- gapminder %>%
  filter(year == past_year & !is.na(dollars_per_day)) %>%
  .$country
country_list_2 <- gapminder %>%
  filter(year == present_year & !is.na(dollars_per_day)) %>%
  .$country
country_list <- intersect(country_list_1, country_list_2)


# lets use only the subset of countries that are present for which
# data is present in 1970 and 2010.


gapminder %>% 
  filter(year %in% years & 
           country %in% country_list) %>%
  mutate(group = ifelse(region %in% west, "West", "Developing")) %>%
  ggplot(aes(dollars_per_day)) +
  geom_histogram(binwidth = 1, color = "black") +
  scale_x_continuous(trans = "log2") +
  facet_grid(year ~ group)

         
## To see which specific regions improve the most, we can remake the 
## boxplots that we made earlier, but now adding 2010 

# then using "facet_grid" to compare the two years between the five principal regions. 
# [capitulo del libro]).

p <- gapminder %>% 
  filter(year %in% years & country %in% country_list) %>% 
  ggplot(aes(group, dollars_per_day)) + 
  geom_boxplot() + 
  scale_y_continuous(trans = "log2") + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  xlab("") + 
  facet_grid(. ~year)

# Instead of faceting, we keep the data from each year together
# and ask to color (or fill) them depending on the year
# Because year is a number, we turn it into a factor.

gapminder %>%
  filter(year %in% years & country %in% country_list) %>%
  mutate(year = factor(year)) %>%
  ggplot(aes(group, dollars_per_day, fill = year)) +
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = 90, hjust =1)) +
  scale_y_continuous(trans = "log2") +
  xlab("")

# Finally, we point out that if what we are most interested in is 
# comparing before and after values, it might make more sense to plot 
# the percentage increases. We are still not ready to learn to code this.

# The previous data exploration suggested that the income gap between rich 
# and poor countries has narrowed.
# We suggest a succinct way to convey this message with just one plot.

gapminder %>%
  filter(year %in% years & country %in% country_list) %>%
  ggplot(aes(dollars_per_day)) + 
  geom_density(fill = "grey") + 
  scale_x_continuous(trans = "log2") +
  facet_grid(.~year)
  # facet_grid(year~.) (me gusta mas..)


# The next message we need to convey is that the reason for this change 
# in distribution is that several poor countries became richer, rather 
# than some rich countries becoming poorer. To do this, we can assign a 
# color to the groups we identified during data exploration.

gapminder %>%
  filter(year %in% years & country %in% country_list) %>%
  mutate(group = ifelse(group == "West", "West", "Developing")) %>%
  ggplot(aes(dollars_per_day, fill = group)) +
  scale_x_continuous(trans ="log2") +
  geom_density(alpha = 0.2) +
  facet_grid(year~.)


# This makes it appear as if there are the same number of countries in each group.

# To have the areas of these densities be proportional to the size of the groups, we 
# can simply multiply the y-axis values by the size of the group. From the geom_density 
# help file, we see that the functions compute a variable called count that does exactly 
# this. We want this variable to be on the y-axis rather than the density.

# In ggplot2, we access these variables by surrounding the name with two dots.
# "...aes(x = dollars_per_day, y = ..count..)..."

p <- gapminder %>%
  filter(year %in% years & country %in% country_list) %>%
  mutate(group = ifelse(group == "West", "West", "Developing")) %>%
  ggplot(aes(x = dollars_per_day, y = ..count.., fill = group)) +
  scale_x_continuous(trans = "log2", limit = c(0.125, 300))

p + geom_density(alpha = 0.2) + 
  facet_grid(year ~ .)


# If we want the densities to be smoother, we use the bw argument so that the 
# same bandwidth is used in each density.

p + 
  geom_density(alpha = 0.2, bw = 0.75) +
  facet_grid(year ~ .)


# To visualize if any of the groups defined above are driving this we can quickly make a ridge plot.

gapminder %>% 
  filter(year %in% years & !is.na(dollars_per_day)) %>%  # filter(year %in% years & country %in% country_list & !is.na(dollars_per_day)) %>%
  ggplot(aes(dollars_per_day, group)) +
  scale_x_continuous(trans = "log2") +
  geom_density_ridges(adjust = 1.5) +
  facet_grid(. ~ year)


# Another way to achieve this is by stacking the densities on top of each other:

gapminder %>%
  filter(year %in% years & country %in% country_list) %>%
  group_by(year) %>%
  mutate(weight = population/sum(population)*2) %>%
  ungroup() %>%
  ggplot(aes(dollars_per_day, fill = group)) +
  scale_x_continuous(trans = "log2", limit = c(0.125, 300)) +
  geom_density(alpha = 0.2, bw = 0.75, position ="stack") +
  facet_grid(year ~ .)
