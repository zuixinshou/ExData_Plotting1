## plot4.R draw the fourth picture
plot4<-function(dir="./household_power_consumption.txt"){
  library("lubridate")
  library(dplyr)
  ##read colnames from line 1 of the text
  
  colnames<-read.table(dir,header=F,
                       nrows=1,sep=";",na.string="?",stringsAsFactors=F)
  ##read data from 1/2/2007 to 2/2/2007 of the text
  electricdata<-read.table("household_power_consumption.txt",
                           header=F,skip=66637,nrows=2880,sep=";",
                           na.string="?",stringsAsFactors=F)
  electricdata<-tbl_df(electricdata)
  ##write colnames
  colnames(electricdata)<-colnames[1,]
  ## generate new col datetime 
  electricdata<-mutate(electricdata,datetime=dmy_hms(paste(Date,Time,sep=" "),tz="GMT"))
  ## create and open png device
  png("plot4.png",width=480,height=480)
  ## draw picture
  par("mfrow"=c(2,2))
  ## first smaller picture
  plot(electricdata$datetime,electricdata$Global_active_power,type="l",
       ylab="Global Active Power",xlab="")
  ## second smaller picture
  plot(electricdata$datetime,electricdata$Voltage,type="l",
       ylab="Voltage",xlab="datetime")
  ## third smaller picture
  plot(electricdata$datetime,electricdata$Sub_metering_1,
       ylab="Energy sub metering",xlab="",type="l")
  points(electricdata$datetime,electricdata$Sub_metering_2,col="red",type="l")
  points(electricdata$datetime,electricdata$Sub_metering_3,col="blue",type="l")
  legend("topright",col=c("black","red","blue"),
         legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
         pch="——",bty="n")
  ## fourth smaller picture
  plot(electricdata$datetime,electricdata$Global_reactive_power,type="l",
       xlab="datetime",ylab="Global_reactive_power")
  ## close device
  dev.off()
}

