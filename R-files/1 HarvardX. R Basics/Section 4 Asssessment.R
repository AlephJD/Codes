# Q1 
sex <- ifelse(heights$sex == "Female", 1, 2) #1862

# Q2
Q2ht <- ifelse(heights$height > 72, heights$height, 0) #9.653534

# Q3

inches_to_ft <- function(x){
  ft <- x*1/12
  ft
}

inches_to_ft(144) #12


length(which(inches_to_ft(heights$height) < 5)) #20

# feet <- inches_to_ft(heights$height)
# length(which(feet < 5)) #20



# Q5
# define a vector of length m
m <- 10
f_n <- vector(length = m)

# make a vector of factorials
for(n in 1:m){
  f_n[n] <- factorial(n)
}

# inspect f_n
f_n



