
#check the penguin data und create simple descriptive statistics

# based on https://www.r-bloggers.com/penguins-dataset-overview-iris-alternative-in-r/

library(palmerpenguins)
library(tidyverse)

str(penguins) # glimpse(penguins) 
#the dataset consists of 344 observations and 7 variables.
#bill length and depth, flipper length and body mass are quantitative = factors


penguins_clean <- penguins[complete.cases(penguins),]


plot(penguins_clean)
#create plots for all variables; not that intuitive, but might be good for a first small look at the data



#for factors it makes sense to count and show a histogram
#show a bar plot about how many species etc there are

barplot(table(penguins_clean$species), ylim = c(0,200)) 

#a nice barplot containing the number of each species
barplot(table(penguins_clean$species),  main = "Penguins - quantity of each species",
        ylim = c(0,210), 
        col=rgb(0.2,0.4,0.6,0.1)
#        col = "white")
)

#barplot with ggplot
ggplot(data = penguins_clean, aes( x = species)) + 
  geom_bar()


#graphs on the distribution based on quantitative variable

ggplot(penguins_clean, aes(bill_length_mm, bill_depth_mm, color = species)) + geom_point()
ggplot(penguins_clean, aes(bill_length_mm, flipper_length_mm, color = species)) + geom_point()
ggplot(penguins_clean, aes(bill_length_mm, body_mass_g, color = species)) + geom_point()

ggplot(penguins_clean, aes(bill_depth_mm, flipper_length_mm, color = species)) + geom_point()
ggplot(penguins_clean, aes(bill_depth_mm, body_mass_g, color = species)) + geom_point()

ggplot(penguins_clean, aes(flipper_length_mm, body_mass_g, color = species)) + geom_point()

#bill length and bill depth seem to be a good indicator for different species



### using kmeans based on https://www.r-bloggers.com/k-means-clustering-in-r/
set.seed(20)

#We know that there are three species of penguins, therefore kmeans should create 3 clusters
#nstart tells R to try 20 different starting positions and use the one with the lowest within cluster variation
penguinsCluster <- kmeans(penguins_clean[, c("bill_length_mm","bill_depth_mm")], 3, nstart = 20)

penguinsCluster$cluster
table(penguinsCluster$cluster)
penguins_clean$cluster <- as.factor(penguinsCluster$cluster)

table(penguins_clean$species, penguins_clean$cluster)


#show result: size of points and color of points
ggplot(penguins_clean, aes(bill_length_mm, bill_depth_mm, color = species)) + geom_point()
ggplot(penguins_clean, aes(bill_length_mm, bill_depth_mm, color = cluster)) + geom_point()

ggplot(penguins_clean, aes(bill_length_mm, bill_depth_mm, 
                           color = species, shape = cluster)) + geom_point(size = 4) +
  ggtitle("Penguins by actual species and kmeans clustering") +                #insert title
  theme(plot.title = element_text(hjust = 0.5))     #center ggplot title


#kmeans for three quantitative variables
penguinsCluster3 <- kmeans(penguins_clean[, c("bill_length_mm","bill_depth_mm", "flipper_length_mm")], 3, nstart = 20)
penguins_clean$cluster3 <- as.factor(penguinsCluster3$cluster)
table(penguins_clean$species, penguins_clean$cluster3)


#kmeans for the four quantitative variables
penguinsCluster4 <- kmeans(penguins_clean[, c("bill_length_mm","bill_depth_mm", "flipper_length_mm", "body_mass_g")], 3, nstart = 20)
penguins_clean$cluster4 <- as.factor(penguinsCluster4$cluster)
table(penguins_clean$species, penguins_clean$cluster4)

ggplot(penguins_clean, aes(bill_length_mm, bill_depth_mm, 
                           color = species, shape = cluster4)) + geom_point(size = 4) +
  ggtitle("Penguins by actual species and kmeans clustering") +                #insert title
  theme(plot.title = element_text(hjust = 0.5))     #center ggplot title



#3d plot with shiny; using penguin data 3 vriables and color (species) and shape (cluster)
penguins_clean$species 
penguins_clean$bill_length_mm
penguins_clean$bill_depth_mm
penguins_clean$flipper_length_mm
penguins_clean$cluster3






#to do: barplot change size of bars (smaller)
#to do: PCA or similar to see wether body mass is a good indicator for species
     