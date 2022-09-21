setwd("D:/R Programming/")
dir("./rprog_data_ProgAssignment3-data/")

DATA <- read.csv("./rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", na.strings = "Not Available")
data |> dim()


# Proper implementations
# Quiz problems

data |> names()
data <- DATA[c("Hospital.Name", "State", "Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack",
       "Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure",
       "Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")]
data <- data |> setNames(c("Hospital.Name", "State", "LME.HeartAttack", "LME.HeartFailure", "LME.Pneumonia"))
data[c("LME.HeartAttack", "LME.HeartFailure", "LME.Pneumonia")] <- 
    apply(data[c("LME.HeartAttack", "LME.HeartFailure", "LME.Pneumonia")],
       FUN = as.numeric, MARGIN = 2)

validateDisease <- function(disease){
    diseases <- c("HeartAttack", "HeartFailure", "Pneumonia")
    bool_vec <- c()
    for (diseaseName in diseases){
        char_vec1 <- diseaseName |> strsplit(split = "") |> unlist() |> tolower()
        char_vec2 <- disease |> gsub(pattern = " ", replacement = "") |> strsplit(split = "") |> unlist() |> tolower()
        if (length(char_vec1) == length(char_vec2) && all(char_vec1 == char_vec2)){
            bool_vec <- c(bool_vec, TRUE)
        }else bool_vec <- c(bool_vec, FALSE)
    }
    if(nchar(paste0("LME.", diseases[which(bool_vec)])) > 4) return(paste0("LME.", diseases[which(bool_vec)]))
}

validateState <- function(state){
    if(state |> toupper() |> is.element(set = {data$State |> unique()})){
        return(TRUE)
    }else{
        return(FALSE)
    }
}

c("heat   attack", "HEART FAILURE", "PneuMOniA") |> sapply(FUN = validateDisease)
c("NY", "WA", "CA", "BRR") |> sapply(FUN = validateState)
validateDisease("heart attack")

best <- function(state, disease){
    if(validateState(state)){
        if(!is.null(validateDisease(disease))){
            message(validateDisease(disease))
            diseseColumn <- validateDisease(disease) |> as.character()
            filteredData <- data |> subset(State == state, select = c("Hospital.Name", "State", diseseColumn))
            filteredData <- filteredData[order(filteredData[, diseseColumn], decreasing = FALSE, na.last = TRUE), ]
            bestHosp <- filteredData[, "Hospital.Name"][as.vector(min(filteredData[, diseseColumn], na.rm = TRUE) == filteredData[, diseseColumn])]
            if(length(bestHosp) > 1){
                return(sort(bestHosp)[1])
            }else return(bestHosp)
        }else stop("Invalid disease!")
    }else stop("Invalid state!")
}

best("TX", "heart attack")
best("TX", "heart failure")
best("MD", "heart attack")
best("WA", "Pneumonia")
best("MD", "pneumonia")
best("BB", "heart attack")
best("SC", "heart attack")
best("NY", "hert attack")
best("NY", "pneumonia")
best("AK", "pneumonia")


data <- DATA[, c("State", "Hospital.Name", "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack",                            
         "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure",
         "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")] |>
    setNames(c("State", "Hospital.Name", "Death.from.Heart.Attack",                            
               "Death.from.Heart.Failure", "Death.from.Pneumonia"))

validateDisease <- function(disease){
    diseases <- c("Heart.Attack", "Heart.Failure", "Pneumonia")
    bool_vec <- c()
    for (diseaseName in diseases){
        char_vec1 <- diseaseName |> gsub(pattern = "\\.", replacement = "") |> strsplit(split = "") |> unlist() |> tolower()
        char_vec2 <- disease |> gsub(pattern = " ", replacement = "") |> strsplit(split = "") |> unlist() |> tolower()
        if (length(char_vec1) == length(char_vec2) && all(char_vec1 == char_vec2)){
            bool_vec <- c(bool_vec, TRUE)
        }else bool_vec <- c(bool_vec, FALSE)
    }
    if(nchar(paste0("Death.from.", diseases[which(bool_vec)])) > 11) return(paste0("Death.from.", diseases[which(bool_vec)]))
}

rankhospital <- function(state, disease, rank){
    if(!is.null(validateDisease(disease))){
        if(validateState(state)){
            diseseColumn <- validateDisease(disease) |> as.character()
            filteredData <- data |> subset(State == state & !is.na(data[, diseseColumn]), select = c("Hospital.Name", diseseColumn))
            filteredData <- filteredData[order(filteredData[, diseseColumn], filteredData[, "Hospital.Name"], decreasing = FALSE, na.last = TRUE), ]
            # print(filteredData)
            if(rank == "best"){
                rank <- 1   
            }else if(rank == "worst"){
                rank <- nrow(filteredData)
            }
            message(rank)
            if(rank > nrow(filteredData)){
                return(NA)
            }else{
                return(filteredData$Hospital.Name[rank] |> as.character())
            }
        }else stop("Invalid state!")
    }else stop("Invalid disease!")
}

rankhospital("NC", "heart attack", "worst")
rankhospital("WA", "heart attack", 7)
rankhospital("TX", "pneumonia", 10)
rankhospital("NY", "heart attack", 7)
rankhospital("TX", "heart failure", 4)
rankhospital("MD", "heart attack", "worst")
rankhospital("MN", "heart attack", 5000)





rankall <- function(disease, rank = "best"){
    if(!is.null(validateDisease(disease))){
        hospital <- c()
        ranks <- c()
        states <- data$State |> unique() |> sort()
        deathCause <- validateDisease(disease) |> as.character()
        message(deathCause)
        data <- data[, c("State", "Hospital.Name", deathCause)][order(data$State, data[, deathCause],
                        na.last = TRUE, decreasing = FALSE), ]
        data <- data |> subset.data.frame(!is.na(data[, deathCause]))
        data |> split.data.frame(f = {data$State |> as.factor()}) |> lapply(FUN = function(df){
                if(rank == "best"){
                    rank <- 1
                }else if(rank == "worst"){
                    rank <- nrow(df)
                }
                ranks <<- c(ranks, rank)
                hospital <<- c(hospital, df[rank, "Hospital.Name"])
            });
        return(data.frame("State" = states, "Hospital.Name" = hospital, "Rank" = ranks))
    }else stop("Invalid disease!")
}


rankall("heart attack", 20)
rankall("heart attack", "best")
rankall("heart attack", "worst")
rankall("pneumonia", "worst")
rankall("heart failure")
rankall("heart attack", 4)
rankall("pneumonia", "worst")
rankall("heart failure", 10)



data[order(data$Death.from.Heart.Failure), ] |> 
    subset.data.frame(State == "NV", select = c("State", "Hospital.Name", "Death.from.Heart.Failure"))



split.data.frame(data, f = as.factor(data$State)) |> names()
split.data.frame(data, f = as.factor(data$State)) |> lapply(FUN = function(df){
    return(df[12, ])
})
tapply(data$Death.from.Heart.Attack, INDEX = as.factor(data$State), FUN = order)
apply(data, MARGIN = 2, FUN = function(col){is.na(col) |> sum()}, simplify = TRUE)




WA <- data |> subset(State == "WA" & !is.na(LME.HeartAttack),
               select = c("Hospital.Name", "State", "LME.HeartAttack")) 
WA[order(WA$LME.HeartAttack, WA$Hospital.Name),]
rankhospital("TX", "heart failure", 4)

DATA[order(DATA$Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,
           DATA$Hospital.Name),] |>
    transform(Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack = {DATA["Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"] |> unlist() |> as.vector() |> as.numeric()}) |>
    subset(State == "WA" & !is.na(Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack),
           select = c(Hospital.Name, State, 
                      Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)) |>
    setNames(c("Hospital.Name", "State", "LME.HeartAttack")) 

DATA |> names() |> sapply(FUN = gsub, pattern = ".", replacement = "", simplify = TRUE) |> unlist() |> as.vector()
DATA |> names() |> sapply(FUN = toupper, simplify = TRUE) |> unlist() |> as.vector()

data[order(data$LME.HeartAttack, data$Hospital.Name), ] |> subset(State == "WA", select = c(State, Hospital.Name, LME.HeartAttack)) |>
    subset(!is.na(LME.HeartAttack)) |> transform(Rank = 1:length(LME.HeartAttack))

data[c("State", "Hospital.Name", "LME.HeartAttack")][order(data$LME.HeartAttack, data$Hospital.Name), ] |>
    subset(State == "WA")
