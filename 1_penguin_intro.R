
#check the penguin data und create simple descriptive statistics

# based on https://www.r-bloggers.com/penguins-dataset-overview-iris-alternative-in-r/

library(palmerpenguins)
library(tidyverse)

str(penguins) # glimpse(penguins) 
#the dataset consists of 344 observations and 7 variables.
#bill length and depth, flipper length and body mass are quantitative = factors

plot(penguins)
#create plots for all variables; not that intuitive, but might be good for a first small look at the data



#for factors it makes sense to count and show a histogram
#show a bar plot about how many species etc there are

plot(table(penguins$species))
barplot(table(penguins$species), ylim = c(0,200))

#a nice barplot about the number of each species
barplot(table(penguins$species),  main = "Penguins - quantity of each species",
        ylim = c(0,210), 
        col=rgb(0.2,0.4,0.6,0.1)
#        , col = "white")
)

ggplot(data = penguins, aes( x = species)) + 
  geom_bar()


     