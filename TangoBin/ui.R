library(shiny)

# Define UI for random distribution application
shinyUI(pageWithSidebar(

  # Application title
  headerPanel("Tango Bin Query in R & Package Shiny"),

  # Sidebar with controls to select the random distribution type
  # and number of observations to generate. Note the use of the br()
  # element to introduce extra vertical spacing
  sidebarPanel(
    textInput("meslot", "Lot:", "M1341M42ED.02"),
    sliderInput("filter_num",
                "Crop bin number less than",
                min = 0,
                max = 7,
                value = 1),
    h6(a("see application src",
         href="http://cvpscmip01/R-SDSS.git/tree/HEAD:/TangoBin",
         target="_blank"))
  ),

  # Show a tabset that includes a plot, summary, and table view
  # of the generated distribution
  mainPanel(
    verbatimTextOutput("summary"),
    tableOutput("table")
  )
))
