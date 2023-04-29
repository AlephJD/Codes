# Monty Hall problem (from Book)
# https://rafalab.github.io/dsbook/probability.html#examples

# 2021.03.05


# In the 1970s, there was a game show called "Let's Make a Deal" and Monty Hall was the host.
# At some point in the game, contestants were asked to pick one of three doors. Behind one 
# door there was a prize. The other doors had a goat behind them to show the contestant they 
# had lost. After the contestant picked a door, before revealing whether the chosen door 
# contained a prize, Monty Hall would open one of the two remaining doors and show the contestant
# there was no prize behind that door. Then he would ask "Do you want to switch doors?" What 
# would you do?
  
# We can use probability to show that if you STICK with the original door choice, your chances
# of winning a prize remain 1 in 3. However, if you SWITCH to the other door, your chances of 
# winning double to 2 in 3! This seems counterintuitive. Many people incorrectly think both 
# chances are 1 in 2 since you are choosing between 2 options. You can watch a detailed mathematical
# explanation on Khan Academy (www.khanacademy.org/math/precalculus/prob-comb/dependent-events-precalc/
# v/monty-hall-problem) or read one on Wikipedia (en.wikipedia.org/wiki/Monty_Hall_problem). 
# Below we use a Monte Carlo simulation to see which strategy is better. Note that this code 
# is written longer than it should be for pedagogical purposes.

# Let's start with the stick strategy:

B <- 10000
monty_hall <- function(strategy){
  doors <- as.character(1:3)                            # genera un vector con tres numeros consecutivos que representan cada uno una puerta
  prize <- sample(c("car", "goat", "goat"))             # hace una permutacion aleatoria de los premios
  prize_door <- doors[prize == "car"]                   # identifica en que posicion del vector "prize" esta el premio, y esa posicion la adjudica como puerta ganadora en el vector "doors".
  my_pick  <- sample(doors, 1)                          # elige de manera aleatoria UNA muestra(elemento) del vector
  show <- sample(doors[!doors %in% c(my_pick, prize_door)],1)  # muestra una puerta que no es la elegida por el concursante y/o que tenga el premio.
  stick <- my_pick                                      # "STICK": estrategia de quedarse con la primera eleccion despues de haber mostrado previamente una puerta de tres
  stick == prize_door                                   # ¿Es la eleccion con la que te quedaste, la eleccion ganadora?
  switch <- doors[!doors %in% c(my_pick, show)]         # "SWITCH": estrategia de cambiar la primera eleccion despues de haber mostrado previamente una puerta de tres
  choice <- ifelse(strategy == "stick", stick, switch)
  choice == prize_door
}
stick <- replicate(B, monty_hall("stick"))
mean(stick)                                             # probability of choosing prize door when sticking
#> [1] 0.342
switch <- replicate(B, monty_hall("switch"))
mean(switch)                                            # probability of choosing prize door when switching
#> [1] 0.668






















