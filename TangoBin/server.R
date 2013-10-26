library(ROracle)
library(reshape2)
library(shiny)

con <- dbConnect(dbDriver("Oracle"), 
                 username="tango_read", 
                 password="tango_read", 
                 dbname="TANGO_PROD.SDCORP.GLOBAL.SANDISK.COM")

source("read_data.R")

# Define server logic for random distribution application
shinyServer(function(input, output) {
  
  # Reactive expression to generate the requested distribution. This is 
  # called whenever the inputs change. The output functions defined 
  # below then all use the value computed from this expression
  data <- reactive({
    buildTangoBinDataFrame(fetchTangoBinViaBb(input$meslot,con),input$filter_num)
  })
  
  # Generate a summary of the dataset
  output$summary <- renderPrint({
    d <- data()
    d$OP_NAME <- NULL
    d$INQTY <- NULL
    summary(d)
  })  
  
  # Generate an HTML table view of the data
  output$table <- renderTable({
    data.frame(data())
  })
  
})