# For Loops (continuacion, HarvardX, section 4.4)

# First Example

# results <-  vector("numeric", 10)
# n <- 10
# for(i in 1:n){
#   x <- 1:i
#   results[i] <- sum(x)
# }


# PRUEBA 2 (enviada a DATACAMP)
s_n <- vector("numeric", 25)

compute_s_n <- function(n){
  x <- 1:n
  sum(x^2)
}
  
for(i in 1:n){
  s_n[i] <- compute_s_n(i)
}


# PRUEBA 1 (integrando dentro de la funcion, "for")
# Marca error, no encnuetra s_n:
# "Error: object 's_n' not found"

# compute_s_n <- function(n){
#   for(i in 1:n){
#     x <- 1:i
#     s_n[i] <- sum(x^2)
#   }
# }