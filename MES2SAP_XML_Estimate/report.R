library(ROracle)
intd_con <- dbConnect(dbDriver("Oracle"),
                      username="insitetapintd",
                      password="insitetapintd",
                      dbname="MESWIP45.SDCORP.GLOBAL.SANDISK.COM")

fetchMESSentData <- function(intd_con, day) {
  sql_text = paste("
  select b.txndatetime, b.ordername, ptl.productlevelname PNLevel, pc.packagecategoryname PACKAGECATEGORY, b.processtype, b.product, b.txnname,
         d.transactionid, d.bincategory, d.saplocation, d.qty, d.rejectcode, d.specname Step, d.lotname,b.recid,d.labelid
  from sap_basic b
  LEFT JOIN sap_details d ON d.recid=b.recid
  LEFT JOIN productbase ptb ON ptb.productname=b.product
  LEFT JOIN product pt ON pt.productid=ptb.revofrcdid
  LEFT JOIN a_productlevel ptl ON ptl.productlevelid=pt.productlevelid
  LEFT JOIN a_packagecategory pc ON pc.packagecategoryid=pt.packagecategoryid
  WHERE b.txndatetime > SYSDATE - ",day,sep="")
  
  tb <- fetch(dbSendQuery(intd_con,sql_text), n= -1)
  transform(tb, QTY=as.integer(as.character(QTY)))
}


preparePieData <- function(pd) {
  u <- unique(subset(pd,TRUE, c(TXNNAME, PNLEVEL, PACKAGECATEGORY, PROCESSTYPE, TRANSACTIONID,BINCATEGORY,SAPLOCATION,LABELID)))
  u$SentNum <- ifelse(u$PROCESSTYPE == "Cherry Pick", 2, 1)
  d <- aggregate(SentNum ~ PNLEVEL, data = u, sum)
  x <- as.vector(d$SentNum)
  names(x) <- d$PNLEVEL
  x
  d <- aggregate(SentNum ~ PACKAGECATEGORY, data = u[u$PNLEVEL == names(which(x==max(x))),], sum)
  y <- as.vector(d$SentNum)
  names(y) <- d$PACKAGECATEGORY
  return(list(x, y))
}

pd <- fetchMESSentData(intd_con,2)
x <- preparePieData(pd)