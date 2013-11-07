library(recharts)
options(shiny.transcode.json = FALSE)

source("report.R")

shinyServer(function(input, output) {
  
  yearArray = c( 2011, 2012, 2013)
  
  datasetInput <- reactive({
    pd <- fetchMESSentData(intd_con,input$dayN)
    x  <- preparePieData(pd)
  })
  
  output$rechartPie1 <- renderEcharts({
    recharts.init()	    
    ePie(datasetInput()[[1]], main=paste("Sent XML files by PNLevel in",input$dayN,"days"), type="pie")
  })

  output$rechartPie2 <- renderEcharts({
    recharts.init()      
    ePie(datasetInput()[[2]], main="Largest PN Level by Product Category", type="rose", roseType="area")
  })
})
