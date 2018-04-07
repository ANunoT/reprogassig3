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
best <- function (HospitalCode, reqOutcome) {
        
# we know it use outcome-of-care-measures.csv. Let's make sure it exists, if exists read into dataset otherwise error message and stop
        
        if (!file.exists("C:/Users/Nuno/Documents/R-Programming/rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv")) stop(noFile)
        
# lets make sure that the required outcome is one of "heart attack, "heart failure" or "pneumonia", if not one of these then error message and stop.
# the sting compare functions with the strength=2 allows for capitalisation of the required outcome and thus will not error on an required outcome
# that is capitalised
        
        if (stri_cmp_equiv(reqOutcome, "heart attack", strength=2) == FALSE && stri_cmp_equiv(reqOutcome,"heart failure", strength=2) == FALSE && 
            stri_cmp_equiv(reqOutcome,"pneumonia", strength=2) == FALSE) stop(badOutcome) 
        
# At this stage the data file exists and the required outcome is valid. Need to check if state code is correct, but need to load data from file first
# to ensure correct state code. This is the last check and is done only now because there was point in loading data (and use memory) if file did not 
# exist, and if # the requested outcome was invalid. for processing. Then check to ensure that two # character state code id correct.
# Load data into data frame, check that state code is correct by given state code is in column 7 of the file.

OutcomeData <- read.csv("C:/Users/Nuno/Documents/R-Programming/rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv")

uniqueState <- unique(OutcomeData[,7])

print(getState)
       
}