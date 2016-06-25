
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

placa_racun <- function(bruto_placa, osobni_odbitak = 1, prirez = 0, doprinos_mio = 2) {
  placa <- list(bruto_placa = bruto_placa,
                osobni_odbitak = osobni_odbitak,
                prirez = prirez,
                doprinos_mio = doprinos_mio
  )
  
  placa$doprinos_zdravstveno <- round(.15 * placa$bruto_placa , 2)
  placa$doprinos_ozljeda_na_radu <- round(.005 * placa$bruto_placa ,2)
  placa$doprinos_zaposljavanje <- round(.017 * placa$bruto_placa, 2)
  if(doprinos_mio ==1){
    placa$mio_1stup <- round(.2 * placa$bruto_placa, 2)
    placa$mio_2stup <- .0
  } else {
    placa$mio_1stup <- round(.15 * placa$bruto_placa, 2)
    placa$mio_2stup <- round(.05 * placa$bruto_placa, 2)
  }
  placa$dohodak <- placa$bruto_placa - (placa$mio_1stup + placa$mio_2stup)
  placa$osobni_odbitak <- osobni_odbitak * 2600
  if (placa$dohodak > 2600)
    placa$porezna_osnovica <- placa$dohodak - placa$osobni_odbitak
  else
    placa$porezna_osnovica <- 0
  
  placa$porez_12 <- 0
  placa$porez_25 <- 0
  placa$porez_40 <- 0
  if(placa$porezna_osnovica<=2200.00){
    placa$porez_12 <- round(placa$porezna_osnovica * .12, 2)
  } else if (placa$porezna_osnovica > 2200.00 & placa$porezna_osnovica <= 13200.00) {
    placa$porez_12 <- round(2200 * .12 ,2)
    placa$porez_25 <- round((placa$porezna_osnovica - 2200) *.25, 2)
  } else{
    placa$porez_12 <- 2200 * .12
    placa$porez_12 <- 11000 * .25
    placa$porez_25 <- round((placa$porezna_osnovica - 13200) *.40, 2)
  }
  placa$porez_ukupno <- placa$porez_12 + placa$porez_25 + placa$porez_40
  
  placa$prirez <- round(placa$porez_ukupno * prirez/100, 2)
  placa$neto <- placa$dohodak - placa$porez_ukupno - placa$prirez
  
  return(placa)
}


shinyServer(function(input, output) {

  output$placa_neto <- renderText({
    placa <- placa_racun(bruto_placa = input$bruto, 
                         osobni_odbitak = input$osobni_odbitak,
                         prirez = input$prirez_pp, 
                         doprinos_mio = input$mio) 
    placa$neto  
  }) 
  
  output$placa <- renderDataTable({
    placa <- placa_racun(bruto_placa = input$bruto, 
                         osobni_odbitak = input$osobni_odbitak, 
                         prirez = input$prirez_pp, 
                         doprinos_mio = input$mio)
    data.frame(name = names(placa), value = unlist(placa))
  })
})
