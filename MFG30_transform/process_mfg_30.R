# must set JVM memory to 512Mb+ to successfuly read MFG30 report
options(java.parameters = "-Xmx512m")
library(rJava)
library(xlsx)
mfg30_d <- read.xlsx2("MFG30.xlsx", sheetName="Detail", startRow=2, colClasses=c("integer",rep("character",3),"integer",rep("character",12),"integer","character",rep("integer",5),"character",rep("POSIXct",3),rep("character",4),"integer","character"))

# do the clean
mfg30_d$X. <- NULL
names(mfg30_d)[3]<-"LOT"
mfg30_d$LOT <- as.character(mfg30_d$LOT)
mfg30_d$DIE.UNIT <- as.character(mfg30_d$DIE.UNIT)
mfg30_d$DIE.UNIT <- as.character(mfg30_d$DIE.UNIT)

# not 2071 step keep same in NEW DIE UNIT
no_2071<-mfg30_d[!mfg30_d$Step.ID == 2071,]
no_2071$NEWDIEUNIT <- no_2071$DIE.UNIT

# 2071 step using sub lot as a UNIT and other is DIE
has_2071<-mfg30_d[mfg30_d$Step.ID == 2071,]
unit_2071<-has_2071[grepl("\\.\\d\\d$", has_2071$LOT, perl=TRUE),]
die_2071<-has_2071[!(grepl("\\.\\d\\d$", has_2071$LOT, perl=TRUE)),]
rm(has_2071)
unit_2071$NEWDIEUNIT <- "UNIT"
die_2071$NEWDIEUNIT <- "DIE"


# combine the result
d<-rbind(no_2071,unit_2071,die_2071)
d<-d[order(d[,1],d[,2],d[,3]),]
d<-d[!is.na(d$LOT),]
row.names(d)<-NULL

# write result
write.csv(d,"d.csv")