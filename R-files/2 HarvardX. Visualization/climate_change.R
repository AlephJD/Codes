## BACKGROUND

# The planet's surface temperature is increasing as greenhouse gas emissions 
# increase, and this global warming and carbon cycle disruption is wreaking 
# havoc on natural systems. Living systems that depend on current temperature, 
# weather, currents and carbon balance are jeopardized, and human society will
# be forced to contend with widespread economic, social, political and 
# environmental damage as the temperature continues to rise. In these exercises,
# we examine the relationship between global temperature changes, greenhouse 
# gases and human carbon emissions using time series of actual atmospheric 
# and ice core measurements from the National Oceanic and Atmospheric Administration 
# (NOAA) and Carbon Dioxide Information Analysis Center (CDIAC).


# 2020.11.20


## MEJORAS

# 1. TEMP_CARBON:
# line 50: Manipular los valores del vector para que sea una línea de tiempo continua.
# line 118(start): Generar graficas de correlacion entre las variables de la base de datos temp_carbon.
# 2. GREENHOUSE_GASES:
# line: Generar las graficas de correlaciones entre las concentraciones.
# line 564, Question 8: Agregar tick marks en el eje 'x' al primer y segundo grafico, e.g.: annotation_tick() 
# 3. HISTORIC_CO2:
# line: Generar las graficas de correlaciones entre las concentraciones del Mauna Loa y los nucleos de hielo.
# line 271: # 1.2 Ice Cores and Mauna Loa data in two graphs one figure using 'facet_grid'.

## Libraries and Data Import
library(tidyverse)
library(gridExtra)
library(ggthemes)
library(Rcpp)
library(Amelia)
library(GGally)
library(dslabs)
data(temp_carbon)
data(greenhouse_gases)
data(historic_co2)
options(digits = 3)


## EXPLORATORY

# 1. TEMP_CARBON

# let's check that time vector doesn't have gaps.
years <- temp_carbon$year
y <- integer(length(temp_carbon$year))
plot(years, y, "l")


sequence <- seq(1,268)
plot(sequence, years, 'l')   # rearrange time vector

# > temp_carbon$year[140]
#   [1] 1751


# NA's. Verificar que no haya datos perdidos
sum(is.na(temp_carbon))        # [1] 391, datos perdidos.
temp_carbon %>%  missmap(col = c("black", "grey"))


# Revisando la correlacion entre variables
ggcorr(temp_carbon,
       nbreaks = 6,
       label = TRUE,
       label_size = 3,
       color = "grey50")


# Graphs of Global, Land and Ocean Temperatures Anomalies
Global <- temp_carbon$temp_anomaly
Land <- temp_carbon$land_anomaly
Ocean <- temp_carbon$ocean_anomaly

df <- data.frame(years, 
                 Global, 
                 Land, 
                 Ocean)

dfplot <- df %>% gather(key, value, -years)

ggplot(dfplot, mapping = aes(x = years, 
                             y = value, 
                             color = key)) + 
  geom_line(na.rm = TRUE) +
  geom_hline(yintercept = 0) +
  geom_vline(xintercept = 1938, linetype = "twodash") +
  scale_x_continuous(limits = c(1870, 2020),
                     breaks = c(1875, 1900, 1950, 2000, 2020)) +
  scale_color_discrete(name = "Anomalies") +
  xlab("Years") +
  ylab("Temperature [ºC]") +
  ggtitle("Annual Global, Land and Ocean Temperatures Anomalies") +
  theme(plot.title = element_text(hjust = 0.5))


# Graph for Annual Carbon Emissions
yline <- temp_carbon$carbon_emissions[temp_carbon$year == 1938]

temp_carbon %>% 
  ggplot(aes(year, carbon_emissions)) + 
  geom_line(na.rm = TRUE, 
            color = "blue", 
            linetype = "twodash") +
  geom_hline(yintercept = 0) + 
  geom_hline(yintercept = yline, 
             color = "green", 
             linetype = "twodash") +
  geom_vline(xintercept = 1850, linetype = "solid") +
  geom_vline(xintercept = 1938, linetype = "twodash") +
  scale_y_log10(breaks = c(0, 10, 100, 1000, yline, 2500, 5000, 10000)) +
  scale_x_continuous(breaks = c(1800, 1850, 1900, 1938, 2000)) +
  #scale_y_continuous(breaks = c(0, yline, 2500, 5000, 7500, 10000)) +
  xlab("Year") + 
  ylab("C6 Emission [metric tons/year]") +
  ggtitle("Annual Carbon Emissions") + 
  theme_bw()





# 2. GREENHOUSE_GASES

# let's check that time vector doesn't have gaps.
# In the time vector (year) exists three time line for each gas. First we run
# a code for all the vector. If it would be something wrong we would run for 
# each gas
years <- greenhouse_gases$year    # [greenhouse_gases$gas == "CO2"], se agrega; se escoje cualquiera de los gases
y <- integer(length(greenhouse_gases$year))     # hago un vector de 0's; "/100" se agrega al final para cada gas
plot(years, y, "l")


# NA's. Verificar que no haya datos perdidos
sum(is.na(greenhouse_gases))        # [1] 0, no hay datos perdidos.
greenhouse_gases %>%  missmap(col = c("black", "grey"))


# Revisando la correlacion entre variables

df <- greenhouse_gases %>%
  spread(gas, concentration)
  
ggcorr(df,
       nbreaks = 4,
       label = TRUE,
       label_size = 3,
       color = "grey50")



# Graphs of Concentration of Greenhouse Gases

# All
# 1.1
greenhouse_gases %>% 
  mutate(gas = factor(gas)) %>%
  group_by(gas) %>% 
  ggplot(aes(year, concentration, color = gas)) + 
  geom_line() +
  scale_y_continuous(trans = "log10",
                     breaks = c(0, 200, 300, 400, 500, 600, 1000, 1500, 1800)) +
  scale_color_discrete(name = "Gases") +
  xlab("Year") +
  ylab("Concentration 
       (CO2[ppm]; CH4,NO2[ppb])") +
  ggtitle("Global Gas Concentration over 2000 years.")
  

# Each
# 1.2.1 CO2 & N2O
average <- greenhouse_gases %>%
  filter(year %in% seq(0, 1840, 20)) %>%      # 1850 unofficial year it begins the industrial revolution
  summarize(CH4 = mean(concentration[gas == "CH4"]),
            CO2 = mean(concentration[gas == "CO2"]), 
            N2O = mean(concentration[gas == "N2O"]))

greenhouse_gases %>% 
  filter(gas %in% c("CO2", "N2O")) %>%
  mutate(gas = factor(gas)) %>%
  group_by(gas) %>%
  ggplot(aes(year, concentration, color = gas)) + 
  geom_line() +
  geom_hline(yintercept = average$CO2, linetype = "dashed") +
  geom_hline(yintercept = average$N2O, linetype = "dotted") +
  scale_y_continuous(limits = c(250, 375), 
                     breaks = c(250, 267, 279, 300, 325, 350, 375)) +
  scale_color_discrete(name = "Gases") +
  xlab("Year") +
  ylab("Concentration 
       CO2[ppm], N2O[ppb]") +
  ggtitle("Global Gas Concentration of CO2 and N2O over 2000 years.") +
  theme(plot.title = element_text(hjust = 0.5)) +
  geom_text(x = 500, y = 282, 
           label = "CO2 average", colour = "blue", size = 3,
           show.legend = FALSE) +
  geom_text(x = 500, y = 270, 
            label = "N2O average", colour = "blue", size = 3,
            show.legend = FALSE)



# 1.2.2 CH4
greenhouse_gases %>% 
  filter(gas == c("CH4")) %>%
  ggplot(aes(year, concentration)) + 
  geom_line(color = "") +
  geom_hline(yintercept = average$CH4, linetype = "dashed") +
  scale_y_continuous(limits = c(600, 1710), 
                     breaks = c(600, 662, 750, 1000, 1250, 1500, 1750)) +
  xlab("Year") +
  ylab("Concentration CH4[ppb]") +
  ggtitle("Global Gas Concentration of CH4 over 2000 years.") +
  theme(plot.title = element_text(hjust = 0.5)) +
  geom_text(x = 500, y = 690, 
            label = "CH4 average", colour = "red", size = 3.5,
            show.legend = FALSE) +
  theme_bw()





# 3. HISTORIC_CO2

# let's check that time vector doesn't have gaps.
years <- historic_co2$year/1000            # el tiempo esta en miles de años.
y <- integer(length(historic_co2$year))
plot(years, y, "l")


sequence <- seq(1, 694)
plot(sequence, years, 'l')   


# NA's. Verificar que no haya datos perdidos
sum(is.na(historic_co2))        # [1] 0, datos perdidos.
historic_co2 %>%  missmap(col = c("black", "grey"))


# Revisando la correlacion entre variables

df <- historic_co2 %>% 
  spread(source, co2)

ggcorr(df,
       nbreaks = 3,
       label = TRUE,
       label_size = 3,
       color = "grey50")



# Graphs of Concentration of Historic CO2.

# 1.1 Ice Cores and Mauna Loa data in one graph one figure.
historic_co2 %>%
  mutate(source = factor(source)) %>%
  group_by(source) %>%
  ggplot(aes(year/1000, co2, color = source)) +
  geom_line() +
  scale_color_discrete(name = "Source") +
  xlab("Year (10^3)") +
  ylab("CO2[ppm]") +
  ggtitle("Historic CO2 record from > 800,000 years")
  

# 1.2 Ice Cores and Mauna Loa data in two graphs one figure ('facet_grid').
# (esta fallando, no grafica diferentes ejes de tiempo, componerlo)
historic_co2 %>%
  mutate(source = factor(source)) %>%
  group_by(source) %>%
  ggplot(aes(year, co2)) +
  geom_line() +
  facet_grid(source ~ ., scales = "free")


# 1.3 Ice Cores and Mauna Loa data in two graphs one figure ('grid.arrange').
avg_ic <- historic_co2 %>%
  filter(year < 1850 & source == "Ice Cores") %>%
  summarize(CO2 = mean(co2))

avg_ml <- historic_co2 %>%
  filter(year >= 1850 & source == "Mauna Loa") %>%
  summarize(CO2 = mean(co2))

p1 <- historic_co2 %>%
  filter(source == "Ice Cores") %>%
  ggplot(aes(year/1000, co2)) +
  geom_line(color = "blue") +
  geom_hline(yintercept = avg_ic$CO2) +
  geom_hline(yintercept = 368, linetype = "longdash") +     # 368 ppm, max of CO2 Ice Cores
  geom_vline(xintercept = 1850/10^3, linetype = "dashed") +
  geom_vline(xintercept = 1959/10^3, linetype = "longdash") +
  scale_y_continuous(breaks = c(200, avg_ic$CO2, 250, 300, 350, 368)) +
  xlab("Year*(10^3)") +
  ylab("Ice Cores CO2[ppm]") +
  ggtitle("Historic CO2 record > 800,000 from Ice Cores")

p2 <- historic_co2 %>%
  filter(source == "Mauna Loa") %>%
  ggplot(aes(year, co2)) +
  geom_line(color = "red") +
  geom_point() +
  geom_hline(yintercept = avg_ml$CO2) +
  geom_hline(yintercept = 368, linetype = "longdash") +
  xlab("Year") +
  ylab("Mauna Loa CO2[ppm]") +
  ggtitle("Historic CO2 record from Mauna Loa") +
  geom_text(x = 1970, y = 360, 
            label = "CO2[ppm] = 354", 
            color = "blue",
            size = 3.5)

grid.arrange(p1, p2, nrow = 2)



# 1.4.1 Ice Cores and Grenhouse CO2 data base comparison (one graph).

df_ic <- data.frame(year = historic_co2$year[historic_co2$year > 0 & historic_co2$source == "Ice Cores"], 
                  CO2 = historic_co2$co2[historic_co2$year > 0 & historic_co2$source == "Ice Cores"])

df_gh <- data.frame(year = greenhouse_gases$year[greenhouse_gases$gas == "CO2"], 
                    CO2 = greenhouse_gases$concentration[greenhouse_gases$gas == "CO2"])


df <- rbind(df_ic, df_gh)

df$dataset <- c(rep("IC", nrow(df_ic)), rep("GH", nrow(df_gh)))

avg <- (mean(df_ic$CO2[df_ic$year < 1850]) + 
          mean(df_gh$CO2[df_gh$year < 1850]))/2

ggplot(data = df, aes(year, CO2, col = dataset)) + 
  geom_line() + 
  geom_point() +
  geom_hline(yintercept = avg) +
  geom_vline(xintercept = 1850, linetype = "dashed") +
  geom_vline(xintercept = 1938, linetype = "dashed") +
  scale_x_continuous(breaks = c(0, 500, 1000, 1500, 1850, 2000)) +
  xlab("Year") +
  ylab("CO2[ppm]") +
  scale_color_discrete(name = "Source") +
  ggtitle("Comparison between CO2 from Greenhouse gases(GH) and Ice Cores(IC)")



# 1.4.2 (two graph)

p <- historic_co2 %>%        
  filter(year > 0 & source == "Ice Cores") %>%
  ggplot(aes(year, co2)) +            # length 85
  geom_line() +
  geom_point() +
  geom_vline(xintercept = 1850, linetype = "dashed") +
  geom_vline(xintercept = 1938, linetype = "dashed") +
  ylab("Ice Cores CO2")

q <- greenhouse_gases %>%     
  filter(gas == "CO2") %>% 
  ggplot(aes(year, concentration)) +  # length 100
  geom_line() + 
  geom_point() +
  geom_vline(xintercept = 1850, linetype = "dashed") +
  geom_vline(xintercept = 1938, linetype = "dashed") +
  ylab("Greenhouse CO2")


grid.arrange(p, q, nrow = 2)


# 1.5 Ice Cores and Mauna Loa data from 1959.

p1 <- historic_co2 %>%
  filter(year >= 1959) %>%
  ggplot(aes(year, co2, color = source)) +
  geom_line() +
  geom_point() +
  #geom_vline(xintercept = 1850, linetype = "dashed") +
  geom_vline(xintercept = 1959, linetype = "dashed") +
  xlab("Year") +
  ylab("CO2[ppm]") +
  ggtitle("CO2 from Ice Cores and Mauna Loa")
  




## QUESTION 1

# Load the temp_carbon dataset from dslabs, which contains annual global 
# temperature anomalies (difference from 20th century mean temperature in 
# degrees Celsius), temperature anomalies over the land and ocean, and global
# carbon emissions (in metric tons). Note that the date ranges differ for 
# temperature and carbon emissions.

# Which of these code blocks return the latest year for which carbon emissions
# are reported?

# Select ALL correct answers.

# a)
          temp_carbon %>%
    .$year %>%
    max()
        
# b) (correcto)
          temp_carbon %>%
    filter(!is.na(carbon_emissions)) %>%
    pull(year) %>%
    max()
        
# c)
          temp_carbon %>%
    filter(!is.na(carbon_emissions)) %>%
    max(year)
        
# d) (correcto)
          temp_carbon %>%
    filter(!is.na(carbon_emissions)) %>%
    .$year %>%
    max()
        
# e) (correcto)
          temp_carbon %>%
    filter(!is.na(carbon_emissions)) %>%
    select(year) %>%
    max()
        
# f)
          temp_carbon %>%
    filter(!is.na(carbon_emissions)) %>%
    max(.$year)





# QUESTION 2
        
# Inspect the difference in carbon emissions in temp_carbon from the first
# available year to the last available year.

carb_em <- temp_carbon %>% 
  filter(!is.na(carbon_emissions)) %>%
  select(year, carbon_emissions)


# What is the first year for which carbon emissions (carbon_emissions) data
# are available?
ymin <- min(carb_em$year)

# R = 1751 (correcto)


# What is the last year for which carbon emissions data are available?
ymax <- max(carb_em$year)

# R = 2014 (correcto)


# How many times larger were carbon emissions in the last year relative to
# the first year?
carb_em$carbon_emissions[carb_em$year == ymax] / 
  carb_em$carbon_emissions[carb_em$year == ymin]

# R = 3285 (correcto)





## QUESTION 3

# Inspect the difference in temperature in temp_carbon from the first 
# available year to the last available year.

temp_carbon %>% 
  filter(!is.na(temp_anomaly)) %>%
  ggplot(aes(year, temp_anomaly)) +
  geom_line(color = "brown", linetype = "twodash") +
  geom_hline(yintercept = 0) +
  xlab("Year") +
  ylab("Temperature [ºC]") +
  ggtitle("Annual Global Temperature Anomaly")


t_anom <- temp_carbon %>%
  filter(!is.na(temp_anomaly)) %>%
  select(year, temp_anomaly)


# What is the first year for which global temperature anomaly (temp_anomaly)
# data are available?
ymin <- min(t_anom$year)
# R = 1880 (correcto)
  
# What is the last year for which global temperature anomaly data are 
# available?   
ymax <- max(t_anom$year)
# R = 2018 (correcto)

# How many degrees Celsius has temperature increased over the date range? 
# Compare the temperatures in the most recent year versus the oldest year.
t_anom$temp_anomaly[t_anom$year == ymax] - 
  t_anom$temp_anomaly[t_anom$year == ymin]     #0.82 - (-0.11) = 0.93

# R = 0.93 (correcto)





## QUESTION 4

# Create a time series line plot of the temperature anomaly. Only include 
# years where temperatures are reported. Save this plot to the object p.

p <- temp_carbon %>% 
  filter(!is.na(temp_anomaly)) %>%
  ggplot(aes(year, temp_anomaly)) +
  geom_line(color = "brown", linetype = "twodash") +
  xlab("Year") +
  ylab("Temperature [ºC]") +
  ggtitle("Annual Global Temperature Anomaly")

p <- p + geom_hline(aes(yintercept = 0), col = "blue")
p

# Which command adds a blue horizontal line indicating the 20th century mean
# temperature?
  
# a) p <- p + geom_vline(aes(xintercept = 0), col = "blue")


# b) p <- p + geom_hline(aes(y = 0), col = "blue")


# c) p <- p + geom_hline(aes(yintercept = 0, col = blue))


# d) p <- p + geom_hline(aes(yintercept = 0), col = "blue") (correcto)





## QUESTION 5

# Continue working with p, the plot created in the previous question.
# Change the y-axis label to be "Temperature anomaly (degrees C)". Add a 
# title, "Temperature anomaly relative to 20th century mean, 1880-2018". 
# Also add a text layer to the plot: the x-coordinate should be 2000, the 
# y-coordinate should be 0.05, the text should be "20th century mean", and 
# the text color should be blue.

p <- temp_carbon %>% 
  filter(!is.na(temp_anomaly)) %>%
  ggplot(aes(year, temp_anomaly)) +
  geom_line(color = "brown", linetype = "twodash") +
  xlab("Year")

p <- p + geom_hline(aes(yintercept = 0), col = "blue")

p + ylab("Temperature anomaly [ºC]") +
  ggtitle("Annual Global Temperature Anomaly relative to
          20th century mean, 1880-2018.") +
  geom_text(aes(x = 2000, y = 0.5, 
                label = "20th century mean"),
            col = "blue",
            hjust = 1)



# Which of the following code blocks is correct?

# a)  
  p + ylab("Temperature anomaly (degrees C)") +
  title("Temperature anomaly relative to 20th century mean, 1880-2018") +
  geom_text(aes(x = 2000, y = 0.05, label = "20th century mean", col = "blue"))

# b)
p + ylim("Temperature anomaly (degrees C)") +
  ggtitle("Temperature anomaly relative to 20th century mean, 1880-2018") +
  geom_text(aes(x = 2000, y = 0.05, label = "20th century mean"), col = "blue")

# c)
p + ylab("Temperature anomaly (degrees C)") +
  ggtitle("Temperature anomaly relative to 20th century mean, 1880-2018") +
  geom_text(aes(x = 2000, y = 0.05, label = "20th century mean", col = "blue"))

# d) (correcto)
p + ylab("Temperature anomaly (degrees C)") +
  ggtitle("Temperature anomaly relative to 20th century mean, 1880-2018") +
  geom_text(aes(x = 2000, y = 0.05, label = "20th century mean"), col = "blue")

# e)
p + ylab("Temperature anomaly (degrees C)") +
  title("Temperature anomaly relative to 20th century mean, 1880-2018") +
  geom_text(aes(x = 2000, y = 0.05, label = "20th century mean"), col = "blue")





## QUESTION 6

# Use the plot created in the last two exercises to answer the following 
# questions. Answers within 5 years of the correct answer will be accepted.


# When was the earliest year with a temperature above the 20th century mean?

# R = 1939 (correcto)

# When was the last year with an average temperature below the 20th century mean?

# R = 1976 (correcto)

# In what year did the temperature anomaly exceed 0.5 degrees Celsius for the first time?

# R = 1997 (correcto)





## QUESTION 7

# Add layers to the previous plot to include line graphs of the temperature 
# anomaly in the ocean (ocean_anomaly) and on land (land_anomaly). Assign 
# different colors to the lines. Compare the global temperature anomaly to 
# the land temperature anomaly and ocean temperature anomaly.


p <- temp_carbon %>% 
  filter(!is.na(temp_anomaly)) %>%
  ggplot() +
  geom_line(aes(year, temp_anomaly),
            color = "red", linetype = "twodash") +
  geom_line(aes(year, land_anomaly), 
            color =  "green", linetype = "solid") +
  geom_line(aes(year, ocean_anomaly), 
            color = "blue", linetype = "longdash") +
  xlab("Year") +
  ylab("Temperature anomaly [ºC]") +
  ggtitle("Annual Global Temperature Anomaly relative to
          20th century mean, 1880-2018.") +
  geom_text(aes(x = 2000, y = 0.5, label = "20th century mean"),
            col = "blue", hjust = 1)

p + geom_hline(aes(yintercept = 0), col = "blue")

  

# Which region has the largest 2018 temperature anomaly relative to the 
# 20th century mean?

# R = Land (correcto)

# Which region has the largest change in temperature since 1880?

# R = Land (correcto)

# Which region has a temperature anomaly pattern that more closely matches the global pattern?

# R = Ocean (correcto)



###########################################################################
###########################################################################
###########################################################################



## QUESTION 8

# A major determinant of Earth's temperature is the greenhouse effect. Many
# gases trap heat and reflect it towards the surface, preventing heat from 
# escaping the atmosphere. The greenhouse effect is vital in keeping Earth 
# at a warm enough temperature to sustain liquid water and life; however, 
# changes in greenhouse gas levels can alter the temperature balance of the
# planet.

# The greenhouse_gases data frame from dslabs contains concentrations of the
# three most significant greenhouse gases: carbon dioxide (CO2, abbreviated
# in the data as co2), methane (CH4, ch4 in the data), and nitrous oxide 
# (N2O, n2o in the data). Measurements are provided every 20 years for the 
# past 2000 years.

# Complete the code outline below to make a line plot of concentration on the
# y-axis by year on the x-axis. Facet by gas, aligning the plots vertically 
# so as to ease comparisons along the year axis. Add a vertical line with an 
# x-intercept at the year 1850, noting the unofficial start of the industrial
# revolution and widespread fossil fuel consumption. Note that the units for 
# ch4 and n2o are ppb while the units for co2 are ppm.


# Code    
greenhouse_gases %>%
    ggplot(aes(__________)) +                  # (year, concentration) (correcto)
    geom_line() +
    facet_grid(__________, scales = "free") +  # (gas ~ .) (correcto)
    __________ +                               # (geom_vline(xintercept = 1850)) (correcto)
    ylab("Concentration (ch4/n2o ppb, co2 ppm)") +
    ggtitle("Atmospheric greenhouse gas concentration by year, 0-2000")

  
# What code fills the first blank?

# What code fills the second blank? Make sure to align plots vertically.

# What code fills the third blank?

# 1. with "facet_grid()":
greenhouse_gases %>%
  ggplot(aes(year, concentration, color = gas)) + 
  geom_line() +
  facet_grid(gas ~ ., scales = "free") +
  geom_vline(xintercept = 1850) +
  scale_x_continuous(breaks = c(0, 500, 1000, 1500, 1850, 2000)) +
  scale_color_discrete(name = "Gas") +
  xlab("Year") +
  ylab("Concentration 
       CH4/N2O [ppb], CO2 [ppm]") +
  ggtitle("Atmospheric greenhouse gas concentration by year, 0 - 2000.") #+
  #geom_text(x = 1550, y = 325, 
  #          label = "year line = 1850", color = "#993300")


# 2. with "grid.arrange()":
p1 <- greenhouse_gases %>% 
  filter(gas == "CH4") %>%
  ggplot(aes(year, concentration)) +
  geom_line(color = "red") +
  geom_hline(yintercept = average$CH4, linetype = "dashed") +
  geom_vline(xintercept = 1850) +
  scale_x_continuous(breaks = c()) +
  scale_y_continuous(limits = c(550, 1720), 
                     breaks = c(550, 662, 900, 1200, 1500, 1800)) +
  ylab("CH4[ppb]") +
  xlab(label = NULL) +
  ggtitle("Atmospheric greenhouse gas concentration by year, 0 - 2000.")
  
p2 <- greenhouse_gases %>% 
    filter(gas == "CO2") %>%
    ggplot(aes(year, concentration)) +
    geom_line(color = "green") +
    geom_hline(yintercept = average$CO2, linetype = "dashed") +
    geom_vline(xintercept = 1850) +
    scale_x_continuous(breaks = c()) +
    scale_y_continuous(limits = c(270, 370),
                       breaks = c(270, 279, 300, 330, 360)) +
    ylab("CO2[ppm]") +
    xlab(label = NULL)
# theme(axis.text.y = element_text())
  
p3 <- greenhouse_gases %>% 
  filter(gas == "N2O") %>%
  ggplot(aes(year, concentration)) +
  geom_line(color = "blue") +
  geom_hline(yintercept = average$N2O, linetype = "dashed") +
  geom_vline(xintercept = 1850) +
  scale_x_continuous(breaks = c(0, 500, 1000, 1500, 1850, 2000)) +
  scale_y_continuous(limits = c(250, 320),
                     breaks = c(250, 267, 280, 300, 320)) +
  ylab("N2O[ppb]") +
  xlab("Year")
  
grid.arrange(p1, p2, p3, nrow = 3, ncol = 1)





## QUESTION 9

# Interpret the plot of greenhouse gases over time from the previous question.
# You will use each answer exactly once ch4, co2, n2o, all, none).

# Which gas was stable at approximately 275 ppm/ppb until around 1850?

# R = CO2 (correcto)

# Which gas more than doubled in concentration since 1850?

# R = CH4 (correcto)

# Which gas decreased in concentration since 1850?

# R = none (correcto)
 
# Which gas had the smallest magnitude change since 1850?

# R = N2O (correcto)

# Which gas increased exponentially in concentration after 1850?

# R = all (correcto)





## QUESTION 10

# While many aspects of climate are independent of human influence, and CO2 
# levels can change without human intervention, climate models cannot 
# reconstruct current conditions without incorporating the effect of manmade 
# carbon emissions. These emissions consist of greenhouse gases and are mainly
# the result of burning fossil fuels such as oil, coal and natural gas.

# Make a time series line plot of carbon emissions (carbon_emissions) from the
# temp_carbon dataset. The y-axis is metric tons of carbon emitted per year.

yline <- temp_carbon$carbon_emissions[temp_carbon$year == 1938]

temp_carbon %>% 
  ggplot(aes(year, carbon_emissions)) + 
  geom_line(na.rm = TRUE, 
            color = "blue", 
            linetype = "twodash") +
  geom_hline(yintercept = 0) + 
  geom_hline(yintercept = yline, 
             color = "green", 
             linetype = "twodash") +
  geom_vline(xintercept = 1850, linetype = "solid") + 
  geom_vline(xintercept = 1938, linetype = "twodash") +
  #scale_y_log10(breaks = c(0, 10, 100, 1000, yline, 2500, 5000, 10000)) +
  scale_x_continuous(breaks = c(1800, 1850, 1900, 1938, 2000)) +
  scale_y_continuous(breaks = c(0, yline, 2500, 5000, 7500, 10000)) +
  xlab("Year") + 
  ylab("C6 Emission [metric tons/year]") +
  ggtitle("Annual Carbon Emissions") + 
  theme_bw()


# Which of the following are true about the trend of carbon emissions?
# Check all correct answers.

# a) Carbon emissions were essentially zero before 1850 and have increased 
#    exponentially since then. (correcto)

# b) Carbon emissions are reaching a stable level.

# c) Carbon emissions have increased every year on record.

# d) Carbon emissions in 2014 were about 4 times as large as 1960 emissions. (correcto)

# e) Carbon emissions have doubled since the late 1970s. (correcto)

# f) Carbon emissions change with the same trend as atmospheric greenhouse
#    gas levels (co2, ch4, n2o). (correcto)





## QUESTION 11

# We saw how greenhouse gases have changed over the course of human history, 
# but how has CO2 (co2 in the data) varied over a longer time scale? The 
# historic_co2 data frame in dslabs contains direct measurements of atmospheric
# CO2 from Mauna Loa since 1959 as well as indirect measurements of atmospheric
# CO2 from ice cores dating back 800,000 years.

# Make a line plot of CO2 concentration over time (year), coloring by the 
# measurement source (source). Save this plot as co2_time for later use.

# Which of the following are true about co2_time, the time series of CO2 over 
# the last 800,000 years?
#Check all correct answers.


# a) Modern CO2 levels are higher than at any point in the last 800,000 years. (correcto)

# b) There are natural cycles of CO2 increase and decrease lasting 50,000-100,000
# years per cycle. (correcto)

# c) In most cases, it appears to take longer for co2 levels to decrease than to 
# increase. (correcto)

# d) CO2 concentration has been at least 200 ppm for the last 800,000 years. 





## QUESTION 12

# One way to differentiate natural co2 oscillations from today's manmade co2 
# spike is by examining the rate of change of co2. The planet is affected not 
# only by the absolute concentration of co2 but also by its rate of change. When
# the rate of change is slow, living and nonliving systems have time to adapt to
# new temperature and gas levels, but when the rate of change is fast, abrupt 
# differences can overwhelm natural systems. How does the pace of natural co2 
# change differ from the current rate of change?

# Use the co2_time plot saved above. Change the limits as directed to investigate
# the rate of change in co2 over various periods with spikes in co2 concentration.

# codigo base para cada ejercicio.
historic_co2 %>%
  mutate(source = factor(source)) %>%
  group_by(source) %>%
  ggplot(aes(year/1000, co2, color = source)) +
  geom_line() +
  scale_x_continuous(limits = c(-800, -775)) +
  scale_color_discrete(name = "Source") +
  xlab("Year (10^3)") +
  ylab("CO2[ppm]") +
  ggtitle("Historic CO2 record from > 800,000 years")

# Change the x-axis limits to -800,000 and -775,000. About how many years did it 
# take for co2 to rise from 200 ppmv to its peak near 275 ppmv?
# a) 100
# b) 3,000
# c) 6,000
# d) 10,000

# Change the x-axis limits to -375,000 and -330,000. About how many years did it
# take for co2 to rise from the minimum of 180 ppm to its peak of 300 ppmv?
# a) 3,000
# b) 6,000
# c) 12,000
# d) 25,000

# Change the x-axis limits to -140,000 and -120,000. About how many years did it
# take for co2 to rise from 200 ppmv to its peak near 280 ppmv?
# a) 200
# b) 1,500
# c) 5,000
# d) 9,000

# Change the x-axis limits to -3000 and 2018 to investigate modern changes in 
# co2. About how many years did it take for co2 to rise from its stable level 
# around 275 ppmv to the current level of over 400 ppmv?
# a) 250
# b) 1,000
# c) 2,000
# d) 5,000













