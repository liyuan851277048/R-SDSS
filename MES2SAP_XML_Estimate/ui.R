library(shiny)

shinyUI(pageWithSidebar(
  
  headerPanel("Estimate the balance of PNLevel"),
  
  sidebarPanel(
    sliderInput("dayN",
                "Fetch last N day",
                min = 1,
                max = 7,
                value = 2),
    h6(a("view this application src",
         href="http://cvpscmip01/R-SDSS.git/tree/HEAD:/MES2SAP_XML_Estimate",
         target="_blank"))
  ),
  
  mainPanel(
    includeHTML(recharts.shiny.init()),
    htmlOutput("rechartPie")
  )
))
