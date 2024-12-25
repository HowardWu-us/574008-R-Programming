library(titanic)
library(dplyr)
library(ggplot2)

data(package = "titanic")
ggplot(data = titanic_train, aes(x = Pclass, fill = factor(Survived))) +
    geom_bar()