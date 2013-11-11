library(stringr)

get_wo_SQL_str <- function(wo) {
  t1k <- as.character(wo)
  str1k <- ""
  loop_num <- ifelse(length(wo)<1000, length(wo),1000)
  for(i in 1:loop_num) {  str1k<-paste(str1k,",'",t1k[i],"'",sep="") }
  str1k <- str_sub(str1k, 2)
}

sample_pd <- pd[pd$ORDERNAME %in% sample(pd$ORDERNAME,size=20),]
sample_recid <- unique(sample_pd$RECID)
detail_sql <- paste("update sap_details d set d.status=0 where d.recid in (",get_wo_SQL_str(sample_recid),");", sep="")
basic_sql <- paste("update sap_basic b set b.status=3 where b.recid in (",get_wo_SQL_str(sample_recid),");", sep="")
x<-rbind(detail_sql,basic_sql)
write.csv(x,file="sql.csv")
