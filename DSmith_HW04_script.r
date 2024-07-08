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


### Create an output path for the script, and set the appropriate directory.
setwd("C:/Users/dustin.smith/Documents/Codes/R/R-Path Files")
dir() #To check on the files already there
sink("DSmith_HW04_script.csv",split=T)

### Create First Sequence named FSeq
(FSeq <- seq.int(4,80,4))  #FSeq = First sequence in the assignment 
mode(FSeq)
class(FSeq)
print(FSeq[c(2,4:6)])  #I could ignore the print() but I like it from python

### Create a Second Sequence named SSeq
(SSeq <- seq.int(.5,20,.5))  #SSeq = Second sequence in the assignment 
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
