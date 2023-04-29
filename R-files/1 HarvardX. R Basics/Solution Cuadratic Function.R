#Code to compute the solution to quadratic equation of the form ax^2+bx+c

#Define variables (constants)

a <- 2
b <- -1
c <- -4

#Compute solution

solution_1 <- (-b + sqrt(b^2 - 4*a*c))/(2*a)
solution_2 <- (-b - sqrt(b^2 - 4*a*c))/(2*a)

solution_1; solution_2
