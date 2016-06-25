
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Kalkulator osobnog dohotka za 2016"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      numericInput(inputId = "bruto",
                   label = "Bruto osobni dohodak (Kn):",
                   value = 0),
      numericInput(inputId = "osobni_odbitak",
                   label = "Osobni odbitak:",
                   value = 1),
      numericInput(inputId = "prirez_pp",
                label = "Prirez (%):",
                value = "0"),
      selectInput(inputId = "mio",
                  label = "Doprinos MIO:", 
                  choices = list("MIO 1. stup 20%" = 1, "MIO 1. stup 15% | MIO 2. stup 5%" = 2)),
      submitButton("Calculate")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      h3("izracun place:"),
      textOutput("placa_neto"),
      dataTableOutput("placa")
    )
  )
))
