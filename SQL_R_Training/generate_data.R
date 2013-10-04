library(ROracle)
drv <- dbDriver("Oracle")
con <- dbConnect(drv, username="sql_training", password="sq1trn", dbname="SPMSTST")

if (dbExistsTable(con, "DOGS")) dbRemoveTable(con, "DOGS")
dogs <- data.frame(name=c('Fido','Bob','A Huang','Wolf'),owner_id=c(1,1,2,NA))
dbWriteTable(con, "DOGS", dogs, row.names = FALSE)

if (dbExistsTable(con, "OWNERS")) dbRemoveTable(con, "OWNERS")
owners <- data.frame(id=c(1,2,3),owner=c('Eric','Alick','Cindy'))
dbWriteTable(con, "OWNERS", owners, row.names = FALSE)