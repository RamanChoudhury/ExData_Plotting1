library(lubridate)
library(dplyr)

##reading the whole data into a data frame with character colClasses
total_data<-read.table("./household_power_consumption.txt",sep=";",header=T,stringsAsFactors = FALSE)
#total_data<-transform(total_data,Date=dmy(Date),Time=hms(Time),Global_active_power=as.numeric(Global_active_power),Global_reactive_power=as.numeric(Global_reactive_power),Voltage=as.numeric(Voltage),Global_intensity=as.numeric(Global_intensity),Sub_metering_1=as.numeric(Sub_metering_1),Sub_metering_2=as.numeric(Sub_metering_2),Sub_metering_3=as.numeric(Sub_metering_3))
total_data$date_time<-paste(total_data$Date,total_data$Time,sep=" ")
total_data<-transform(total_data,date_time=dmy_hms(date_time))

#Subsetting Data from 1 Feb 2007 & 2 Feb 2007

subset_data<-subset(total_data,dmy(Date)==dmy("1 feb 2007") | dmy(Date)==dmy("2 feb 2007"))

#order the subset data
subset_data<-subset_data[order(subset_data$date_time),]

#transform the rest of the data columns into numeric

subset_data<-transform(subset_data,Global_active_power=as.numeric(Global_active_power))
subset_data<-transform(subset_data,Global_reactive_power=as.numeric(Global_reactive_power))
subset_data<-transform(subset_data,Voltage=as.numeric(Voltage))
subset_data<-transform(subset_data,Global_intensity=as.numeric(Global_intensity))
subset_data<-transform(subset_data,Sub_metering_1=as.numeric(Sub_metering_1))
subset_data<-transform(subset_data,Sub_metering_2=as.numeric(Sub_metering_2))
subset_data<-transform(subset_data,Sub_metering_3=as.numeric(Sub_metering_3))

#Initiate PNG Device

png(filename="plot3.png")

#DRAW PLOT 3
with(subset_data,plot(subset_data$date_time,subset_data$Sub_metering_1,col="black",xlab="",ylab="Energy Sub-Metering",type="n"))
with(subset_data,points(subset_data$date_time,subset_data$Sub_metering_1,col="black",type="l"))
with(subset_data,points(subset_data$date_time,subset_data$Sub_metering_2,col="red",type="l"))
with(subset_data,points(subset_data$date_time,subset_data$Sub_metering_3,col="blue",type="l"))

#draw Legend
legend("topright",pch="__",col=c("black","red","blue"),legend=c("Sub-metering_1","Sub-metering_2","Sub-metering_3"))

#switch off device
dev.off()