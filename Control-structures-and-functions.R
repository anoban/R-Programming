x <- 0

while(x > -100){
    print(paste("The value of x is", x))
    x <- x - 1
}

name <- "Leslie Chow"
while(nchar(name) > 1){
    print(name)
    newname <- name |> strsplit(split = "") |> unlist()
    name <<- newname[c(1:nchar(name) - 1)] |> paste0(collapse = "")
    print(name)
}
print(name)
print(newname)

dummy <- matrix(data = 1:100, nrow = 10)
for (i in 1:10){
    for (j in 1:10){
        dummy[i,j] <- sqrt(i^j)
        print(paste("Value at the intersect of", i, "th row &", j, "th column is", dummy[i, j]))
    }
}
dummy

vals <- rbinom(n = 1000, size = 1000, prob = 0.5)
for (i in seq_along(vals)){
    if (i > vals[i]){
        print(paste(i, "is greater than the value at", i, "th index of vals", vals[i]))
    }else if(i == vals[i]){
        print(i)
    }else {
        next
    }
}

for (i in seq(1, 100, 0.5)){
    if (i < 25){
        print("< 25")
    }else if (i < 50){
        print("< 50 & > 25")
    }else if( i == 50){
        next
    }else if(i < 99){
        print("< 99 & > 50")
    }else break
}

installed.packages() |> as.data.frame() |> subset(select = `Package`)

names <- c("Julia", "Natalie", "Sarah", "Leslie", "Jovanne", "Parker", "Sulliavn")

seq_len(10)
seq_along(names)
seq(from = 10, to = 200, by = 0.05)
seq(from = 10, to = 12, length.out = 1000)
seq.int(10, to = 100)
seq.Date(length.out = 100, from = as.Date(strptime("12-03-2021", "%d-%m-%Y")),
         to = as.Date(strptime("31-12-2022", "%d-%m-%Y")))

# nesting beyond 3 levels is usually discouraged
# as is makes readability difficult

x <- seq(1, 100, by = 0.25) 
x[seq(1,100, by = 2)] <- NA

y <- seq.int(1, length.out = 200)
y[seq(1, 50, by = 2)] <- NA

args(nchar)
str(nchar)
nchar

x[is.na(x)]
y[is.na(y)]
x[!is.na(x)]
y[!is.na(y)]

x |> length()
y |> length()

above10 <- function(v){
    return(v[v > 10])
}
above10(seq(1, 100, by = 2))

below10 <- function(v){
    return(v[v < 10])
}
below10(seq(1, 100, by = 1.5))

s <- list(seq(1, 200, by = 0.75))
s[[1]] > 50
s |> unlist() 

is.finite(Inf)
is.infinite(Inf)

above <- function(vec, lim = 100){
    return(vec[vec > lim])
}

above(seq(1, 1000, by = 2.5), 250)
above(seq(1, 200, by = 0.75))

dummy <- matrix(data = rnorm(n = 400, mean = 25, sd = 0.205), nrow = 20)
colMeans(dummy)
rowMeans(dummy)
colSums(dummy)
rowSums(dummy)

computeColMeans <- function(mat){
    avgs <- c()
    for (i in 1:ncol(mat)){
        avgs <- c(avgs, mean(mat[, i]))
    }
    return(avgs)
}

computeColMeans(dummy)
{computeColMeans(dummy) == colMeans(dummy)} |> all(na.rm = TRUE)

all(computeColMeans(dummy) == colMeans(dummy))

args(computeColMeans)

# functions are first class objects in R
# meaning functions can be passed as arguments to functions, assigned to variables & 
# functions can return other functions

formals(mean)

# it is best practice to pass arguments in the expected order even when individually naming the 
# arguments

# unnamed args
mean(1:1000)
mean(c(1:100, NA))

# named arguments
mean(x = c(1:99, NaN), na.rm = TRUE)

# when a function takes many arguments, first all the named arguments are taken out
# and the remaining are inferred for possible names

formals(lm)
args(lm)

dymmyFunc <- function(a, b, c = 0, d = NULL, na.rm = TRUE){
    # function arguments with defaults
}

# R uses lazy evaluation
# function expressions are only evaluated at runtime
# so errors will occur only when the buggy code is executed
# part of the function body before the buggy code will execute just fine
# eg:

mySeq <- function(start, end){
    # end argument is not used in function body
    return(seq(start, to = 100, by = 0.25))
}

mySeq(1)
# works just fine as R matches start = 1 based on the position of the arguments

mySeq(start = 10, end = 300)

printPairs <- function(a, b){
    print(a)
    print(b)
}

printPairs(15)
# here 15 gets printed before an error is raised 
# meaning, error only occurs when the second line of function body is executed
# so R evaluates expression only at their runtime
# that's why the second expression did not cause any errors while the first expression
# was being executed

# ellipsis ... in function arguments
# useful in extending pre-existing functions with user defined defaults or other 
# fixed params
    
paste
mean
cat

# arguments passed after the ... must be explicitly named
# otherwise R cannot infer the names on its own for the arguments following the ellipsis

# each function code is bound to a symbol (function name)
# when a function is called R looks for this symbol in a series of environments
# firstly in the global environment and then in namespaces
# so redefining a function is global environment will override its namespace definitions
    
# lm() is linear model function from the stats:: namespace
stats::lm()

lm <- function(){print("Hello")}

lm()
# there you go ...
# one can prefix the namespace to specifically called the desired function
stats::lm()

search()
# global environment always gets the first precedence while base:: namespace gets the last priority

# Lexical scoping
# hierarchy:
# environment where the function is defined followed by the series of environments in the search() 
# list

# if the function is defined in global environment the top level environment is the global environment
# but if the function comes from a package, the namespace of that function will be the environment 
# with first precedence
    
generate <- function(name = "Alice"){
    # a function that retuns another function
    return(function(verb = "treating"){
        # this function inherits the name variable from the parent function
        return(paste0("How's wonderland ", verb, "ing you ", name, "?"))
    })
}

generate("Jimmy")("beating")
generate()()

func <- generate("Beauty")
func()
args(func)
str(func)

ls(environment(func))
