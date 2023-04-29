# Runs a Monte Carlo simulation
# 2021.01.29

# Simulate a sample without replacement
beads <- rep(c("red", "blue"), times = c(2,3))    # create an urn with 2 red, 3 blue
beads    # view beads object
sample(beads, 1)    # sample 1 bead at random


# Monte Carlo simulation, when we aproximate the experiment a larger number of times
# being practically equivalent to the limit (meaning if we do it forever)
B <- 10000    # number of times to draw 1 bead
events <- replicate(B, sample(beads, 1))    # draw 1 bead, B times
tab <- table(events)    # make a table of outcome counts
tab    # view count table
# events
# blue  red 
# 6017 3983

prop.table(tab)    # view table of outcome proportions
# events
# blue         red 
# 0.6017    0.3983


# We can get similar results without using "replicate" function, and using
# "sample" function with replacement.
events <- sample(beads, B, replace = TRUE)
prop.table(table(events))
# events
# blue    red 
# 0.6057 0.3943



