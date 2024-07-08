### DSmith_HW04_script.r
### C:\Users\dustin.smith\Documents\Codes\R\Stat 604
### Created by, Dustin Smith
### Creation Date: 2023-01-23 21:08
### Purpose: To create and edit Vectors, and export the values to a .csv or .tst file
### Last executed: "2023-01-24 20:25:36 CST"
Sys.time()

### Housekeeping---Checking objects, clearing objects, and checking libraries
objects()
rm(list=ls()) ; objects()
search()

### Finding a function to preform sequence generation
#??SequenceGeneration
    #seq(from = #, to = #, by = ((to-from)/(length.out-1)))

### Create an output path for the script, and set the appopriate directory.
setwd("C:/Users/dustin.smith/Documents/Codes/R/R-Path Files")
dir() #To check on the files already there
sink("DSmith_HW04_script.csv",split=T)

### Create First Sequence named FSeq
(FSeq <- seq.int(4,80,4))  #FSeq = First sequence in the assingment 
mode(FSeq)
class(FSeq)
print(FSeq[c(2,4:6)])  #I could ignore the print() but I like it from python

### Create a Second Sequence named SSeq
(SSeq <- seq.int(.5,20,.5))  #SSeq = Second sequence in the assingment 
mode(SSeq)
class(SSeq)
print(SSeq[c(1:10)])

#Create two matricies appeneded via rows then columns. 
print(matrix1 <- rbind(FSeq,SSeq))
print(matrix2 <- cbind(FSeq,SSeq))

#Create a new vector of Stanley Cup Hocky Playoffs 
playoffs <- c(3,4,4,3,4,2,3,4,3,4,2,4,0,4,3)
summary(playoffs)
length(playoffs)

#Create a vector of playoff teams
playoffteams <- c('Bruins', 'Hurricanes',
'Lightning', 'Maple Leafs', 'Blues', 'Wild', 'Kings', 'Oilers', 'Penguins', 'Rangers', 'Capitals',
'Panthers', 'Predators', 'Avalanche', 'Stars')
summary(playoffteams)
length(playoffteams)

#Append a new value at the end of playoffs vector
(playoffs[16] <- 4)
summary(playoffs)

#Append the team Flames to playoffteams
playoffteams <- c(playoffteams,"Flames")

#Create a data.frame of Playoff games vs Playoff Teams
data.frame(playoffteams,playoffs)

# Use a logical test to 'mask' the teams who played exactly 2 games in the playoffs
playoffs[playoffs == 2]
(playoffteams[playoffs == 2])

#This will close the output file after we are finished. 
sink()

##### Answers to the HW04 Questions
#A) Seven packages are loaded in my R Session. Nine objects are given, but two appear to not be packages.
#B) The mode of FSeq in step 4 is "numeric". 
#C) The first vector's (FSeq) values will be placed into the martix's first column,
    #;where each value is being added into row section of the matrix
#D) The summaries of playoffs in step 8 and playoffteams in step 9 are very different. The second (teams) is a vector of characters;
    #whereas the frist (playoffs) is a vector of numerical values. Therefor, the summary in step 8 produced the 'five number summary' of statistical values, as well as the mean.;
    # The second (teams) summary only provided the Class, Mode, and Length of the vector. 
#E) The teams are the "Wild" and "Capitals"