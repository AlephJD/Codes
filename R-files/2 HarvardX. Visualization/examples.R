# Codigo no. 6 para ejemplos adicionales.

library(tidyverse)
library(dplyr)
library(ggplot2)
library(dslabs)

#data(murders)
data(heights)

# Haciendo un resumen de las herramientas de graficado.


# ocupamos unicamente las alturas de los hombres y definimos un objeto grafico
# p <- heights$height[heights$sex == "Male"]
# p <- heights %>% filter(sex == "Male")

p <-  heights %>% filter(sex == "Male") %>% ggplot(aes(x = height)) # define el objeto grafico 'p', filtra las alturas de los hombres y especifica que es con las alturas con que se va a trabajar graficamente.

## HISTOGRAMA
p + geom_histogram()                  # dibuja la grafica
p + geom_histogram(binwidth = 1)      # define el ancho de la barra

p + geom_histogram(binwidth = 1, fill = "blue", col = "black") + xlab("Male heights in inches") + ggtitle("Histogram")  # agrega color al interior y exterior de las barras, y agrega leyendas.


## DENSIDAD

p + geom_density()
p + geom_density(fill = "blue")


## QQ PLOT
# debemos redefinir nuestro objeto grafico 'p', ya que necesita un "argumento" diferente:

p <- heights %>% filter(sex == "Male") %>% ggplot(aes(sample = height))
p + geom_qq()

# para poder comparar los cuartiles calculados de los datos observados, en base a los cuartiles hipoteticos 
# calculados en base al estandar de la media = 0, y desviacion estandar = 1; se modifica la variable dparams 
# dentro de la funcion geom_qq.

# definimos nuevamente un nuevo objeto grafico  'p' que tenga la media y la dev. est. de los datos dentro de 
# variable dparams.

params <- heights %>% filter(sex == "Male") %>% summarize(mean = mean(height), sd = sd(height))

p + geom_qq(dparams = params)

# para agregar lineas de identidad para observar que tan bien [se ajustan los datos a] funciona la aproximacion normal.

p + geom_qq(dparams = params) + geom_abline() # default (intercept = 0, slope = 1)


# si 'escalamos' (scale) los datos para tenerlos en unidades estandar, y los graficamos contra la aproximacion normal (la distribucion normal estandar),
# nos ahorramos el paso de calcular la media y la desviacion estandar de los datos.

p <- heights %>% filter(sex =="Male") %>% ggplot(aes(sample = scale(height)))
p + geom_qq() + geom_abline()


# para poder crear una malla de graficos (es decir, varias graficas en una sola figura), usamos el paquete "gridExtra"
# y su funcion 'grid.arrange'.

library(gridExtra)

# y salvamos cada grafica en un objeto

p <- heights %>% filter(sex == "Male") %>% ggplot(aes(x = height))
p1 <- p + geom_histogram(binwidth = 1, fill = "blue", col = "black")
p2 <- p + geom_histogram(binwidth = 2, fill = "blue", col = "black")
p3 <- p + geom_histogram(binwidth = 3, fill = "blue", col = "black")

grid.arrange(p1,p2,p3, ncol = 3)



