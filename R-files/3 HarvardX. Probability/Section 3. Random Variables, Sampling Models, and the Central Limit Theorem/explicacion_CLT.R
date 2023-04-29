
set.seed(1, sample.kind = "Rounding")    # will make R 3.6 generate a seed as in R 3.5

# ORIGINAL
# sampling model 2: define urn inside sample function by noting probabilities
n <- 1000
x <- sample(c(-1, 1), n, replace = TRUE, prob = c(9/19, 10/19))    # 1000 independent draws, lowercase 'x'
S <- sum(x)    # total winnings of the casino = sum of draws
S

# En la urna (la ruleta) se encuentran 20 valores que nos agrega $1 si obtengo uno de ellos (si lo obtengo le asigno +1),
# y 18 valores que nos resta $1 si obtengo uno de ellos (si lo obtengo le asigno -1). En total tengo 38 valores. 

# Podria obtener el 'valor esperado' (E[X]) de la extraccion de la muestra de la urna (1 o -1) (variable aleatoria X) (el cual
# es la media poblacional de todas las extracciones que obtendria), si desde el principio aplico la "Ley de los Grandes Numeros" (revisar)
# y realizo el promedio de los valores dentro de la urna: ap + bq = ( (20 + (-18)) / 38) = (1)(10/19) + (-1)(9/19) = 0.05263



# Cuando estoy realizando las extracciones de una muestra de la urna:
# x <- sample(c(-1, 1), n, replace = TRUE, prob = c(9/19, 10/19)) 
# y obtengo el promedio:
# mean(x), este va oscilando entre diferentes valores: 0.096, 0.088, 0.074, 0.066, 0.016, 0.002, 0.090, 0.104, -0.024
## Esto se llama 'SAMPLE MEAN': (X1 + X2 +...+ Xn)/n

# Pero si yo hago la suma de estas extracciones: 
# sum(x): 96, 88, 74, 66, 16, 2, 90, 104, -24
## Entonces estoy realizando el 'SAMPLE SUM': (X1 + X2 +...+ Xn)


# MODIFICADO
# Aqui todo lo estoy haciendo a "escala chiquita", es por eso que no obtengo ni el:
# a) 'expected value of sample mean': (X1 + X2 +...+ XN)/N = 0.052631 ($cts/juego)
# b) 'expected value of sample sum': (X1 + X2 +...+ Xn) = 52.63 ($ ganancia al 'dia' [por 1000 juegos])

# sampling model 2: define urn inside sample function by noting probabilities
n <- 1000
x <- sample(c(-1, 1), n, replace = TRUE, prob = c(9/19, 10/19))    # 1000 independent draws, lowercase 'x'
mean(x)
[1] -0.024
sum(x)    # total winnings of the casino = sum of draws
[1] -24


################################################################################
################################################################################
# Pequeno ejemplo de lo que estoy representando anteriormente:

> n <- 1000

> X <- sample(c(-1, 1), n, replace = TRUE, prob = c(9/19, 10/19))
> mean(X)
[1] -0.004
> n*mean(X)
[1] -4

> X <- sample(c(-1, 1), n, replace = TRUE, prob = c(9/19, 10/19))
> mean(X)
[1] 0.008
> n*mean(X)
[1] 8

> X <- sample(c(-1, 1), n, replace = TRUE, prob = c(9/19, 10/19))
> mean(X)
[1] 0.068
> n*mean(X)
[1] 68

################################################################################
################################################################################


# Aqui todo lo estoy haciendo a "escala grandota"
## CREO que aplicando la 'Ley de los Grandes Numeros':
# Law of Large Numbers.
# The Law of Large Numbers says that in repeated, independent trials with the same probability 'p' of 
# success in each trial, the percentage of successes is increasingly likely to be close to the chance
# of success as the number of trials increases. More precisely, the chance that the percentage of 
# successes differs from the probability 'p' by more than a fixed positive amount, e > 0, converges to 
# zero as the number of trials 'n' goes to infinity, for every number e > 0.

# se obtiene entonces:
# a) 'expected value of sample mean': (X1 + X2 +...+ XN)/N = 0.052631 ($cts/juego)
# b) 'expected value of sample sum': (X1 + X2 +...+ Xn) = 52.63 ($ ganancia al 'dia' [por 1000 juegos])

# ORIGINAL (codigo: sampling_models.R)
n <- 1000    # number of roulette players
B <- 10000    # number of Monte Carlo experiments
S <- replicate(B, {                       # Uppercase 'S'
  X <- sample(c(-1,1), n, replace = TRUE, prob = c(9/19, 10/19))    # simulate 1000 spins  # Uppercase 'X'
  sum(X)    # determine total profit
})
mean(S)
[1] 52.13


# 'MODIFICADO' (mejor: video y libro)
B <- 10^6
X <- sample(c(-1,1), B, replace = TRUE, prob = c(9/19, 10/19))

length(X)
[1] 1000000

 X
[1]  1 -1 -1  1  1  1  1  1  1 -1  1  1 -1 -1  1 -1  1  1 -1
[20]  1 -1  1  1 -1 -1 -1  1 -1  1 -1 -1 -1 -1 -1 -1  1 -1 -1
[39]  1 -1  1 -1  1  1 -1  1 -1  1 -1  1  1  1  1  1  1 -1 -1
[58] -1 -1  1 -1 -1  1  1  1 -1 -1  1  1  1 -1  1  1 -1 -1 -1
[77]  1  1  1 -1  1  1  1 -1 -1 -1 -1 -1  1  1  1  1 -1 -1 -1
[96]  1 -1  1  1  1  1 -1  1  1 -1 -1 -1 -1  1  1  1 -1  1  1
[115]  1  1  1  1 -1 -1  1 -1 -1 -1  1  1 -1  1 -1 -1  1  1  1
.
.
.
.

mean(X) # = E[X]= µ (Expected value of the 'Sample Mean')
[1] 0.052518

n*mean(X) # = E[i=1 ?? n(Xi)] = E[i=1 Sigma n(Xi)] (Expected value of the 'Sample Sum')
[1] 52.51






