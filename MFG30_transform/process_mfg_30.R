options(java.parameters = "-Xmx800m")
library(rJava)
library(xlsx)
mfg30_d <- read.xlsx2("MFG30.xlsx", sheetName="Detail", startRow=2, colClasses=c("integer",rep("character",3),"integer",rep("character",12),"integer","character",rep("integer",5),"character",rep("POSIXct",3),rep("character",4),"integer","character"))
mfg30_d$X. <- NULL