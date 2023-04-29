# 1.4 Assessment: Discrete Probability

# 2021.04.23


# INTRODUCTION

# The following assessments allow you to practice the probability and coding skills you've learned
# in Section 1: Discrete Probability. You will likely find it useful to try out code to answer the
# problems using R on your own machine.

# You will benefit from using the following libraries:

library(gtools)
library(tidyverse)


###################################################################################################
###################################################################################################


## QUESTION 1: 
## OLYMPIC RUNNING

# In the 200m dash finals in the Olympics, 8 runners compete for 3 medals (order matters). In the
# 2012 Olympics, 3 of the 8 runners were from Jamaica and the other 5 were from different countries.
# The three medals were all won by Jamaica (Usain Bolt, Yohan Blake, and Warren Weir).

# Use the information above to help you answer the following four questions.

# Question 1a
# How many different ways can the 3 medals be distributed across 8 runners?

# Se usa la Permutacion (sin repeticion). Importa el orden y cada uno de los ocho(8) corredores tiene 
# oportunidad de subirse al podio con cada una de las medallas (no simultaneamente).

# nPr = n!/(n-r)!; n = 8, r = 3
diff_ways <- permutations(8, 3, repeats.allowed = FALSE)

#dim(diff_ways)
# [1] 336   3
# R =
# [1] 336 (correcto)
  
# Question 1b
# How many different ways can the three medals be distributed among the 3 runners from Jamaica?   

# Se usa la Permutacion (sin repeticion). Importa el orden y cada uno de los tres(3) corredores tiene 
# oportunidad de subirse al podio con cada una de las medallas (no simultaneamente).

# nPr = n!/(n-r)!; n = 3, r = 3
diff_ways <- permutations(3, 3, repeats.allowed = FALSE)

#dim(diff_ways)
# [1] 6   3
# R =
# [1] 6 (correcto)


# Question 1c
# What is the probability that all 3 medals are won by Jamaica?

# Evento NO Mutuamente Excluyente y Dependiente:
# Pr(A???B???C)=Pr(A)*Pr(B???A)*Pr(C???A???B)
# Pr(Jamaica y Jamaica y Jamaica)=Pr(Jamaica)*Pr(Jamaica|Jamaica)*Pr(Jamaica|Jamaica y Jamaica)

prob_allwin_jamaica <- (3/8)*(2/7)*(1/6)
#[1] 0.01785714 (correcto)

# Question 1d
# Run a Monte Carlo simulation on this vector representing the countries of the 8 runners in this
# race:

runners <- c("Jamaica", "Jamaica", "Jamaica", "USA", "Ecuador", "Netherlands", "France", "South Africa")


# For each iteration of the Monte Carlo simulation, within a 'replicate()' loop, select 3 runners 
# representing the 3 medalists and check whether they are all from Jamaica. Repeat this simulation
# 10,000 times. Set the seed to 1 before running the loop.

# Calculate the probability that all the runners are from Jamaica.

B <- 10000
set.seed(1)

prob_allwin_jamaica <- replicate(B, {
  win_jamaica <- sample(runners, 3, replace = FALSE)
  sum(win_jamaica == "Jamaica") == 3
})

mean(prob_allwin_jamaica)
#[1] 0.0174 (correcto)


###################################################################################################
###################################################################################################


## QUESTION  2: 
## RESTAURANT MANAGEMENT

# Use the information below to answer the following five questions.

# A restaurant manager wants to advertise that his lunch special offers enough choices to eat different
# meals every day of the year. He doesn't think his current special actually allows that number of 
# choices, but wants to change his special if needed to allow at least 365 choices.

# A meal at the restaurant includes 1 entree, 2 sides, and 1 drink. He currently offers a choice of 1 
# entree from a list of 6 options, a choice of 2 different sides from a list of 6 options, and a choice
# of 1 drink from a list of 2 options.

# Question 2a
# How many meal combinations are possible with the current menu?

# La opción de los 'sides' es el único que sus elementos se pueden descomponer en dos subconjuntos:
# Es una combinación sin repetición (no importa el orden, e.g.: puré de papa y ensalada y ensalada y 
# puré de papa [permutación] no se permite; sólo: puré de papa y ensalada ó ensalada y puré de papa)

# n=6,   r=2
# nCr =n!/(r!(n-r)!)=6!/2!(6-2)!=6!/(2! 4!)=(6*5*4!)/2!4!=(6*5)/2!=30/2=15

op_ent <- seq(1,6)       # [1] 1 2 3  4  5  6,  entree options (6)
op_sid <- seq(7,12)      # [1] 7 8 9 10 11 12,  sides options (6)
op_dri <- seq(13,14)     # [1] 13 14,           drink options (2)       

comb_sides <- combinations(6,2, op_sid, repeats.allowed = FALSE)

total_meal <- expand.grid(op_ent, comb_sides[,1], op_dri)    # si no llega a funcionar cambiar a: comb_sides[,2]
nrow(total_meal)
# [1] 180                # numero total de combinaciones

# Se puede realizar tambien: 
nrow(comb_sides)*6*2      # =15*6*2

# R = 180 (correcto)


# Question 2b
# The manager has one additional drink he could add to the special.
# How many combinations are possible if he expands his original special to 3 drink options?   

# Lo mismo que la pregunta anterior, pero en lugar de multiplicar por dos(2) en las bebidas
# agregamos una mas, por lo tanto multiplicamos por tres(3).

# =15*6*3
# [1] 270 

# R = 270 (correcto)


# Question 2c
# The manager decides to add the third drink but needs to expand the number of options. The manager 
# would prefer not to change his menu further and wants to know if he can meet his goal by letting 
# customers choose more sides.

# How many meal combinations are there if customers can choose from 6 entrees, 3 drinks, and select
# 3 sides from the current 6 options?
   
# n=6,   r=3
# nCr =n!/(r!(n-r)!)=6!/3!(6-3)!=6!/(3! 3!)=(6*5*4*3!)/3!3!=(6*5*4)/6!=30/2=20

op_ent <- seq(1,6)       # [1] 1 2 3  4  5  6,   entree options (6)
op_sid <- seq(7,12)      # [1] 7 8 9 10 11 12,   sides options (6)
op_dri <- seq(13,15)     # [1] 13 14 15,         drink options (3)

comb_sides <- combinations(6,3, op_sid, repeats.allowed = FALSE)

total_meal <- expand.grid(op_ent, comb_sides[,1], op_dri)
nrow(total_meal)
# [1] 360

# Se puede realizar tambien: 
nrow(comb_sides)*6*3      # =20*6*3

# R = 360  (correcto)


# Question 2d
# The manager is concerned that customers may not want 3 sides with their meal. He is willing to increase
# the number of entree choices instead, but if he adds too many expensive options it could eat into 
# profits. He wants to know how many entree choices he would have to offer in order to meet his goal.

# a) - Write a function that takes a number of entree choices and returns the number of meal combinations
#      possible given that number of entree options, 3 drink choices, and a selection of 2 sides from
#      6 options.
# b) - Use sapply() to apply the function to entree option counts ranging from 1 to 12.

# What is the minimum number of entree options required in order to generate more than 365 combinations?
# Solo cambia la cantidad de opciones de entrees.

op_ent <- seq(1,12)      # [1] 1 2 3  4  5  6 7 8 9 10 11 12,  entree options (12)
op_sid <- seq(13,18)     # [1] 13 14 15 16 17 18,              sides options (6)
op_dri <- seq(19,21)     # [1] 19 20 21,                       drink options (3)

comb_sides <- combinations(6,2, op_sid, repeats.allowed = FALSE)

total_meal <- function(op_ent){
  op_ent*nrow(comb_sides)*3
}

min_entree <- sapply(op_ent,total_meal)
plot(op_ent, min_entree)
grid(NULL, NULL, lwd = 2)

op_ent
# [1]  1  2  3  4  5  6  7  8  9 10 11 12
min_entree
# [1]  45  90 135 180 225 270 315 360 405 450 495 540

min(op_ent[min_entree > 365])
# [1] 9

# R = 9 (correcto)


# Question 2e
# The manager isn't sure he can afford to put that many entree choices on the lunch menu and thinks
# it would be cheaper for him to expand the number of sides. He wants to know how many sides he would
# have to offer to meet his goal of at least 365 combinations.

# a) - Write a function that takes a number of side choices and returns the number of meal combinations
#      possible given 6 entree choices, 3 drink choices, and a selection of 2 sides from the specified number of side choices.
# b) - Use sapply() to apply the function to side counts ranging from 2 to 12.

# What is the minimum number of side options required in order to generate more than 365 combinations?
# Seleccionando siempre 2 'sides' en cada cantidad nueva de opciones.
  
  
op_ent <- seq(1,6)       # [1] 1 2 3  4  5  6,                       entree options (6)
op_sid <- seq(7,18)      # [1] 7 8 9 10 11 12 13 14 15 16 17 18      sides options (12)
op_dri <- seq(19,21)     # [1] 19 20 21                              drink options (3)

n_side <- seq(2,12)
total_meal <- function(n_side){
  comb_sides <- combinations(n_side,2, op_sid[1:n_side], repeats.allowed = FALSE)
  6*nrow(comb_sides)*3
}

min_side <- sapply(n_side,total_meal)
plot(n_side, min_side)
grid(NULL, NULL, lwd = 2)

n_side
#[1]  2  3  4  5  6  7  8  9 10 11 12

min_side
#[1]   18   54  108  180  270  378  504  648  810  990 1188

min(n_side[min_side > 365])

# R = 7 (correcto)


###################################################################################################
###################################################################################################


## QUESTIONS 3 AND 4: 
## ESOPHAGEAL CANCER AND ALCOHOL/TOBACCO USE, PART 1

# Case-control studies help determine whether certain exposures are associated with outcomes such as
# developing cancer. The built-in dataset 'esoph' contains data from a case-control study in France 
# comparing people with esophageal cancer (cases, counted in 'ncases') to people without esophageal 
# cancer (controls, counted in 'ncontrols') that are carefully matched on a variety of demographic and
# medical characteristics. The study compares alcohol intake in grams per day ('alcgp') and tobacco 
# intake in grams per day ('tobgp') across cases and controls grouped by age range ('agegp').

# The dataset is available in base R and can be called with the variable name 'esoph':

#  agegp     alcgp      tobgp   ncases   ncontrols
#           [g/day]   [g/day]
#  25-34     0-39       0-9
#                      10-19  
#                      20-29
#                      30+
#            40-79
#            80-119
#            120+
#  34-44
#  45-54
#  55-64
#  65-74
#  75+


head(esoph)

# You will be using this dataset to answer the following four multi-part questions (Questions 3-6).
# You may wish to use the 'tidyverse' package:

library(tidyverse)

# The following three parts have you explore some basic characteristics of the dataset.
# Each row contains one group of the experiment. Each group has a different combination of age, alcohol
# consumption, and tobacco consumption. The number of cancer cases and number of controls (individuals
# without cancer) are reported for each group.

# Question 3a
# How many groups are in the study?
dim(esoph)
# [1] 88  5
z <- dim(esoph)
z[1]
# [1] 88

# R = 88 (correcto)

  
# Question 3b
# How many cases are there?
#  Save this value as 'all_cases' for later problems.
all_cases <- sum(esoph$ncases)
all_cases
# [1] 200

# R = 200 (correcto)

# Question 3c
# How many controls are there?
#  Save this value as 'all_controls' for later problems.
all_controls <- sum(esoph$ncontrols)
all_controls
# [1] 975

# R = 975


# The following four parts ask you to explore some probabilities within this dataset related to alcohol
# and tobacco consumption.

# Question 4a
# What is the probability that a subject in the highest alcohol consumption group is a cancer case?

# esoph$ncases[esoph$alcgp == "120+"]
# [1] 0 1 0 0 2 0 2 4 3 2 4 5 6 2 5 3 1 1 1 2 1

# sum(esoph$ncases[esoph$alcgp == "120+"])
# [1] 45

# esoph$ncontrols[esoph$alcgp == "120+"]
# [1]  1  1  1  2  3  3  4  4  4  3  4 10  7  3  6  4  2  1  1  2  1

# sum(esoph$ncontrols[esoph$alcgp == "120+"])
# [1] 67


total_120p <- sum(esoph$ncases[esoph$alcgp == '120+'] + esoph$ncontrols[esoph$alcgp == "120+"])   # ó  sum(esoph$ncases[esoph$alcgp == '120+']) + sum(esoph$ncontrols[esoph$alcgp == "120+"])

cancer_120p <- sum(esoph$ncases[esoph$alcgp == '120+'])

prob_cancer_120p <- cancer_120p / total_120p

prob_cancer_120p
# [1] 0.4017857 (correcto)


# Question 4b
# What is the probability that a subject in the lowest alcohol consumption group is a cancer case?

# esoph$ncases[esoph$alcgp == "0-39g/day"]
# [1] 0 0 0 0 0 1 0 0 1 0 0 0 2 3 3 4 5 4 2 0 1 2 1

# sum(esoph$ncases[esoph$alcgp == "0-39g/day"])
# [1] 29

# esoph$ncontrols[esoph$alcgp == "0-39g/day"]
# [1] 40 10  6  5 60 14  7  8 46 18 10  4 49 22 12  6 48 14  7  2 18  6  3

# sum(esoph$ncontrols[esoph$alcgp == "0-39g/day"])
# [1] 415


total_0to39 <- sum(esoph$ncases[esoph$alcgp == '0-39g/day'] + esoph$ncontrols[esoph$alcgp == "0-39g/day"])   # ó  sum(esoph$ncases[esoph$alcgp == '0-39g/day']) + sum(esoph$ncontrols[esoph$alcgp == "0-39g/day"])

cancer_0to39 <- sum(esoph$ncases[esoph$alcgp == '0-39g/day'])

prob_cancer_0to39 <- cancer_0to39 / total_0to39

prob_cancer_0to39
# [1] 0.06531532 (correcto)


# Question 4c
# Given that a person is a case, what is the probability that they smoke 10g or more a day?
  
case_tob_10p <- sum(esoph$ncases[esoph$tobgp > "0-9g/day"])

prob_castob_10p <- case_tob_10p / all_cases

prob_castob_10p
# [1] 0.61 (correcto)
  
# Question 4d
# Given that a person is a control, what is the probability that they smoke 10g or more a day?
  
ctrl_tob_10p <- sum(esoph$ncontrols[esoph$tobgp > "0-9g/day"])

prob_ctrltob_10p <- ctrl_tob_10p / all_controls

prob_ctrltob_10p
# [1] 0.4615385 (correcto)


###################################################################################################
###################################################################################################


## QUESTIONS 5 AND 6: 
## ESOPHAGEAL CANCER AND ALCOHOL/TOBACCO USE, PART 2


# The following four parts look at probabilities related to alcohol and tobacco consumption among the
# cases.

# Question 5a
# For cases, what is the probability of being in the highest alcohol group?

case_alc_120p <- sum(esoph$ncases[esoph$alcgp == "120+"])

prob_casalc_120p <- case_alc_120p / all_cases

prob_casalc_120p
# [1] 0.225 (correcto)


# Question 5b
# For cases, what is the probability of being in the highest tobacco group?

case_tob_30p <- sum(esoph$ncases[esoph$tobgp == "30+"])

prob_castob_30p <- case_tob_30p / all_cases

prob_castob_30p
# [1] 0.155 (correcto)


# Question 5c
# For cases, what is the probability of being in the highest alcohol group AND the highest tobacco 
# group?

alc120p_and_tob30p <- sum(esoph$ncases[esoph$alcgp == "120+" & esoph$tobgp == "30+"])    # 10 cases

prob_alc120p_and_tob30p <- alc120p_and_tob30p / all_cases                                 # 10/200

prob_alc120p_and_tob30p                                                                  
# [1] 0.05 (correcto)

  
# Question 5d
# For cases, what is the probability of being in the highest alcohol group OR the highest tobacco 
# group?

sum(esoph$ncases[esoph$tobgp == "30+"])                           # 31
p_a <- sum(esoph$ncases[esoph$tobgp == "30+"]) / all_cases        # 31/200 = 0.155


sum(esoph$ncases[esoph$alcgp == "120+"])                          # 45
p_b <- sum(esoph$ncases[esoph$alcgp == "120+"]) / all_cases       # 45/200 = 0.225


sum(esoph$ncases[esoph$alcgp == "120+" & esoph$tobgp == "30+"])   # 10
p_anb <- sum(esoph$ncases[esoph$alcgp == "120+" & esoph$tobgp == "30+"])/ all_cases    # 10/200 = 0.05


p_aub <- p_a + p_b - p_anb
# [1] 0.33  (correcto)


# The following six parts look at probabilities related to alcohol and tobacco consumption among 
# the controls and also compare the cases and the controls.


# Question 6a
# For controls, what is the probability of being in the highest alcohol group?
  
ctrl_alc_120p <- sum(esoph$ncontrols[esoph$alcgp == "120+"])

prob_ctrlalc_120p <- ctrl_alc_120p / all_controls

prob_ctrlalc_120p
# [1] 0.0687 (correcto)

  
# Question 6b
# How many times more likely are cases than controls to be in the highest alcohol group?

sum(esoph$ncases[esoph$alcgp == "120+"])        # 45
sum(esoph$ncontrols[esoph$alcgp == "120+"])     # 67

prob_cases <- sum(esoph$ncases[esoph$alcgp == "120+"])/all_cases         # 45/200 = 0.225
prob_controls <- sum(esoph$ncontrols[esoph$alcgp == "120+"])/all_controls   # 67/975 = 0.0687

times_likely <- prob_cases/prob_controls
times_likely
# [1] 3.2742 (correcto)


# Question 6c
# For controls, what is the probability of being in the highest tobacco group?
  
ctrl_tob_30p <- sum(esoph$ncontrols[esoph$tobgp == "30+"])

prob_ctrltob_30p <- ctrl_tob_30p / all_controls

prob_ctrltob_30p
# [1] 0.0841 (correcto)
  
  
# Question 6d
# For controls, what is the probability of being in the highest alcohol group AND the highest tobacco
# group?

sum(esoph$ncontrols[esoph$alcgp == "120+" & esoph$tobgp == "30+"])                    # 13 

sum(esoph$ncontrols[esoph$alcgp == "120+" & esoph$tobgp == "30+"]) / all_controls     # 13/975
# [1] 0.0133 (correcto)

  
# Question 6e
# For controls, what is the probability of being in the highest alcohol group OR the highest tobacco
# group?
  
sum(esoph$ncontrols[esoph$tobgp == "30+"])                              # 82
p_a <- sum(esoph$ncontrols[esoph$tobgp == "30+"]) / all_controls        # 82/975 = 0.08410256

sum(esoph$ncontrols[esoph$alcgp == "120+"])                             # 67
p_b <- sum(esoph$ncontrols[esoph$alcgp == "120+"]) / all_controls       # 67/975 = 0.06871795

sum(esoph$ncontrols[esoph$alcgp == "120+" & esoph$tobgp == "30+"])      # 13
p_anb <- sum(esoph$ncontrols[esoph$alcgp == "120+" & esoph$tobgp == "30+"])/ all_controls    # 13/975 = 0.01333333

p_aub <- p_a + p_b - p_anb
# [1] 0.1394872  (correcto)  


# Question 6f
# How many times more likely are cases than controls to be in the highest alcohol group OR the highest
# tobacco group?
  
# Cases
sum(esoph$ncases[esoph$alcgp == "120+"])                         # 45
sum(esoph$ncases[esoph$tobgp == "30+"])                          # 31
sum(esoph$ncases[esoph$alcgp == "120+" & esoph$tobgp == "30+"])  # 10

p_alc_cas <- sum(esoph$ncases[esoph$alcgp == "120+"]) / all_cases  # 45/200
p_tob_cas <- sum(esoph$ncases[esoph$tobgp == "30+"]) / all_cases   # 31/200
p_ant_cas <- sum(esoph$ncases[esoph$alcgp == "120+" & esoph$tobgp == "30+"]) / all_cases  # 10/200

p_aut_cas <- p_alc_cas + p_tob_cas - p_ant_cas
# [1] 0.33


# Controls
sum(esoph$ncontrols[esoph$alcgp == "120+"])                         # 67
sum(esoph$ncontrols[esoph$tobgp == "30+"])                          # 82
sum(esoph$ncontrols[esoph$alcgp == "120+" & esoph$tobgp == "30+"])  # 13

p_alc_ctrl <- sum(esoph$ncontrols[esoph$alcgp == "120+"]) / all_controls  # 67/975
p_tob_ctrl <- sum(esoph$ncontrols[esoph$tobgp == "30+"]) / all_controls   # 82/975
p_ant_ctrl <- sum(esoph$ncontrols[esoph$alcgp == "120+" & esoph$tobgp == "30+"]) / all_controls  # 13/975

p_aut_ctrl <- p_alc_ctrl + p_tob_ctrl - p_ant_ctrl
# [1] 0.1394872


times_likely <- p_aut_cas/p_aut_ctrl            # 0.33/0.1394872 = 2.365809
times_likely
# [1] 2.365809 (correcto)  
  






