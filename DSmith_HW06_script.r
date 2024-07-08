### DSmith_HW06_script.r
### C:\Users\dustin.smith\Documents\Codes\R\Stat 604
### Created by, Dustin Smith
### Creation Date: 2023-02-7 1:13
### Purpose: To complete HW06. We will be merging July22 and July21 data and build graphics for it. 
### Last executed: "2023-02-16 13:17:32 CST"

Sys.time()

#1 Housekeeping
objects()
rm(list=ls())
objects()

#2 Load the workspace HW_05.Rdata, and display it
load("C:/Users/dustin.smith/Documents/Codes/R/R-Path Files/HW05.RData")
objects()

#3 Edit the data.frame DailyTempSwing to an easier name, and to append 21 to their column names.
colnames(DailyTempSwing)[c(5:8,10)] <- paste(colnames(DailyTempSwing[c(5:8,10)]),"21",sep="")
###old attempt###  colnames(DailyTempSwing)[c(5:8,10)] <- toupper(c("PRCP21","TAVG21","tmax21","Tmin21","Tempswing21"))
july21<-(DailyTempSwing) #renamed for convinece 
head(july21) #to check that it worked

#4 Append a TempSwing to July22 with the with() function. Append year 22 to specified values
july22$DailyTempSwing <- with(july22, TMAX-TMIN)
colnames(july22)[4:9] <- paste(colnames(july22[4:9]),"22",sep="")
###old attempt### colnames(july22)[4:9] <- toupper(c("awnd22","prcp22","tavg22","tmax22","tmin22","DailyTempSwing22"))

#4b Append the DAY to July22
#ifelse(nchar(july22$DATE)==9,july22$DAY <- c(substr(july22$DATE,3,4),0)) This gives me one too many rows to add....
july22$DAY <- c(substr(as.Date(july22$DATE,format='%m/%d/%Y'),9,10))

#5 Merge the two data frames removing "DATE" and "AWND22"
df<-merge(july21[,c(-4)],july22[,c(-3,-4)],all=FALSE) 
str(df)

#5bCreate a new Two year difference in Max temp column, and display the Maximum and Minimum. 
df$TwoYrTMAXDiff<-with(df,(TMAX22-TMAX21))
(max <- with(df, max(TwoYrTMAXDiff,na.rm=TRUE)))
(min <- with(df, min(TwoYrTMAXDiff,na.rm=TRUE))) #this shows the maximum where 2021 was hotter then 2022
(actualmin <- with(df, min(abs(TwoYrTMAXDiff),na.rm=TRUE))) #this is the true minimum difference in temperature between the two years. 

#6 Open a pdf document to write to. Set Margins to 8.5x11
pdf("C:/Users/dustin.smith/Documents/Codes/R/R-Path Files/DSmith_HW06_output.pdf",11,8.5)

#7 create a histogram of TwoYrMaxDIff
hist(df$TwoYrTMAXDiff,breaks=c(seq(-24,32,by=2)),xlab="Degrees",main="July 2022 vs 2021 Texas Maximum Temperatures",freq=FALSE)

#8Colors!!!! and adding the normal to the graph. 
palette()
mean <- mean(df$TwoYrTMAXDiff, na.rm=TRUE)
sd <- sd(df$TwoYrTMAXDiff, na.rm=TRUE)
x <- seq(-24,34,.01)
lines(x,dnorm(x,mean,sd),col="#DF536b",cex=2)

#9 Add the mean and median lines to the graph
abline(v=mean,col="#28E2E5",lwd=2)
abline(v=median(df$TwoYrTMAXDiff,na.rm=TRUE),col='darkblue',lwd=2)

#10 construct a correlation model for the data
plot(df$ELEVATION,df$TMAX22,pch=8,main="Texas Temperature Analysis",xlab="Elevation",ylab="Maximum Daily Temperature",col="#f97b06")
points(df$ELEVATION,df$TMAX21,pch=4,col="#036a24")

#11,12 add best fit lines to the graph
abline(lm(df$TMAX22~df$ELEVATION),lwd=2)
abline(lm(df$TMAX21~df$ELEVATION),col="yellow",lwd=2)
summary(lm(df$TMAX22~df$ELEVATION))

#13 create a box plot of TMAX22 This creates a single "plot but I need many...
boxplot(df$TMAX22~df$DAY, col="maroon", main="Texas Temperatures vs. College Station by Day",range=0,xlab="DAY",ylab="Degrees")

#14 
mask <- grep("^College Station",df$NAME,ignore.case=TRUE)
CSlist <- data.frame(df$DAY[mask],df$TMAX22[mask])
#points(CSlist[88:118,1],CSlist[88:118,2],pch=18,cex=2) this line is too complex then needed.
points(CSlist,pch=18,cex=2,col="steelblue")

#15 close the pdf file
graphics.off()
save.image("C:/Users/dustin.smith/Documents/Codes/R/R-Path Files/HW06.RData")

###Questions
#A This is a tricky question. There is at least one day where there is 0 difference between each years TMAX. However, if we apply the formula TMAX22-TMAX21;
# we would find the lowest value to be -21. However, this would indicate that July21 was actually hotter than July22 indicating a larger absolute difference. 
#thus 0 would the lowest absolute difference in temperature.

#B The Maximum Temperatures is close to a normal curve.It does display a general shape of the normal curve, and seems to obey 3 sigma’s above and below of the center. 
#The data is also relatively symmetric. However, there is some very slight skewness towards the right as we can see the small difference in the mean and median values. 
#Which is why the mode is just to the left of the actual mean. Thus, I believe that another distribution would fit the data better than a Normal curve. 
#That slight change makes me think that a Gamma distribution would be a better fit. 

#C Based completely on the graphic, it appears that the graph has a very slight negative correlation to Elevation and Maximum Daily Temperature. However, as the data
#itself is very spread out from each line, particularly in the lower elevations, the correlation value would be very weak. I would almost guess if a Pearson’s correlation coefficient
# was found it would be in the neighborhood of -.1 to 0. However, if we remove the lower elevations (being less than 250), we may see a slightly stronger negative correlation. 
# there does appear to be some consistent negative motion in Max temperature and elevation following that the higher elevations. But again, it seems very small.

#D The summary function indicated that the y-intercept hit at 99.9845025

#E College Station was, in general, living within the top 75 percentile of the heat index. Usually living just above the 3rd Quartile. There were 22 days where College Station 
#ranked in the top 25% of hottest cities in Texas. On July 10, it appears that College Station was the hottest city in Texas. College Station also only dropped in the bottom 50% of 
#hottest cities 3 times, with one being on the median value. 

#F College Station was the hottest city in the state on July 10.
