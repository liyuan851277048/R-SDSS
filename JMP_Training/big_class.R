library(xlsx)

height <- read.xlsx("raw data_calss.xlsx","身高")
height <- transform(height, name=姓名, age=as.integer(年龄), sex=substr(toupper(性别),1,1), height=as.integer(身高))
height <- height[,c("name","age","sex","height")]

weight <- read.xlsx("raw data_calss.xlsx","体重")
weight <- transform(weight[-1,], girl=女生, boy=男生, girl_weight=NA., boy_weight=NA..1)

gw <- weight[!is.na(weight$girl),]
gw <- transform(gw, name=girl, weight=as.integer(girl_weight))
gw <- gw[,c("name","weight")]

bw <- weight[!is.na(weight$boy),]
bw <- transform(bw, name=boy, weight=as.integer(boy_weight))
bw <- bw[,c("name","weight")]

weight <- rbind(gw,bw)

bc <- merge(height, weight, by="name")