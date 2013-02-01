library(shiny)
library(datasets)

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
  
  # Return the requested dataset
  datasetInput <- reactive(function() {
    switch(input$db,
           "TestDB" = rock,
           "TestDB2" = pressure)
  })
  
  # Generate a summary of the dataset
  output$summary <- reactivePrint(function() {
    dataset <- datasetInput()
    summary(dataset)
  })
  
  # Show the first "n" observations
  output$view <- reactiveTable(function() {
    head(datasetInput(), n = 10)
  })
})
