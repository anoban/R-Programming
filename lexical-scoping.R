x <- 0
x <<- 100

functionCreate <- function(n){
    name <<- n
}

functionCreate(n = 101)

callCreate <- function(value){
    functionCreate(value)
}

callCreate(12)

makeVector <- function(x = numeric()) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setmean <- function(mean) m <<- mean
    getmean <- function() m
    list(set = set, get = get,
         setmean = setmean,
         getmean = getmean)
}

dummyVector <- makeVector()
dummyVector$get()
dummyVector$set(seq(1, 100, by = 0.10))
dummyVector$get()
dummyVector$getmean()
dummyVector$setmean()

ls(environment(fun = makeVector))

cachemean <- function(x, ...) {
    m <- x$getmean()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- mean(data, ...)
    x$setmean(m)
    m
}

cachemean(dummyVector)
ls(envir = .GlobalEnv)
