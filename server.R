library(DT)
library(shiny)
library(tidyverse)

server <- function(input, output) {
##### Tabla #####
    output$table <- DT::renderDataTable(DT::datatable({
      data <- PIB_Anual
      if (input$archivo != "All") {
        data <- PIB_Anual[PIB_Anual$Archivo_Origen == input$archivo,]
        }
      data
      }))
    ## Bajar datos en CSV
    thedata <- reactive(PIB_Anual)
    output$download <- downloadHandler(
      filename = function(){"Datos.csv"}, 
      content = function(fname){
        write.csv(thedata(), fname)
      }
    )
    ##### Grafico #####
}

runApp(list(ui=ui,server=server), launch.browser=TRUE)