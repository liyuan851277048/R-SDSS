library(recharts)
options(shiny.transcode.json = FALSE)

source("report.R")

shinyServer(function(input, output) {
  
  yearArray = c( 2011, 2012, 2013)
  
  datasetInput <- reactive({
    pd <- fetchMESSentData(intd_con,input$dayN)
    x  <- preparePieData(pd)
  })
  
  output$rechartPie <- renderEcharts({
    recharts.init()	    
    ePie(datasetInput())
  })
})
