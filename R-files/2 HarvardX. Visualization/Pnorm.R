# Code: Using pnorm to calculate probabilities.
# Given male heights x:

library(tidyverse) ## Inicialmente esta es la libreria que recomiendan instalar, 
                   ## pero tengo problemas para correr la linea de codigo del operador "pipe" (%>%),
                   ## asi que decidi instalar la libreria "dplyr" que he observado no tiene problemas en la instalacion.
library(dplyr)
library(dslabs)
data(heights)
x <- heights %>% filter(sex == "Male") %>% pull(height)   ## x <- heights$height[heights$sex == "Male"]

# We can estimate the probability that a male is smaller than 70.5 inches with:
pnorm(70.5, mean(x), sd(x))
