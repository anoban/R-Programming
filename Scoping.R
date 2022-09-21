search()

sqrt <- function(n){
    return(n ^ 0.5)
}

sqrt(20)
args(sqrt)

base::sqrt(20)
args(base::sqrt)

# Lexical scoping

addVals <- function(x, y){
    return(x + y)
}

addVals(10, 23)
x <- 90
addVals(, 10)
y <- 111
addVals(5, )

addVals <- function(x, z){
    print(x)
    print(y)
    return(x + y + z)
}

y <- 197
addVals(10, 73)

myfunc <- function(n){
    x <- 100
    return(function(){
        return(sqrt(n * x))
    })
}

myfunc(20)()

x <- 40

myfunc(20)() == sqrt(40*20)


myfunc <- function(){
    x <- 100
    return(function(){
        return(sqrt(n * x))
    })
}

myfunc()()
n <- 25
myfunc()()

callee <- function(m){
    o <- 100
    return(m * o)
}

callProc <- function(n){
    return(callee(n))
}

callProc(20)

o <- 22.765
callProc(20)

ls(environment(callee))
ls(environment(callProc))


