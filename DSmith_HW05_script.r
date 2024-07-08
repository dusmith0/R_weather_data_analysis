### DSmith_HW05_script.r
### C:\Users\dustin.smith\Documents\Codes\R\Stat 604
### Created by, Dustin Smith
### Creation Date: 2023-01-29 15:15
### Purpose: To complete HW05. To inport various files, edit them as data frames and count differen pieces of data in each data frame.  
### Last executed: "2023-01-31 16:33:36 CST"
Sys.time()

#housekeeping
objects()
rm(list=ls())
objects()

setwd("C:/Users/dustin.smith/Documents/Codes/R/R-Path Files")
dir()

#load and evaluate the climate .rdata workspace
load("climate.RData") #fill path is C:/Users/dustin.smith/Documents/Codes/R/R-Path Files/climate.RData
search()
objects()
str(july21)

#Append a "Day" Column to the end of the df, then display the first 15 rows of data.
july21$DAY <- c(substr(july21$DATE,9,10)) #I think I can just use this line instead. I had four other lines that also worked, but seemed excessibly long.
july21[1:15,]

#Counting the number of 100+ Days
sink("100 plus logical.txt",split=F)
x <- july21$TMAX >= 100; print(x)
x <- x[!is.na(x)]
sink()
sum(as.integer(ifelse(x == TRUE, 1, 0))) 


#open and view the file July22.txt
july22 <- read.csv("C:/Users/dustin.smith/Documents/Codes/R/R-Path Files/July22.txt",sep="\t")
str(july22)
summary(july22)

#Find number of days with 100+ degrees, using the method above
sink("100 plus locial.txt",split=F)
y <- july22$TMAX >= 100 ; print(y)
sink()
sum(as.integer(ifelse(na.omit(y)==TRUE,1,0))) #I am trying to remove na with out the extra line above. This seemed to work.

#Use the apply fucntion to find the max value in each of the columns
apply(july22[,4:8],2,max,na.rm=TRUE)

#Display the top 100 Station Date and TMAX values
top100 <- order(july22$TMAX,na.last=T,decreasing=T)[1:100]
top <- data.frame(july22$STATION[top100],july22$DATE[top100],july22$TMAX[top100])
colnames(top) <- c("STATION","DATE","TMAX")  #This worked but there must be a better way of going about it. 
print(top)

# Extract only the data connected to or starting with College
july22[grep("^College",july22$NAME,ignore.case=T,value=F),]

#Open and read the file elevations.cvs. Find its structure, summary, and display the first set of data. 
elevation <- read.csv("C:/Users/dustin.smith/Documents/Codes/R/R-Path Files/elevations.csv")
str(elevation)
summary(elevation)
elevation[1:10,]

#Create new data frames combining elevations with weather from july21
MDF <- merge(elevation[,c(1,2,5)],july21[,-2],all=FALSE) #Matched Data Frame the -2 indecies did not seem to matter.

#Create a new data frame with all feilds not just matching fields
ACDF <-  merge(elevation[,c(1,2,5)],july21,by="STATION",all=TRUE)

#Compare the structure of both data frames
str(MDF)
str(ACDF)  #It seems that ACDF has one more column and 12529 more rows

#attach the columns of the data frame to the workspace of R, and display them through search
search()
attach(MDF) #Apparently that is all that needs to be done?
search()

#Create a final Data Frame that contains the difference in TMAX and TMIN
DailyTempSwing <- data.frame(STATION,NAME,(TMAX-TMIN))
colnames(DailyTempSwing)[3] <- "TEMPSWING"
summary(DailyTempSwing$TEMPSWING) 
DailyTempSwing[1:15,]


#Remove the MDF from the data frame, and clean up the workspace
detach(MDF)
objects()
rm(july21,elevation)

#Save the workspace
save.image("C:/Users/dustin.smith/Documents/Codes/R/R-Path Files/HW05.RData")

### Questions
#A There were 407 days above 100 dgrees in july 2022, whereas there were 5995 in July 2021. That is a difference of 5588. That is a huge difference. 

#B It seemed to delete or ignore the redundent row. I did not see a differnece in the script on line 65 when the index of [-2] was used and when it was not. Both seemed to return a data.frame without the
      #repeated column. 

#C Attaching MDF or Matched Data Frame places the data for MDF into the workspace of R. Thus it enabled me to call on each part of the data.frame without renferecing the data.frame itself. 
      #it allowed me to call on individual rows and columns in the for applications later. I actually had quite a bit of problems with the attach() fucntions. I had at first assumed that I needed to 
      #attach each row and column individually, but I could not determine how to do this. After just trying the attach(MDF). I only learned that I did not need to attached them indviually when I begin playing with 
      #the attached MDF in the workspace.

#D In July 2022 the three hottest days and stations are the following:
    #Score   Station       Date   Temp
    # 1   USC00416740   7/20/2022 115
    # 2   USW00013966   7/19/2022 115
    # 3   USR0000TMAA   7/19/2022 115

    #In July 2021 there was only one date that had the hottest day of the month. No ties. I re-ran my script on lines 50-53 for july21. It should be returnded back to the original.
    #Score   Station       Date     Temp
    #1     USC00417624  2021-07-25  111
