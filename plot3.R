## plot3.R draw the third picture
plot3<-function(dir="./household_power_consumption.txt"){
  library("lubridate")
  library(dplyr)
  ##read colnames from line 1 of the text
  
  colnames<-read.table("household_power_consumption.txt",header=F,
                       nrows=1,sep=";",na.string="?",stringsAsFactors=F)
  ##read data from 1/2/2007 to 2/2/2007 of the text
  electricdata<-read.table("household_power_consumption.txt",
                           header=F,skip=66637,nrows=2880,sep=";",
                           na.string="?",stringsAsFactors=F)
  electricdata<-tbl_df(electricdata)
  ##write colnames
  colnames(electricdata)<-colnames[1,]
  ## generate new col datetime 
  electricdata<-mutate(electricdata,datetime=dmy_hms(paste(Date,Time,sep=" ")))
  ## create and open png device
  png("plot3.png",width=480,height=480)
  ## draw picture
  plot(electricdata$datetime,electricdata$Sub_metering_1,
       ylab="Energy sub metering",xlab="",type="l")
  points(electricdata$datetime,electricdata$Sub_metering_2,col="red",type="l")
  points(electricdata$datetime,electricdata$Sub_metering_3,col="blue",type="l")
  legend("topright",col=c("black","red","blue"),
         legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
         pch="——")
  ## close device
  dev.off()
}

