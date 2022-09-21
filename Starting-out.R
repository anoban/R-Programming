R.Version()
Sys.getlocale()
Sys.Date()
Sys.getenv()
Sys.info()
Sys.timezone()
Sys.time()

getwd()
setwd("D:/R programming/")

source("library.R")
factorialRecursive(5)
factorialRecursive(19)
factorial(19)
dir()

packages <- installed.packages() |> as.data.frame()
packages |> subset(NeedsCompilation == "yes")

packages$Package

x = 10  # a numeric vector
x <- 11.0
x[2] <- 15
rnorm(200, mean = 45.7853, sd = 6.564132) |> range()

# commenting in R

is.element("swirl", packages$Package)
# :))

12:87 |> as.vector()

