head(iris)

# Q1
data_train <- rbind(iris[1:40, ], iris[51:90, ], iris[101:140, ])
data_test <- rbind(iris[41:50, ], iris[91:100, ], iris[141:150, ])

# Q2
model <- lm(
  formula = Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width,
  data = data_train
)
summary(model)

predicted_length <- data.frame(
  truth = data_test$Sepal.Length,
  predict = predict(model, data_test)
)
predicted_length$diff <- predicted_length$predict - predicted_length$truth

# Q3
rms <- sqrt(mean(predicted_length$diff^2))
print(rms)

