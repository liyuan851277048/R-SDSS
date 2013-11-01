library(xlsx)

height <- read.xlsx("raw data_calss.xlsx","身高")
height <- transform(height, name=姓名, age=as.integer(年龄), sex=substr(toupper(性别),1,1), height=as.integer(身高))
height <- height[,c("name","age","sex","height")]

weight <- read.xlsx("raw data_calss.xlsx","体重",startRow=2)
weight <- transform(weight, girl=姓名, girl_weight=体重, boy=姓名.1, boy_weight=体重.1)

gw <- weight[!is.na(weight$girl),]
gw <- transform(gw, name=girl, weight=as.integer(girl_weight))
gw <- gw[,c("name","weight")]

bw <- weight[!is.na(weight$boy),]
bw <- transform(bw, name=boy, weight=as.integer(boy_weight))
bw <- bw[,c("name","weight")]

gbw <- rbind(gw,bw)

bc <- merge(height, gbw, by="name")