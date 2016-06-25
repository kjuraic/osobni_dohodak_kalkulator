
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {

  output$distPlot <- renderPlot({

    # generate bins based on input$bins from ui.R
    x    <- rnorm(100)
    bins <- seq(min(x), max(x), length.out = input$bruto_placa + 1)
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
  
  output$prirezOut <- renderText({
    pr <-  as.numeric(input$prirez_pp)
    pr <- pr * 10
    pr
    }) 
  
})
