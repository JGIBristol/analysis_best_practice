
##I added this  example to see how the tracks are change

head(data)
nrow(data)
data[c(153,152),]
data[c(47),]

is.na(data$Ozone)
table(is.na(data$Ozone))
?mean
mean (data$Ozone, na.rm=T)

data2<-subset(data,data$Ozone>31 & data$Temp>90)
nrow(data2)
mean(data2$Solar.R)

data2<-subset(data,data$Month==6)
mean(data2$Temp)

data2<-subset(data,data$Month==5)
summary(data2$Ozone)