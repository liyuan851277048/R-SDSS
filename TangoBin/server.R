library(ROracle)
library(reshape2)
library(shiny)

con <- dbConnect(dbDriver("Oracle"), 
                 username="tango_read", 
                 password="tango_read", 
                 dbname="TANGO_PROD.SDCORP.GLOBAL.SANDISK.COM")

# Define server logic for random distribution application
shinyServer(function(input, output) {
  
  # Reactive expression to generate the requested distribution. This is 
  # called whenever the inputs change. The output functions defined 
  # below then all use the value computed from this expression
  data <- reactive({
    sql_text = paste("
    SELECT t.op_name,t.test_round,t.test_pg,max(t.pass_cnt+t.fail_cnt) over(PARTITION BY t.test_pg) as InQTY,r.*
    FROM TANGO.FTTESTINFO t,TANGO.FTTESTSUM r
    WHERE t.object_id = r.object_id 
    AND data_type='CAT'
    AND t.lot_id='",input$meslot,"'",sep='')
    tb <- fetch(dbSendQuery(con,sql_text), n= -1)
    tm <- melt(tb, id=c("OP_NAME","TEST_ROUND","TEST_PG","INQTY","OFFSET","OBJECT_ID"))
    tm <- tm[tm$variable != "DATA_TYPE",]
    tm <- cbind(tm, low_bin=substring(tm$variable,first=4,last=nchar(as.character(tm$variable))))
    tm <- cbind(tm, softbin=as.character.hexmode(as.numeric(tm$OFFSET)*100+as.numeric(tm$low_bin)))    
  })
  
  # Generate an HTML table view of the data
  output$table <- renderTable({
    data.frame(x=data())
  })
  
})