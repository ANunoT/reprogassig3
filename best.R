# R Programming Assignment 3 exercise 2
#07/04/2018 Alberto Nuno Teixeira
#Version:1
# best (x, y)
# x= 2 character abreviated name of state
# y= outcome required, one of "heart attack", "heart failure" or "pneumonia"
# returns character vector containing name of hospital of best outcome in 30 day mortality based on the outcome (y).
# Hospitals without outcome data are to be excluded
# If there is a tie, hospital names are to be sorted alphabetically and ony the first gets returned.
# Need to check for validy to arguments (x and y)
# uses stringi library
#Uses outcome-of-care-measures.csv
#

# ensure string library is loaded
library(stringi)

#Set some error messages
noFile <- "File does not exist or cannot be found in working directory"
badState <- "Invalid state!"
badOutcome <- " Invalid outcome!"

# set the function
best <- function (stateCode, reqOutcome) {
        
# we use outcome-of-care-measures.csv. Let's make sure it exists, if not exist error message and stop
        
        if (!file.exists("C:/Users/Nuno/Documents/R-Programming/rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv")) stop(noFile)
        
# lets make sure that the required outcome is one of "heart attack, "heart failure" or "pneumonia", if not one of these then error message and stop.
# The string compare functions with the strength=2 allows for capitalisation of the required outcome and thus will not error on an outcome
# that is capitalised or has mixed capitals. This also sets the working column for the data as per the document describing the data file.
        
        if (stri_cmp_equiv(reqOutcome, "heart attack", strength=2) == TRUE) {
                workingColumn <- 11
        } else
                if(stri_cmp_equiv(reqOutcome,"heart failure", strength=2) == TRUE) {
                        workingColumn <- 17
                } else
                        if (stri_cmp_equiv(reqOutcome,"pneumonia", strength=2) == TRUE) {
                                workingColumn <- 23
                        } else
                                stop(badOutcome)
        

# At this stage the data file exists and the required outcome is valid. Need to check if state code is correct, but need to load data from file first
# to get available states. This is the last check and is done only now because there was point in loading data (and use memory) if file did not 
# exist, and if the requested outcome was invalid. Load data into data frame.

OutcomeData <- read.csv("C:/Users/Nuno/Documents/R-Programming/rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv")

# lets get a list of unique states, then check if the state argument exists in state list. The argument is forced to upper case, ensuring there are no 
#issues with capitalisation.

uniqueState <- unique(OutcomeData[,7])

        if (!toupper(stateCode) %in% uniqueState) stop(badState)


# At this stage all ready for processing. Now lets get data that meets the state and the outcome from the data.frame (OutcomeData)

workingStateData <- subset(OutcomeData, OutcomeData[,workingColumn] != "Not Available" & OutcomeData$State==toupper(stateCode))
workingStateData <- data.frame(workingStateData$Hospital.Name, workingStateData[,workingColumn])

print(workingStateData)

workingStateData <- workingStateData[workingStateData == min(as.numeric(workingStateData[,2])),]

print(workingStateData)
workingStateData <- workingStateData[order(workingStateData[,1], na.last = FALSE),]


return(as.data.frame(workingStateData[1,1]))
 
}
