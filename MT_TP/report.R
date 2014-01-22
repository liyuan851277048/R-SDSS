library(RODBC)
con <- odbcConnect(dsn="FreeTDS-MTTP", uid="mtl_sa", pwd="mt1Admin")
df <- sqlQuery(con,"SELECT * FROM AssignTo")
