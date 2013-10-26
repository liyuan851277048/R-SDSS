library(ROracle)
library(reshape2)
con <- dbConnect(dbDriver("Oracle"), 
                 username="tango_read", 
                 password="tango_read", 
                 dbname="TANGO_PROD.SDCORP.GLOBAL.SANDISK.COM")

fetchTangoBinViaBb <- function(mes_lot, con) {
  sql_text = paste("
SELECT t.op_name,t.test_round,t.test_pg,max(t.pass_cnt+t.fail_cnt) over(PARTITION BY t.test_pg) as InQTY,r.*
  FROM TANGO.FTTESTINFO t,TANGO.FTTESTSUM r
 WHERE t.object_id = r.object_id 
   AND data_type='CAT'
   AND t.lot_id='",mes_lot,"'",sep='')

  tb <- fetch(dbSendQuery(con,sql_text), n= -1)  
  tb$OP_NAME <- as.factor(tb$OP_NAME)
  tb$TEST_ROUND <- as.factor(tb$TEST_ROUND)
  tb$TEST_PG <- as.factor(tb$TEST_PG)
  tb$OP_NAME <- as.factor(tb$OP_NAME)
  tb
}

buildTangoBinDataFrame <- function(tb, filter_num) {
  tm <- melt(tb, id=c("OP_NAME","TEST_ROUND","TEST_PG","INQTY","OFFSET","OBJECT_ID"))
  tm <- tm[tm$variable != "DATA_TYPE",]
  tm <- tm[tm$value >= filter_num,]
  tm <- cbind(tm, low_bin=substring(tm$variable,first=4,last=nchar(as.character(tm$variable))))
  tm <- cbind(tm, softbin=as.character.hexmode(as.numeric(tm$OFFSET)*100+as.numeric(tm$low_bin)))
  tm$OFFSET <- NULL
  tm$OBJECT_ID <- NULL
  tm$variable <- NULL
  tm$low_bin <- NULL
  tm$value <- as.numeric(tm$value)
  dcast(OP_NAME + TEST_PG + INQTY + softbin ~ TEST_ROUND, data = tm, value.var = "value")
}

tb <- fetchTangoBinViaBb("M1341M42ED.02",con)
tc <- buildTangoBinDataFrame(tb, 1)