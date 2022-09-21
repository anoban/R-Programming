setwd("D:/R programming/")
as.numeric(c(18.35, 87.654578, 86, 97987.0997, 0.674567))
# vectors are arrays: can only contain a uniform data type
# lists are capable of containing dynamic elements!
list("Hailie", "J", c(1,3,4,6,8,9), 13, 0.67456)

# see what happesn!!
c("Hailie", "J", c(1,3,4,6,8,9), 13, 0.67456)

NaN
is.na(NA)
is.na(NaN)
Inf
1/0
is.na(Inf)
is.na(-Inf)
-1/0
90.00L
9.768565L
class(NaN)
class(NA)
class(TRUE)
class(12:29)

c(seq(1, 45, 2.5))
c(rep(5, each = 12))

rep.int(23, 8)
rep(12, length.out = 23)
rep(c(10, 11), times = c(5, 6))
rep(c(10,11), each = 7)
rep(10, each = 7)
rep("Hello", length.out = 10)
rep("Julia", "Mason", times = 10)
rep(c("Julia", "Mason"), each = 10)
rep(c("Julia", "Mason"), times = 10)
rep(c("Julia", "Mason"), times = c(10, 20))

vector(mode = "numeric", length = 10)
vector(mode = "character", length = 10)
vector(mode = "logical", length = 10)

c(TRUE, FALSE, 23)
c("Julia", FALSE, 89.09)

x <- -10:10
as.null(x)
as.null(x) |> class()
as.numeric(x)
as.numeric(x) |> class()
as.character(x)
as.vector(x)
as.vector(x) |> class()
as.logical(x)
as.logical(x) |> class()

y <- c("Julia", "Ryan", "Dakota")
as.numeric(y)
as.Date(y)
as.logical(y)

list("Ceaser", "Natalie", 1287, 78.76, 2.67e9)
list("Ceaser", "Natalie", 1287, 78.76, 2.67e9) |> unlist()
list("Ceaser", "Natalie", 1287, 78.76, 2.67e9) |> unlist() |> as.vector()

matrix(data = rnorm(400, mean = 12.5, sd = 0.98), nrow = 20)
myMat <- matrix(nrow = 10, ncol = 10)
myMat |> dim()

myMat[10,1] <- 99
myMat

for (i in 1:10){
    for(j in 1:10){
        myMat[i, j] <- i * j
    }
}

myMat
myMat * myMat

vec <- seq(1, 1000, length.out = 1000)
dim(vec) <- c(10, 100)
vec

rbind(1:10, 11:20)
cbind(1:10, 11:20)

# factors are used to store categorical data in R
# factors can be thought as a vector where every element has a label
factor(c(1,0,0,1))
factor(c(1,0,0,1)) |> levels()
unclass(factor(c(1,0,0,1)))       

size <- factor(c("SMALL", "SMALL", "MEDUIM", "LARGE", "LARGE", "MEDIUM", "EXTRALARGE"))
levels(size)
unclass(size)
table(size)
# unclass() strips an object into vectors

# by default R orders factors in ascending order for both numbers & alphabets
factor(rep(c(4,2,3,-19), length.out = 12))
# levels are ordered in ascending order by default

factor(rep(c(9.435,-20,4,56,100)), levels = c(9.435,-20,4,56,100))
# passing levels manually will override the defaults

factor(rep(c("yes", "no"), length.out = 19))
# levels are ordered alphabetically, so no is on the baseline level & yes is on the second level
factor(rep(c("yes", "no"), length.out = 17), levels = c("yes", "no"))


# Missing values
is.na(NA)   # Not available
is.na(NaN)  # Not a number

dummy <- list(1, 35, 89.7657, NA, NA_integer_, NA_real_, NA_character_, NaN)
is.na(dummy)
lapply(dummy, class)
# NAs can be of different classes

lapply(dummy, is.nan)

is.na(NaN)
is.nan(NA)

# NA is NaN
# but NaN is not necessarily NA

data.frame("x" = seq(1, 100, 0.25), "x^2" = seq(1, 100, 0.25)^2, "Name" = rep("Julie", length.out = length(seq(1, 100, 0.25))))
# data frames can have different data types in each columns
# but when coercing such data frames into matrices incompatible data types may be casted

data.frame("x" = seq(1, 100, 0.25), "x^2" = seq(1, 100, 0.25)^2,
           "Name" = rep("Julie", length.out = length(seq(1, 100, 0.25)))) |>
        as.matrix()
# all columns are type casted to strings!!
# matrix is essentially a 2 dimensional array

df <- data.frame(foo = 1:10, bar = rep(c("James", "Ryan"), each = 5))
df |> dim()
nrow(df)
ncol(df)
names(df)

dummy <- list(1,2,3,4,56)
names(dummy)
names(dummy) <- c("One", "Two", "Three", "Four", "Fiftysix")
dummy

# every R object can be named
dummy <- c(1:4)
names(dummy)
# by default R objects have no names
# each element in a vector can be named individually
names(dummy) <- c("Jimmy", "Sarah", "Belle", "Juanita")
dummy

dimnames.data.frame(df)
dimnames(df)

dummy <- matrix(data = 1:16, ncol = 4, nrow = 4)
dummy
dimnames(dummy) <- list(rep("Row", 4), rep("Column", 4))
dummy |> dim()
dummy

# dimnames() for matrix like objects in R
nchar("Julia")
nchar("Alan Turing")


# reading & writing data
# reading in R code files
dget("./library.R") # inverse of dput()
source("./library.R")   # inverse of dump()

# read.table(), read.csv() for reading in tabular data
# readLines() to read in text files line by line into a character vector
# load() for reading saved workspaces
# unserialize() for reading a single R object in binary form

# writing data
# write.table()
# writeLines()
# dump()
# dput()
# save()
# serialize()

# optimize loading large datasets:
# specify the data types for columns
# specify the comment character
# load in first few rows, if data types has to be inferred from the data using the nrows argument
# before loading the entire data frame
# know the system!
# amount of physical memory available
# running processes

# for a data frame with 100000 rows & 120 columns all having integers:
print(paste(64 * 120 * 100000 / 1024 ^ 2, "MiB memory is needed!"))

# due to file read overheads, the computer must at least have a memory
# twice the size of the file to successfully load the data frame

# dump() or dput() will write the data as a text file with metadata of the column data types & 
# the likes, so reading becomes automatically easier as R will infer these metadata for us
# file corruptions in text files are easier to fix compared to tabular data files

df <- data.frame(Names = c("Nathan", "Danielle", "Samantha", "Jacob", "Vincent"),
                 Age = c(23, 25, 19, 28, 20),
                 Married = c(FALSE, FALSE, FALSE, TRUE, FALSE))

getwd()
dput(df, file = "dput.txt")
dget("dput.txt")

dput(df, file = "dput.R")
dget("dput.R")
rm(df)

df <- dget("./dput.txt") |> as.data.frame()
class(df)

dump("df", file = "dump.R")
rm(df)
source("./dump.R")

# connections in R
# file connections
# web connections
# connections are interfaces of R to outside environment

# file()
# gzfile()
# bzfile()
# url()
# used to establish conections

str(file)
connexion <- file("D:/DataSets/Air_Traffic_Passenger_Statistics.csv", open = "r")
read.csv(connexion)
close(connexion)

# connection() is lazy evaluation, it just establishes a connection to the file w/o 
# loading the file into memory
readLines(connexion)
close(connexion)

connexion <- url("https://unccelearn.org/", open = "r")
uncclearn <- readLines(connexion) |> as.character()
close(connexion)
head(uncclearn)


x <- seq(1, 100, 0.25)
x[10]
x[10:50]
x[x >= 98]
x[x >= 90 & x < 20]
x[x >= 90 | x < 10]

y <- rep(c("a", "c", "d", "b"), each = 20)
y["b"]
y[9]
y[y == "c"]
y[y == "a" | y == "c"]
y[y > "b"]

# subsetting lists
x <- list(Names = c("Julie", "Leslie", "Natalie"), Age = c(32, 28, 27))
x
x[1]
class(x)
class(x[1])
class(x[[1]])
x[[1]]

x$Names
x$Age

x["Names"]
x[["Names"]]

x[c(1,2,3)]

Nome <- "Names"
x$Nome
x[[Nome]]

x[[1]][1]
x[[2]][2]

mat <- matrix(data = 1:100, nrow = 10)
mat[1,]
mat[,1]
mat[9,9]    
mat[10,]

mat[5, 5]   # returns a number
mat[5, 5, drop = FALSE]     # returns a 1 x 1 matrix
mat[1, , drop = FALSE]

# partial matching in subsetting
x <- list(anoban = 1:100)
x$a
x[["a"]]
x[["a", exact = FALSE]]

x <- 0:100
x[c(10,19,37,87)] <- NA
x[!is.na(x)]
x[is.na(x)]

y <- 200:300
y[c(56, 23, 87, 45, 54, 98)] <- NA

# getting non-missing indices common for multiple arrays
complete.cases(x, y)
x[complete.cases(x, y)]
y[complete.cases(x, y)]

mat1 <- matrix(data = 1:100, nrow = 10)
mat2 <- matrix(data = 201:300, nrow = 10)

mat1 * mat2     # element wise multiplication
mat1 %*% mat2   # true matrix multiplication

mat1 / mat2     # element wise division
