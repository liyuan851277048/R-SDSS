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
  transform(tb, OP_NAME=as.factor(OP_NAME),
                  TEST_ROUND=as.factor(TEST_ROUND),
                     TEST_PG=as.factor(TEST_PG),
                       INQTY=as.factor(INQTY))
}

buildTangoBinDataFrame <- function(tb, filter_num) {
  tm <- melt(tb, id=c("OP_NAME","TEST_ROUND","TEST_PG","INQTY","OFFSET","OBJECT_ID"))
  tm <- tm[tm$variable != "DATA_TYPE" & tm$value >= filter_num, ]
  tm$value <- as.integer(tm$value)
  tm <- transform(tm, low_bin=substring(variable,first=4,last=nchar(as.character(variable))))
  tm <- transform(tm, softbin=as.character.hexmode(as.numeric(OFFSET)*100+as.numeric(low_bin)))
  tm <- subset(tm, select = -c(OFFSET,OBJECT_ID,variable,low_bin))
  dcast(OP_NAME + TEST_PG + INQTY + softbin ~ TEST_ROUND, data = tm, value.var = "value")
}

tb <- fetchTangoBinViaBb("M1341M42ED.02",con)
tc <- buildTangoBinDataFrame(tb, 1)
