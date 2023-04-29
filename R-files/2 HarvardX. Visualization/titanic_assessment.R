## Titanic Survival Exercises. 
## Classic Machine Learning (ML) DataSet.

# 2020.10.30

# Background:
# The Titanic was a British ocean liner that struck an iceberg 
# and sunk on its maiden voyage in 1912 from the United Kingdom 
# to New York. More than 1,500 of the estimated 2,224 passengers 
# and crew died in the accident, making this one of the largest 
# maritime disasters ever outside of war. The ship carried a wide 
# range of passengers of all ages and both genders, from luxury 
# travelers in first-class to immigrants in the lower classes. 
# However, not all passengers were equally likely to survive the 
# accident. We use real data about a selection of 891 passengers 
# to learn who was on the Titanic and which passengers were more 
# likely to survive.


## Define the titanic dataset starting from the titanic library with 
## the following code:

options(digits = 3) # report 3 significant digits
library(tidyverse)
library(dplyr)
library(ggplot2)
library(titanic)

titanic <- titanic_train %>%
  select(Survived, Pclass, Sex, Age, SibSp, Parch, Fare) %>%
  mutate(Survived = factor(Survived),
         Pclass = factor(Pclass),
         Sex = factor(Sex))


## QUESTION 1: VARIABLE TYPES
# Inspect the data and also use ?titanic_train to learn more about 
# the variables in the dataset. Match these variables from the dataset 
# to their variable type. There is at least one variable of each type 
# (ordinal categorical, non-ordinal categorical, continuous, discrete)..

# No hay graficas que generar




## QUESTION 2: DEMOGRAPHICS OF TITANIC PASSANGERS.
# Make density plots of age grouped by sex. Try experimenting with 
# combinations of faceting, alpha blending, stacking and using variable 
# counts on the y-axis to answer the following questions. Some questions 
# may be easier to answer with different versions of the density plot.

# Graficos de DISTRIBUCION DE DENSIDAD PROBABILIDAD para observar 
# si existe más de un comportamiento modal.

titanic %>% 
  group_by(Sex) %>% 
  ggplot(aes(Age, fill = Sex)) +  # "y = ..count..," para saber la cantidad de hombres y mujeres.
  geom_density(alpha = 0.2, na.rm = TRUE, bw = 3) +
  xlab("Age") +
  ylab("Densidad") +
  ggtitle("Distribucion de densidad de edades por sexo")

# Graficos de HISTOGRAMAS para poder observar el numero de 
# pasajeros por edad por sexo.

p1 <- titanic %>%
  filter(Sex == "female") %>%
  ggplot(aes(Age)) +
  geom_histogram(binwidth = 5, 
                 color = "black", 
                 fill = "blue",
                 na.rm = TRUE) +
  scale_x_continuous(limits = c(0, 80)) + 
  scale_y_continuous(limits = c(0, 80)) +
  xlab("Edad") +
  ylab("No. de personas (frecuencia)") +
  ggtitle("Histograma de frecuencia de edades en mujeres.")

p2 <- titanic %>%
  filter(Sex == "male") %>%
  ggplot(aes(Age)) +
  geom_histogram(binwidth = 5, 
                 color = "black", 
                 fill = "blue", 
                 na.rm = TRUE) +
  scale_x_continuous(limits = c(0, 80)) + 
  scale_y_continuous(limits = c(0, 80)) +
  xlab("Edad") +
  ylab("No. de personas (frecuencia)") +
  ggtitle("Histograma de frecuencia de edades en hombres")

grid.arrange(p1, p2, ncol = 1)



## QUESTION 3: QQ-PLOT OF AGE DISTRIBUTION.
# Use geom_qq() to make a QQ-plot of passenger age and add an 
# identity line with geom_abline(). Filter out any individuals 
# with an age of NA first. Use the following object as the dparams 
# argument in geom_qq():

params <- titanic %>%
  filter(!is.na(Age)) %>%
  summarize(mean = mean(Age), sd = sd(Age))

# 1.
titanic %>% 
  ggplot(aes(sample = Age)) +
  geom_qq(dparams = params) +
  geom_abline(lty = 1, size = 1 ,col = 2)

# 2.
titanic %>% 
  ggplot(aes(sample = scale(Age))) +
  geom_qq() +
  geom_abline(lty = 1, size = 1 ,col = 2)


## QUESTION 4: SURVIVAL BY SEX
# To answer the following questions, make barplots of the Survived 
# and Sex variables using geom_bar(). Try plotting one variable and 
# filling by the other variable. You may want to try the default plot, 
# then try adding position = position_dodge() to geom_bar() to make 
# separate bars for each group.

# Haciendo GRAFICOS DE BARRA.

# 1. Posición esquiva ("dodge")
titanic %>% 
  ggplot(aes(Survived, fill = Sex)) +
  geom_bar(position = position_dodge(), 
           width = 0.5) +             
  scale_y_continuous(limits = c(0, 600)) +
  geom_text(stat = "count", 
            aes(label = stat(count)), 
                position = position_dodge(width = 1),
                vjust = -0.5) +
  theme_classic()


# 2. Posicion apilada ("stack")
titanic %>% 
  ggplot(aes(Survived, fill = Sex)) +
  geom_bar(position = position_stack(), 
           width = 0.5) +               
  scale_y_continuous(limits = c(0, 600)) +
  geom_text(stat = "count", 
            aes(label = stat(count)), 
            position = position_stack(),
            vjust = -0.5) +
  theme_classic()



## QUESTION 5: SURIVIVAL BY AGE
# Make a density plot of age filled by survival status. 
# Change the y-axis to count and set alpha = 0.2.
# Which age group is the only group more likely to survive than die?

# Generando grafico de densidad de edades con supervivencia.

titanic %>%
  filter(!is.na(Age)) %>%
  ggplot(aes(Age, y = ..count.., fill = Survived)) +
  geom_density(alpha = 0.2, bw = 3) +   # "bw = 4" obtiene el mismo resultado que la configuracion predeterminada.
  xlab("Age") +
  ylab("Count") +
  ggtitle("Distribution of Survival by Age") +
  theme_bw()



## QUESTION 6: SURVIVAL BY FARE
# Filter the data to remove individuals who paid a fare of 0. 
# Make a boxplot of fare grouped by survival status. 
# Try a log2 transformation of fares. 
# Add the data points with jitter and alpha blending.


# b <- a != 0   # length(b) = 891
# a <- a[b]     # length(a) = 876

titanic_woFare <- titanic %>% filter(Fare != 0)

# Primera grafica (exploratoria): Histogramas
# En estos histogramas se grafica solo la tarifa("Fare) de los pasajeros
# sin importar cualquier otra caracteristica (sexo, sobrevivencia, etc.)

titanic_woFare %>% ggplot(aes(Fare)) + geom_histogram()


# Probamos un ancho de celda diferente para ver si podemos observar otras
# caracteristicas en los datos.
p1 <- titanic_woFare %>% 
  ggplot(aes(Fare)) + 
  geom_histogram(binwidth = 1, color = "black", fill = "blue") +  # "binwidth = 15"
  xlab("Fare") +
  ylab("") +
  ggtitle("Histogram of Fare by Passengers. binw = 1")


# Se usa escala logaritmica en el eje 'x'
p1 <- titanic_woFare %>%     # lo mismo con "p2"
  ggplot(aes(Fare)) + 
  geom_histogram(binwidth = 1, color = "black", fill = "red") +   # "binwidth = 0.5"
  scale_x_continuous(trans = "log2") +
  xlab("Fare (log2)") +
  ylab("") +
  ggtitle("Histogram of Fare by Passengers. binw = 1")

  
# Grafiquemos ahora la tarifa tomando en cuenta la sobrevivencia de los pasajeros.

p1 <- titanic_woFare %>% 
  filter(Survived == 0) %>%
  ggplot(aes(Fare)) +
  geom_histogram(binwidth = 1, 
                 color = "black", 
                 fill = "red") +
  scale_x_continuous(trans = "log2", 
                     breaks = c(0, 8, 32, 128, 512)) +
  scale_y_continuous(limits = c(0, 300)) +
  xlab("Fare (log2)") +
  ylab("") +
  ggtitle("Histogram of Fare by Passengers Don't Survived")


p2 <- titanic_woFare %>% 
  filter(Survived == 1) %>%
  ggplot(aes(Fare)) +
  geom_histogram(binwidth = 1, color = "black", fill = "blue") +
  scale_x_continuous(trans = "log2", breaks = c(0, 8, 32, 128, 512)) +
  scale_y_continuous(limits = c(0, 300)) +
  xlab("Fare (log2)") +
  ylab("") +
  ggtitle("Histogram of Fare by Passengers Survived")
  
  
grid.arrange(p1, p2, nrow = 2)

  
# Segunda grafica: Boxplot
  
titanic_woFare %>%
  ggplot(aes(Survived, Fare, fill = Survived)) +
  geom_boxplot(coef = 3, width = 0.5) + 
  geom_jitter(alpha = 0.25, width = 0.1) +
  scale_y_continuous(trans = "log2") +
  xlab("Survived") +
  ylab("Fare (log2)") +
  ggtitle("Passenger Fare grouped by Survived")

  
  
## QUESTION 7: SURVIVAL BY PASSENGER CLASS

# The Pclass variable corresponds to the passenger class. Make three barplots. 
# For the first, make a basic barplot of passenger class filled by survival. 
# For the second, make the same barplot but use the argument position = position_fill() 
# to show relative proportions in each group instead of counts. 
# For the third, make a barplot of survival filled by passenger class using position = position_fill().

# You can read more about making barplots in the textbook section on ggplot2 geometries
# (https://rafalab.github.io/dsbook/distributions.html#other-geometries).


# Primer grafico de barras(barplot) exploratorio
titanic %>% 
  ggplot(aes(Pclass)) + 
  geom_bar(aes(fill = Pclass), color = "black") +
  theme_classic()

# 1. Basic barplot of passenger class filled by survival.
  
p <- titanic %>% 
  ggplot(aes(Pclass)) + 
  geom_bar(aes(fill = Survived), color = "black", width = 0.5) +
  xlab("Passenger Class") +
  ylab("Count") +
  ggtitle("No. of passengers survived by class") + 
  theme_economist() +
  theme(plot.title.position = "plot", 
        plot.title = element_text(color = "red",
                                  face = "bold",
                                  size = 13, 
                                  hjust = 0.5)) +
  theme(legend.position = "bottom",
        legend.title = element_text(color = "blue", 
                                    size = rel(0.95)), 
        legend.text = element_text(color = "purple", 
                                   size = 8, 
                                   face = "bold")) 
  

p + theme(plot.title = element_text(color = "red",
                                    face = "bold",
                                    size = 15, 
                                    hjust = 0.5))
  # legend.*()
            
          
# 2. Make the same barplot but use the argument position = position_fill() 
# to show relative proportions in each group instead of counts. 

p <- titanic %>% 
  ggplot(aes(Pclass)) + 
  geom_bar(aes(fill = Survived), 
           position = position_fill(),
           color = "black", 
           width = 0.5) +
  xlab("Passenger Class") +
  ylab("") +
  ggtitle("Proportion of passengers survived by class") + 
  theme_economist_white()

p + theme(plot.title = element_text(color = "black",
                                    face = "bold",
                                    size = 15, 
                                    hjust = 0.5))  


# 3. Make a barplot of survival filled by passenger class using 
# position = position_fill().

p <- titanic %>% 
  ggplot(aes(Survived)) + 
  geom_bar(aes(fill = Pclass), 
           position = position_fill(reverse = TRUE),
           color = "black", 
           width = 0.3) +
  xlab("Survived") +
  ylab("") +
  ggtitle("No. of passengers class by survived") + 
  theme_economist_white()

p + theme(plot.title = element_text(color = "black",
                                    face = "bold",
                                    size = 14, 
                                    hjust = 0.5)) 






## QUESTION 8: SURVIVAL BY AGE, SEX AND PASSENGER CLASS

# Create a grid of density plots for age, filled by survival status, 
# with count on the y-axis, faceted by sex and passenger class.


# 1.

p <- titanic %>%
  ggplot(aes(Age, y = ..count.., fill = Survived)) +
  geom_density(alpha = 0.2, na.rm = TRUE) +   # bw=3 muestra un comportamiento similar, bw=10 'suaviza' la distribucion. 
  xlab("Age") +
  ylab("Count") +
  ggtitle("Counts in Age of the Survived, 
          relative to Passenger Class and Sex.") +
  facet_grid(Sex ~ Pclass)

p + theme(plot.title = element_text(color = "black", 
                                    hjust = 0.5))
p + theme_minimal()
  
# p + scale_color_brewer(palette = "Accent") 



# 2.

p <- titanic %>%
  ggplot(aes(Age, fill = Survived)) +
  geom_density(aes(y = stat(count)), 
               position = "stack", 
               bw = 3,
               alpha = 0.2, 
               na.rm = TRUE) +
  xlab("Age") +
  ylab("Count") +
  ggtitle("Counts in Age of the Survived, 
          relative to Passenger Class and Sex.") +
  facet_grid(Sex ~ Pclass)

p + theme(plot.title = element_text(color = "black", 
                                    hjust = 0.5))




# Voy a generar una grafica de barras para discernir 
# si la distribucion (¿se puede hablar de distribucion
# en una grafica de barras?) de genero es la misma en 
#todas las clases de pasajeros.


p <- titanic %>%
  ggplot(aes(Pclass, fill = Sex)) +
  geom_bar(width = 0.5, 
           color = "black", 
           position = position_fill()) +
  xlab("Passenger class") +
  ylab("") +
  ggtitle("Proporcion del Sexo de los pasajeros por Clase") +
  theme_economist_white()
  
p + theme(plot.title = element_text(color = "black",
                                    size = 14, 
                                    hjust = 0.5))  














