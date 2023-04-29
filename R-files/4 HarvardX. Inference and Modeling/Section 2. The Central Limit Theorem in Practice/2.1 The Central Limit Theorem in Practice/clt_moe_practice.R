# The Central Limit Theorem in Practice (and Margin of Error)

# 2022.06.20

## Code: Computing the probability of X_bar being within 0.01 of 'p'.

X_hat <- 0.48

se <- sqrt(X_hat*(1-X_hat)/25)
# [1] 0.09991997 (aprox. = 0.1)

pnorm(0.01/se) - pnorm(-0.01/se)  # pnorm(0.1000801) - pnorm(-0.1000801)
# [1] 0.07971926



## The Margin of Error

# The margin of error is two times the standard error:
# In this case it should be: 2*se = 2*(0.09991997) = 0.1998399

# In our case it is:

1.96*se
# [1] 0.1958431