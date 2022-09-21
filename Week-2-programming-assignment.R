getwd()
setwd("D:/R programming/")

pollutantMean <- function(directory, pollutant, ids = 1:332){
    dir_ids <- dir("./specdata") |> strtrim(3)
    head_counter <- 0
    for (id in dir_ids){
        if(is.element(el = as.numeric(id), set = ids)){
            if(head_counter == 0){
                data <- read.csv(file = paste0(directory, id, ".csv"), header = TRUE)
                head_counter <- head_counter + 1
            }else if(head_counter > 0){
                data <- rbind(data, read.csv(file = paste0(directory, id, ".csv"), header = TRUE))
            }
        }
    }
    return(data |> subset(select = pollutant) |> unlist() |> mean(na.rm = TRUE))
}

pollutantMean(dir = "./specdata/", "sulfate", 1:80)

# cross checking
data <- data.frame()
for (file in dir("./specdata")){
    data <- rbind(data, read.csv(paste0("./specdata/", file), header = TRUE))
}

dim(data)

data |> subset(ID < 81, select = sulfate) |> colMeans(na.rm = TRUE)

complete.cases(data) |> sum()


completeRows <- function(directory, ids = 1:322){
    id <- c()
    complete <- c()
    for (file in dir(directory)){
        if(is.element(el = as.numeric(strtrim(file, 3)), set = ids)){
            id <- c(id, as.numeric(strtrim(file, 3)))
            csv <- read.csv(paste0(directory, file), header = TRUE)
            complete <- c(complete,  csv |> complete.cases() |> sum())   
        }
    }
    return(data.frame("id" = id, "nobs" = complete))
}

completeRows(directory = "./specdata/", ids = 1:10)
completeRows(directory = "./specdata/", ids = 1:100)



correlation <- function(directory , threshold = 0){
    label_id <- c()
    corr_vec <- c()
    for (file in dir(directory)){
        data <- read.csv(paste0(directory, file), header = TRUE)
        if({complete.cases(data) |> sum()} > threshold){
            label_id <- c(label_id, as.numeric(strtrim(file, 3)))
            corr_vec <- c(corr_vec, cor(data$sulfate, data$nitrate, use = "pairwise.complete.obs"))
        }
    }
    names(corr_vec) <- label_id
    return(corr_vec)
}

correlation("./specdata/", 150)
correlation("./specdata/", 150) |> summary()
correlation("./specdata/", 400)
correlation("./specdata/", 400) |> summary()
correlation("./specdata/", 5000)



############################## Questions ###########################################
pollutantMean(directory = "./specdata/", "sulfate", 1:10)
pollutantMean(directory = "./specdata/", "nitrate", 70:72)
pollutantMean(directory = "./specdata/", "sulfate", 34)
pollutantMean(directory = "./specdata/", "nitrate")

cc <- completeRows("./specdata/", c(6, 10, 20, 34, 100, 200, 310))
print(cc$nobs)
completeRows("./specdata/", 54)$nobs

RNGversion("3.5.1")  
set.seed(42)
cc <- completeRows("./specdata/", 332:1)
use <- sample(332, 10)
print(cc[use, "nobs"])



cr <- correlation("./specdata/")                
cr <- sort(cr)   
RNGversion("3.5.1")
set.seed(868)                
out <- round(cr[sample(length(cr), 5)], 4)
print(out)


cr <- correlation("./specdata/", 129)                
cr <- sort(cr)                
n <- length(cr)    
RNGversion("3.5.1")
set.seed(197)                
out <- c(n, round(cr[sample(n, 5)], 4))
print(out)


cr <- correlation("./specdata/", 2000)                
n <- length(cr)                
cr <- correlation("./specdata/", 1000)                
cr <- sort(cr)
print(c(n, round(cr, 4)))
