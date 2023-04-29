# Code that ease comparison cues between graphics with visual encoding
# using data heights.
# 2020.10.07


library(tidyverse)
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggthemes)
library(gridExtra)
library(ggrepel)
library(dslabs)
data(heights)
data(gapminder)


## PART 1. Doesn't have code

## PART 2.

# 1. SHOW THE DATA
# dot plot showing the data
heights %>% 
  ggplot(aes(sex, height)) + 
  geom_point()

# jittered, alpha blended point plot
heights %>% 
  ggplot(aes(sex, height)) + 
  geom_jitter(width = 0.1, alpha = 0.2)

# 2. EASE COMPARISON. USE COMMON AXES
# showing distributions of data 

# using histogram
heights %>% 
  ggplot(aes(height, ..density..)) + 
  geom_histogram(binwidth = 1, fill = "blue", color = "black") + 
  xlab("Height") + 
  ylab("Density") + 
  ggtitle("Histogram") + facet_grid(sex ~ .)


# using boxplots

heights %>% 
  ggplot(aes(sex, height)) + 
  geom_boxplot() + 
  geom_jitter() +
  ylab("Heights in inches")


# 3. CONSIDER TRANSFORMATIONS

# Codigo propio generado por mi.

gapminder %>%
  filter(year == 2015) %>% 
  group_by(continent) %>%
  summarize(average_population = mean(population)/10^6) %>%
  ungroup() %>%
  mutate(continent = reorder(continent, average_population)) %>%
  ggplot(aes(continent, average_population)) +
  geom_col(width = 0.5, fill = "blue") +
  xlab("Continent") +
  ylab("Population in millions") +
  theme_excel()


# Codigo propio generado por mi.

gapminder %>%
  filter(year == 2015) %>%
  mutate(continent = factor(continent, levels= c("Oceania", 
                                                 "Europe", 
                                                 "Africa", 
                                                 "Americas", 
                                                 "Asia"))) %>%
  ggplot(aes(continent, population/10^6)) +
  geom_jitter(width = 0.1, alpha = 0.3) +
  xlab("Continent") +
  ylab("Population in millions")

  
# Parece que esta version de codigo (como la anterior), 
# no se puede.

#gapminder %>%
#  filter(year == 2015) %>%
#  group_by(continent) %>%
#  summarize(average_population = mean(population)/10^6) %>%
#  ungroup() %>%
#  mutate(continent = reorder(continent, average_population)) %>%
#  ggplot(aes(continent, population)) +
#  geom_point()


# Codigo propio generado por mi.

p1 <- gapminder %>% 
  filter(year == 2015) %>%
  group_by(continent) %>%
  summarize(average_population = mean(population)/10^6) %>%
  ungroup() %>%
  mutate(continent = reorder(continent, average_population)) %>%
  ggplot(aes(continent, average_population)) +
  geom_col(width = 0.5, fill = "blue") +
  xlab("Continent") + 
  ylab("Population in millions") + 
  theme_excel()

p2 <- gapminder %>%
  filter(year == 2015) %>%
  mutate(continent = factor(continent, 
                            levels = c("Oceania",
                                       "Europe",
                                       "Africa",
                                       "Americas",
                                       "Asia"))) %>%
  ggplot(aes(continent, population/10^6)) +
  geom_boxplot(coef = 3, width = 0.4) +
  geom_jitter(width = 0.1, alpha = 0.3) +
  scale_y_continuous(trans = "log2", 
                     breaks = c(1, 10, 100, 1000)) +
  xlab("Continent") +
  ylab("Population in millions")

grid.arrange(p1,p2,ncol=2)


# Esta es la misma grafica 'p2' siguiendo la mediana 
# poblacional como referente

p2 <- gapminder %>%
  filter(year == 2015) %>%
  ggplot(aes(reorder(continent, population, median), population/10^6)) +
  geom_boxplot(coef = 3, width = 0.4) +
  geom_jitter(width = 0.1, alpha = 0.3) +
  scale_y_continuous(trans = "log2", 
                     breaks = c(1, 10, 100, 1000)) +
  xlab("Continent") +
  ylab("Popoulation in millions")



# 4. EASE COMPARISONS: COMPARED VISUAL CUES SHOULD BE ADJACENT

color_blind_friendly_cols <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

p1 <- data.frame(x = 1:8, y = 1:8, col = as.character(1:8)) %>%
  ggplot(aes(x, y, color = col)) +
  geom_point(size = 5)
p1 + scale_color_manual(values = color_blind_friendly_cols)



## PART 3

# 5. SLOPE CHARTS. (*cHANGES IN TIME)

#library(tidyverse)
#library(dslabs)
#data(gapminder)

west <- c("Western Europe", "Northern Europe", "Southern Europe", "Northern America", "Australia and New Zealand")

dat <- gapminder %>%
  filter(year %in% c(2010, 2015) & region %in% west & !is.na(life_expectancy) & population > 10^7)

dat %>%
  mutate(location = ifelse(year == 2010, 1, 2),
         location = ifelse(year == 2015 & country %in% c("United Kingdom", "Portugal"),
                           location + 0.22, location),
         hjust = ifelse(year == 2010, 1, 0)) %>%
  mutate(year = as.factor(year)) %>%
  ggplot(aes(year, life_expectancy, group = country)) +
  geom_line(aes(color = country), show.legend = FALSE) +
  geom_text(aes(x = location, label = country, hjust = hjust), show.legend = FALSE) +
  xlab("") +
  ylab("Life Expectancy") 


#Code: Bland-Altman plot

#library(ggrepel)
dat %>%
  mutate(year = paste0("life_expectancy_", year)) %>%
  select(country, year, life_expectancy) %>% spread(year, life_expectancy) %>%
  mutate(average = (life_expectancy_2015 + life_expectancy_2010)/2,
         difference = life_expectancy_2015 - life_expectancy_2010) %>%
  ggplot(aes(average, difference, label = country)) +
  geom_point() +
  geom_text_repel() +
  geom_abline(lty = 2) +
  xlab("Average of 2010 and 2015") +
  ylab("Difference between 2015 and 2010")



# 6. PLOTS FOR THREE VARIABLES: ENCODING A THIRD VARIABLE. 
# (*USING COLOR HUE AND SHAPE)
# CASE STUDY: VACCINES

#Code: Tile plot of measles rate by year and state

# import data and inspect
#library(tidyverse)
#library(dslabs)
library(RColorBrewer)
data(us_contagious_diseases)
str(us_contagious_diseases)

# assign dat to the per 10,000 rate of measles, removing Alaska and Hawaii and adjusting for weeks reporting
the_disease <- "Measles"
dat <- us_contagious_diseases %>%
  filter(!state %in% c("Hawaii", "Alaska") & disease == the_disease) %>%
  mutate(rate = count / population * 10000 * 52/weeks_reporting) %>%
  mutate(state = reorder(state, rate))

# plot disease rates per year in California
dat %>% filter(state == "California" & !is.na(rate)) %>%
  ggplot(aes(year, rate)) +
  geom_line() +
  ylab("Cases per 10,000") +
  geom_vline(xintercept=1963, col = "blue")

# tile plot of disease rate by state and year
dat %>% ggplot(aes(year, state, fill=rate)) +
  geom_tile(color = "grey50") +
  scale_x_continuous(expand = c(0,0)) +
  scale_fill_gradientn(colors = RColorBrewer::brewer.pal(9, "Reds"), trans = "sqrt") +
  geom_vline(xintercept = 1963, col = "blue") +
  theme_minimal() + theme(panel.grid = element_blank()) +
  ggtitle(the_disease) +
  ylab("") +
  xlab("")


#Code: Line plot of measles rate by year and state

# compute US average measles rate by year
avg <- us_contagious_diseases %>%
  filter(disease == the_disease) %>% group_by(year) %>%
  summarize(us_rate = sum(count, na.rm = TRUE)/sum(population, na.rm = TRUE)*10000)

# make line plot of measles rate by year by state
dat %>%
  filter(!is.na(rate)) %>%
  ggplot() +
  geom_line(aes(year, rate, group = state), color = "grey50", 
            show.legend = FALSE, alpha = 0.2, size = 1) +
  geom_line(mapping = aes(year, us_rate), data = avg, size = 1, col = "black") +
  scale_y_continuous(trans = "sqrt", breaks = c(5, 25, 125, 300)) +
  ggtitle("Cases per 10,000 by state") +
  xlab("") +
  ylab("") +
  geom_text(data = data.frame(x = 1955, y = 50),
            mapping = aes(x, y, label = "US average"), color = "black") +
  geom_vline(xintercept = 1963, col = "blue")





