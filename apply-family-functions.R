# lapply - list apply

dummy <- list(A = 1:1000, B = seq(1, 200, by = 0.25), C = rnorm(n = 1000, mean = 0.25, sd = 0.0045),
              D = rbinom(n = 2, size = 2000, prob = 0.35), E = runif(n = 1000, min = 10, max = 25))

lapply(dummy, FUN = mean)
lapply(dummy, FUN = mean) |> unlist()

lapply(dummy, sum) |> unlist()
lapply(dummy, sd) |> unlist()

data <- read.csv(file = "D:/DataSets/owid-covid-data.csv", header = TRUE)
# if the applied function takes more arguments besides the object, they can be passed for the
# ellipsis argument of the apply functions

lapply(data, is.numeric) |> unlist()
lapply(data, is.numeric) |> unlist()

numeric_cols <- data[lapply(data, is.numeric) |> unlist()]

lapply(numeric_cols, mean, na.rm = TRUE) |> unlist() |> as.data.frame()

lapply(data, FUN = is.na) |> lapply(FUN = sum) |> unlist() |> as.data.frame()
lapply(data, FUN = is.na) |> lapply(FUN = sum) |> unlist() |> 
    Map(f = `/`, nrow(data)) |> unlist()

lapply(data, FUN = is.na) |> lapply(FUN = sum) |> unlist() |> 
    Map(f = `/`, nrow(data)) |> Map(f = `*`, 100)|> unlist()

n.NAs <- lapply(data, FUN = is.na) |> lapply(FUN = sum) |> unlist() |> 
    as.vector()

frac.NA <- n.NAs / nrow(data)

lapply(data, FUN = is.na) |> lapply(FUN = sum) |> unlist() |> 
    Map(f = `/`, nrow(data)) |> unlist() |> as.vector() |> 
    all.equal(frac.NA)

# :))))

lapply(1:10, runif, min = 5, max = 10)

# applys using anonymous functions

lapply(numeric_cols, 
       FUN = function(column) {return(sum(column, na.rm = TRUE) / nrow(numeric_cols))})

lapply(numeric_cols, 
       FUN = function(column) {return(sum(column, na.rm = TRUE) / sum(!is.na(column)))}) |>
    unlist() |> as.vector()

colMeans(numeric_cols, na.rm = TRUE) |> as.vector()

lapply(numeric_cols, 
       FUN = function(column){return(sum(column, na.rm = TRUE) / sum(!is.na(column)))}) |>
    unlist() |> as.vector() |> all.equal(colMeans(numeric_cols, na.rm = TRUE) |> as.vector())
# :))))))

# a new way of writing anonymous functions
lapply(numeric_cols, FUN = \(column){return(sum(column, na.rm = TRUE) / sum(!is.na(column)))}) |>
    unlist() |> as.vector()

# new anonymous function syntax
# \(args){function body}
# equivalent to function(args){function body}

# sapply: identical to lapply in function but simplifies the output!
numeric_cols |> sapply(FUN = mean, na.rm = TRUE)



# apply functions

apply(data, MARGIN = 2, FUN = is.na, simplify = TRUE)
apply(data, MARGIN = 2, FUN = is.na, simplify = TRUE) |>
    apply(MARGIN = 2, FUN = sum, simplify = TRUE)

dummy <- matrix(data = runif(n = 1000, min = 12, max = 100), ncol = 20)
apply(dummy, MARGIN = 2, FUN = sum, simplify = TRUE)
apply(dummy, MARGIN = 2, FUN = sum, simplify = TRUE) == colSums(dummy)
apply(dummy, MARGIN = 1, FUN = sum, simplify = TRUE) == rowSums(dummy)

apply(dummy, MARGIN = 2, FUN = quantile, probs = c(0.25, 0.5, 0.75))
apply(numeric_cols, MARGIN = 2, FUN = prod, na.rm = TRUE)
apply(dummy, MARGIN = 2, FUN = prod, na.rm = TRUE)



# mapply: multivariate apply

args(mapply)
# applies a function with diffenent sets of arguments
mapply(FUN = seq, from = 0:5, length.out = 10:15)
mapply(FUN = rep, c("A","B","C","D","E"), each = 1:5)
mapply(FUN = rep, c("A","B","C","D","E"), times = 1:5)

mapply(prod, 1:10, 10:1, na.rm = TRUE)
for (i in 1:10){print(i * (11 - i))}

set.seed(2022 - 8 - 21)
mapply(FUN = `^`, 1:10, 1:5)
rnorm(n = 1:10, mean = 5.250, sd = seq(1,2, length.out = 10))
# this function was expected to expand as a vectorized function returning 10 different normal distributions
# each with 1:10 elements, and standard deviations 1.1 to 2.0 with a common mean 5.25
rnorm(n = 10, mean = 5.250, sd = 1.0)

# mapply() gets the job done!
mapply(FUN = rnorm, n = 1:10, mean = 5.250, sd = seq(1, 2, length.out = 10), SIMPLIFY = TRUE)


# tapply: applies a function over subsets of vector
# groups the elements of an iterable & does the computations on the groups!
args(tapply)
gl(n = 10, k = 100)
# gl() generates a factor with k elements per each n levels!
fac <- gl(n = 10, k = 100)
tapply(seq(1, 2, length.out = 1000), INDEX = fac, FUN = prod)

tapply(seq(100, 1000, length.out = 1000), INDEX = rep(1:10, each = 100), FUN = sum)
tapply(seq(1, 100, length.out = 1000), INDEX = rep(1:10, times = 100), FUN = sum)
tapply(seq(100, 1000, length.out = 1000), INDEX = rep(1:10, each = 100), FUN = range)
tapply(seq(1, 100, length.out = 1000), INDEX = rep(1:10, times = 100), FUN = range)


# split: splits an iterable based on specified grouping params
# split() |> lapply() will be roughly equivalent to tapply()
split(seq(1, 10, length.out = 1000), f = gl(n = 100, k = 10))

# following two are equivalent!!
split(seq(1, 10, length.out = 1000), f = gl(n = 100, k = 10)) |> lapply(prod) |> unlist()
tapply(seq(1, 10, length.out = 1000), INDEX = gl(n = 100, k = 10), simplify = TRUE, FUN = prod)

split(1:1000, rep(1:100, each = 10))
split(1:1000, rep(1:100, times = 10))

split.data.frame(data[, 1:3], f = data$continent)
split.data.frame(data[, 2:3], f = data$continent) |>
    lapply(FUN = \(x){return(unique(x$location))})

