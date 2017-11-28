## plot2.R draw the second picture
plot2<-function(dir="./household_power_consumption.txt"){
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
  png("plot2.png",width=480,height=480)
  ## draw picture
  plot(electricdata$datetime,electricdata$Global_active_power,type="l",
       ylab="Global Active Power(kilowatts)",xlab="")
  ## close device
  dev.off()
}
