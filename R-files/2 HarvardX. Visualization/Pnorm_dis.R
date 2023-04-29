# Code: Discretization and the normal approximation

x <- heights %>% filter(sex == "Male") %>% pull(height)   
## x <- heights$height[heights$sex == "Male"]

# Plot distribution of exact heights in data
plot(prop.table(table(x)), xlab = "a = Heights in inches", ylab = "Prob(x = a)")


# Probabilities in actual data over length 1 ranges containing an integer

## Al utilizar la función 'mean' sobre un vector lógico (generado a raíz de condicionales en datos numéricos), 
## este te regresa la probabilidad acumulada hasta y en cierto valor dado (o especificado)

mean(x <= 68.5) - mean(x <= 67.5)
mean(x <= 69.5) - mean(x <= 68.5)
mean(x <= 70.5) - mean(x <= 69.5)


# Probabilities in normal approximation match well
pnorm(68.5, mean(x), sd(x)) - pnorm(67.5, mean(x), sd(x))
pnorm(69.5, mean(x), sd(x)) - pnorm(38.5, mean(x), sd(x))
pnorm(70.5, mean(x), sd(x)) - pnorm(69.5 ,mean(x), sd(x))


#Probabilities in actual data over other ranges don't match normal approx as well.
mean(x <= 70.9) - mean (x <= 70.1)                            # [1] 0.0908046
pnorm(70.9, mean(x), sd(x)) - pnorm(70.1, mean(x), sd(x))     # [1] 0.08359562


