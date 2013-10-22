library(ROracle)
library(reshape2)
con <- dbConnect(dbDriver("Oracle"), 
                 username="tango_read", 
                 password="tango_read", 
                 dbname="TANGO_PROD.SDCORP.GLOBAL.SANDISK.COM")
sql_text = "
SELECT t.op_name,t.test_round,t.test_pg,max(t.pass_cnt+t.fail_cnt) over(PARTITION BY t.test_pg) as InQTY,r.*
  FROM TANGO.FTTESTINFO t,TANGO.FTTESTSUM r
 WHERE t.object_id = r.object_id 
   AND data_type='CAT'
   AND t.lot_id='M1341M42ED.02'
"
tb <- fetch(dbSendQuery(con,sql_text), n= -1)
tm <- melt(tb, id=c("OP_NAME","TEST_ROUND","TEST_PG","INQTY","OFFSET","OBJECT_ID"))
tm <- tm[tm$variable != "DATA_TYPE",]
tm <- cbind(tm, low_bin=substring(tm$variable,first=4,last=nchar(as.character(tm$variable))))
tm <- cbind(tm, softbin=as.character.hexmode(as.numeric(tm$OFFSET)*100+as.numeric(tm$low_bin)))
