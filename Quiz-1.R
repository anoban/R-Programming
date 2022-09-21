setwd("D:/R programming/quiz1_data/")
data <- read.csv("./hw1_data.csv")
data
names(data)
data[c(1,2),]
nrow(data)
data[(nrow(data)-1):nrow(data),]

data$Ozone[47]
is.na(data$Ozone) |> sum()

data$Ozone |> mean(na.rm = TRUE)

data |> subset(Ozone > 31 & Temp > 90, select = Solar.R) |> unlist() |> mean()

data |> subset(Month == 6, select = Temp) |> unlist() |> mean()

data |> subset(Month == 5, select = Ozone) |> unlist() |> max(na.rm = TRUE)
