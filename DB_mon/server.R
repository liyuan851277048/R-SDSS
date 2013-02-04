library(shiny)
library(datasets)
library("DBI")
library("ROracle")

drv <- dbDriver("Oracle")
con <- dbConnect(drv, user  =  "system",  password="a",  db="srcdb")
qDF <- dbSendQuery(con, "select file_name,bytes from dba_data_files")
dDF <- fetch(qDF)
qDept <- dbSendQuery(con, "select * from scott.dept")
dDept <- fetch(qDept)
qSalGrd <- dbSendQuery(con, "select * from scott.SALGRADE")
dSalGrd <- fetch(qSalGrd)
# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
  
  # Return the requested dataset
  datasetInput <- reactive(function() {
    switch(input$dataset,
           "Datafiles" = dDF,
           "dept" = dDept,
           "salgrd" = dSalGrd)
  })
  
  # Generate a summary of the dataset
  # output$summary <- reactivePrint(function() {
  #   dataset <- datasetInput()
  #   summary(dataset)
  # })
  
  # Show the first "n" observations
  output$view <- reactiveTable(function() {
    #head(datasetInput())
    datasetInput()
  })

  output$main_plot <- reactivePlot(function() {    
    barplot(dDF$BYTES, cex.names=c(dDF$FILE_NAME), horiz=TRUE)
  })  
})
