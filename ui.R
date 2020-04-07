library(DT)
library(shiny)
library(tidyverse)

# Archivos disponibles en <https://github.com/ElvisCasco/PIB_Anual>

source("R/getDataPIB.R")
source("R/plotDataPIB.R")
getDataPIB()
PIB_Anual <- readRDS("RData/PIB_Anual.rds")
#plotDataPIB()
Nombre_Archivo_Origen <- unique(PIB_Anual$Archivo_Origen)
Nombre_Enfoque_PIB <- unique(PIB_Anual$Enfoque_PIB)
Nombre_Tipo_Serie <- unique(PIB_Anual$Tipo_Serie)
Nombre_Tipo_Valor <- unique(PIB_Anual$Tipo_Valor)

ui <- fluidPage(
  ##### Tabla #####
  titlePanel("Tabla de Datos"),
  # Create a new Row in the UI for selectInputs
  fluidRow(
    column(4,
           selectInput("archivo",
                       "Archivo de Origen:",
                       c("All",
                         as.character(Nombre_Archivo_Origen)))
    )
  ),
  
  # Create a new row for the table.
  DT::dataTableOutput("table"),
  downloadButton("download", "Descargar"),
  fluidRow(column(7,dataTableOutput('datos')))
  ##### Grafico #####
)