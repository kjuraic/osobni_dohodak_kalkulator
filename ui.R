
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
      sliderInput("bruto_placa",
                  "Bruto osobni dohodak:",
                  min = 1,
                  max = 50,
                  value = 30),
      numericInput(inputId = "prirez_pp",
                label = "Prirez (%):",
                value = "0")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      h3("izracun place:"),
      plotOutput("distPlot"),
      paste("Stopa prireza:"),
      textOutput("prirezOut")
    )
  )
))
