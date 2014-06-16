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
    ePie(datasetInput()[[1]], title=paste("Sent XML files by PNLevel in",input$dayN,"days"), title.y=30)
  })

  output$rechartPie2 <- renderEcharts({
    recharts.init()      
    ePie(datasetInput()[[2]], title="Largest PN Level by Product Category",  title.y=30, 
         type="rose", roseType="area")
  })
})
