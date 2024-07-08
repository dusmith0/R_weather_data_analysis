### DSmith_HW06_script.r
### C:\Users\dustin.smith\Documents\Codes\R\Stat 604
### Created by, Dustin Smith
### Creation Date: 2023-02-11 3:15
### Purpose: To complete HW07. We will be merging July22 and July21 data and build graphics for it. 
### Last executed: "2023-02-12 15:03:51 CST"
Sys.time()

# Housekeeping
objects()
rm(list=ls())
objects()

#1 Load the previous work space
load("C:/Users/dustin.smith/Documents/Codes/R/R-Path Files/HW06.RData")
ls()

#2Open a pdf file
pdf("C:/Users/dustin.smith/Documents/Codes/R/R-Path Files/DSmith_HW07_output.pdf",11,8.5)


#3 Create a bar plot to see how many times various stations reached above 100 degrees. 
par(mfrow=c(1,2),oma=c(0,0,2,0))
hot21 <- df$TMAX21[df$TMAX21 >= 100]
hot21 <- hot21[!is.na(hot21)]
barplot(table(hot21),xlab="Degrees F",ylab="Station Days",main="July 2021",ylim=c(0,1000))

hot22 <- df$TMAX22[df$TMAX22 >= 100]
hot22 <- hot22[!is.na(hot22)]
barplot(table(hot22),xlab="Degrees F",ylab="Station Days",main="July 2022")#is plotting each day seperately

mtext("Comparison on 2021 and 2022 Days over 100 Degrees",side=3,outer=TRUE)

par(mfrow=c(1,1))

#4 Open the Bit data, and create a loop that calculates the EMA values for the BitCoins in the last 260 days. (last year)
bit<-data.frame(read.csv("C:/Users/dustin.smith/Documents/Codes/R/R-Path Files/BTC-USD.csv"))
str(bit)

#5a-bCreate values for use in the EMA loop
N <- 7 
alpha <- 2/(1+N)
EMA <- c(rep(0,2921))
#View(EMA)

#5c Edit the 7th value for at starting point with the frist 7day average. 
EMA[7] <- with(bit,mean(Close[1:7]))
EMA[7]

#5d Create the for loop
for(i in (8:length(bit$Close))){
	EMA[i] <- ((bit$Close[i]*alpha)+EMA[i-1]*(1-alpha))} #end of loop

#5e plot the last 260 days. 
par(bg="grey90")
plot(c(1:260),(EMA[(length(EMA)-259):length(EMA)]), type = "l", main="7 Day EMA and Actual Prices", xlab="Days", ylab="Closing Price", col="blue")
# I had a hard time with the indexing here... /I forgot that the -259 would remove data... oops.

#5f #print the equation.... I hated this part... the parentesis took me nearly 2hours to get right. Also I had to use cex of .45 not .95 to get the same scale as the image on the assingment. 
text(x=0, y=25000, expression(paste(EMA[i]==(P[i]*x*alpha)+(EMA[i-1]*x*(1-alpha)),"where",~~~alpha==frac(2,(1+7)))),  adj = 0, cex=.6)


#4g plot the actual Close line
lines(c(1:260),(bit$Close[(length(bit$Close)-259):length(bit$Close)]),col="red")

#Create a function to do all the above
plotEMA <- function(data,startingmean=7,days=260){
	N <- startingmean
	alpha <- 2/(1+N)
	EMA <- c(rep(0,length(data$Close)))

	EMA[startingmean] <- with(data,mean(Close[1:startingmean]))

	for(i in ((startingmean + 1):length(data$Close))){
		EMA[i] <- ((data$Close[i]*alpha)+EMA[i-1]*(1-alpha))} #end of loop
	#return(EMA)
	par(bg="grey90")
	plot(c(1:days),(EMA[(length(EMA)-(days-1)):length(EMA)]), type = "l", main=paste(startingmean,"Day EMA and Actual Prices"), xlab="Days", ylab="Closing Price", col="blue")
	lines(c(1:days),(data$Close[(length(data$Close)-(days-1)):length(data$Close)]),col="red")
	text(x=0, y=25000, bquote(paste(EMA[i]==(P[i]*x*alpha)+(EMA[i-1]*x*(1-alpha)),"where",~~~alpha==frac(2,(1+.(startingmean))))),  adj = 0, cex=.6)

} #End function

#7 Set up a new graphic
par(mfrow=c(1,2),omi=c(.5,.5,1,.5),mar=c(4,4,2,0))

#8 
plotEMA(bit)
set.seed(9172014)
plotEMA(bit,20,sample(c(260:length(bit$Close)),1))

#9 add the run time at the bottom of the graph. 
mtext(Sys.time(),side=1,outer=TRUE,adj=0) 

graphics.off()
save.image("C:/Users/dustin.smith/Documents/Codes/R/R-Path Files/HW07.RData")
##### Questions

#A The purpose of setting the July21 ylim to 1000 was to ensure that the graph matches that of July22. Graphs of different 
#scales can be quite misleading in nature. In this case we wanted to see that there was a significant difference in high temps 
#in 2021 and 2022. Keeping the given scales would incorrectly imply that 2021 has an equal number of hot days.

#B There is a clear difference in the number of hot days in each year. After the scale is set correctly, it is clear that 2021 has almost no 
#100+ days compared to 2022. In fact, the number of days at 100 in 2021 is about the same amount as those at 106 degrees in 2022.

#C The red line (Actual Price) hits the highest value in the 20 day plot. It seemed to hit at just under the 1500 day mark.

#D The EMA and Price had an almost constant drop in value from around 100 days to 175 days. 

