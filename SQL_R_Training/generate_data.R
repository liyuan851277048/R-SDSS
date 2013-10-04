library(ROracle)
con <- dbConnect(dbDriver("Oracle"), username="sql_training", password="sq1trn", dbname="SPMSTST")
if (dbExistsTable(con, "DOG")) dbRemoveTable(con, "DOG")
if (dbExistsTable(con, "OWNER")) dbRemoveTable(con, "OWNER")

dogs <- data.frame(name=c('Fido','Bob','A Huang','Wolf'),owner_id=as.integer(c(1,1,2,NA)))
dbWriteTable(con, "DOG", dogs, row.names = FALSE)

owners <- data.frame(id=as.integer(c(1,2,3)),owner=c('Eric','Alick','Cindy'))
dbWriteTable(con, "OWNER", owners, row.names = FALSE)

# due to ROracle dbWriteTable is case sensitive, 
# so have to rebuild dog as dogs and owner as owners in Oracle
# to avoid the case sensitive problem