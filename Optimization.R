# figuring out the minimum & maximum ranges for optimum performance for a function

optimize(f = factorial, interval = seq(1, 200, by = 1))

# other optimization functions are optim() & nim()

# when optimizing functions, it helps to fix certain parameters and optimize others
# Lexical scoping can be helpful here

# one can use a constructor function to return a customizeable function
# where the constructor function can be leveraged to fixate the needed parameters!
# so all the child functions returned by the constructor function will inherit the variables defined in the
# scope of the parent function!!

calculate.power <- function(n = 2){
    return(function(v){
        return(Map(f = `^`, v, n)[[1]])
    })
}

square <- calculate.power(2)
square(10)
square(200)

environment(square) |> ls()

calculate.power(3)(4)

make.negative.log.likelihood <- function(data, fixed = c(FALSE, FALSE)){
    params <- fixed     # capturing the args/defaults
    return(function(p){
        params[!fixed] <- p     # assigning the elements of params whose indices evaluate to FALSE in
                                # fixed to the values of p
        mu_ <- params[1]
        sigma_ <- params[2]
        a <- -0.5 * length(data) * log(2 * pi * (sigma_ ^ 2))
        b <- -0.5 * sum((data - mu_) ^ 2) / (sigma_ ^ 2)
        return(-(a + b))
    })
}

set.seed(2022 - 8 - 19)
normals <- rnorm(n = 100, mean = 1, sd = 2)     # data for the make.negative.log.likelihood function

nLL <- make.negative.log.likelihood(data = normals)     # using the defaults for fixed

nLL
ls(environment(nLL))

optim(par = c(mu_ = 0, sigma_ = 1), nLL)

# optimize() can only optimize a single parameter
# optim() can optimize multiple parameters

f <- function(x) {
    g <- function(y) {
        y + z
    }
    z <- 4
    x + g(x)
}

z <- 10
f(3)
