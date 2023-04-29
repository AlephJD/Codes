# Bias: Plotting margin of error in an extremely large poll over
# a range of values of 'p'.

# 2022.07.26

library(tidyverse)
N <- 100000
p <- seq(0.35, 0.65, length = 100)
SE <- sapply(p, function(x) 2*sqrt(x*(1-x)/N))
             data.frame(p = p, SE = SE) %>%
               ggplot(aes(p,SE)) +
               geom_line()




## La grafica muestra que mientras mas cercanos sean los valores de probabilidad a '0' y '1',
# menor es el error estandar, mientras mas cercanos esten al valor medio entre 0 y 1 (es decir, 0.5)
# mayor sera el error porque la dispersion sera menor entre 'p' y '1-p'. La magnitud del error estandar,
# SE, (y por lo tanto el margen de error) por supuesto disminuira si aumentamos el tamano de la muestra 'N'.
             