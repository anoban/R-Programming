data(iris)

iris |> subset(Species == "virginica", select = Sepal.Length) |> unlist() |>
    as.vector() |> mean(na.rm = TRUE)

names(iris)

iris[, 1:4] |> apply(MARGIN = 2, FUN = mean, na.rm = TRUE)

data("mtcars")

# average miles per gallon (mpg) per number of cylinders
mtcars |> split(f = mtcars$cyl) |>
    lapply(FUN = \(df){return(mean(df$mpg, na.rm = TRUE))})

mtcars$mpg |> tapply(INDEX = mtcars$cyl, FUN = mean, na.rm = TRUE)
mtcars |> apply(MARGIN = 2, FUN = mean, na.rm = TRUE)

mtcars |> split.data.frame(f = mtcars$cyl)
with(mtcars, tapply(X = mpg, INDEX = cyl, FUN = mean, na.rm = TRUE))

sapply(split(mtcars$mpg, mtcars$cyl), FUN = mean)
tapply(mtcars$mpg, INDEX = mtcars$cyl, FUN = mean, na.rm = TRUE, simplify = TRUE)
tapply(mtcars$mpg, INDEX = mtcars$cyl, FUN = mean, na.rm = TRUE, simplify = TRUE)


horsepow <- mtcars |> split.data.frame(f = mtcars$cyl) |>
    lapply(FUN = \(df){return(df |> subset(select = hp) |> unlist() |> mean(na.rm = TRUE))})

{horsepow[[3]] - horsepow[[1]]} |> round(digits = 0)
