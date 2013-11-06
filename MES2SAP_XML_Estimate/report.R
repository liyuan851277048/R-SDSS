library(ROracle)
intd_con <- dbConnect(dbDriver("Oracle"),
                      username="insitetapintd",
                      password="insitetapintd",
                      dbname="MESWIP45.SDCORP.GLOBAL.SANDISK.COM")

fetchMESSentData <- function(intd_con) {
  sql_text = "
  select b.txndatetime, b.ordername, ptl.productlevelname PNLevel, b.processtype, b.product, b.txnname,
         d.transactionid, d.bincategory, d.saplocation, d.qty, d.rejectcode, d.specname Step, d.lotname,b.recid,d.labelid
  from sap_basic b
  LEFT JOIN sap_details d ON d.recid=b.recid
  LEFT JOIN productbase ptb ON ptb.productname=b.product
  LEFT JOIN product pt ON pt.productid=ptb.revofrcdid
  LEFT JOIN a_productlevel ptl ON ptl.productlevelid=pt.productlevelid
  WHERE b.txndatetime > SYSDATE - 2
"
  
  tb <- fetch(dbSendQuery(intd_con,sql_text), n= -1)
  transform(tb, QTY=as.integer(as.character(QTY)))
}

pd <- fetchMESSentData(intd_con)
u <- unique(subset(pd,TRUE, c(TXNNAME, PNLEVEL, PROCESSTYPE, TRANSACTIONID,BINCATEGORY,SAPLOCATION,LABELID)))
u$SentNum <- ifelse(u$PROCESSTYPE == "Cherry Pick", 2, 1)
d <- aggregate(SentNum ~ PNLEVEL, data = u, sum)