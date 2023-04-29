# Funcion que calcula la sumatoria del cuadrado de los numeros 1:n, segun lo pide la prueba de DATACAMP:

## In the next exercise we are going to write a for-loop. In that for-loop we are going to call a function. We define that function here.
# Write a function compute_s_n that for any given n computes the sum S_n = 1^2 + 2^2 + 3^2 + ??? + n^2.


# Prueba 2 (Final enviado en DATACAMP)

compute_s_n <- function(n){
  sum_s_n <- vector(length = n)
  for(x in 1:n){
    sum_s_n[x] <- x^2
  }
  sum(sum_s_n)
}


## CODIGO DATACAMP (sin funcion for-loop) ##

# compute_s_n <- function(n){
#   x <- 1:n
#   sum(x^2)
# }


# PRUEBA 1

# sqr <- function(x){
#   x <- x^2
# }

# n <- 2
# sum_s_n <- vector(length = n)

# for(x in 1:n){
#   sum_s_n[x] <- sqr(x)
# }
# sum(sum_s_n)