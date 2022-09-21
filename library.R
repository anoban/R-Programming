factorialRecursive <- function(n){
    while(n > 0){
        if(n >= 2){
            return(n * factorialRecursive(n - 1))    
        }else if(n == 1){
            return(1)
        } 
    }
}
