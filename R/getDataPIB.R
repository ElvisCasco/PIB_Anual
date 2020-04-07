getDataPIB <- function(nombre_datos = "PIB_Anual", ...) {
  
  rm(list = ls())
  
  # Estad&#237;stica Econ&#243;mica
  
  ## Sector Real
  
  ### Cuentas Nacionales Anuales
  
  #### Producto Interno Bruto, Base 2000
  
  ##### PIB, Enfoque de la Producci&#243;n, en Valores Corrientes y Constantes, 2000-2018 #####
  ## Bajar archivos desde webpage
  url1 <- 'https://www.bch.hn/esteco/sector_real/pib/pibenfoque_produccion.xls'
  httr::GET(url1, httr::write_disk(tf <- tempfile(fileext = ".xls")))
  pibenfoque_produccion <- readxl::read_excel(tf, 1L)
  names(pibenfoque_produccion) <- pibenfoque_produccion[7,]
  ## Procesar datos
  pibenfoque_produccion <- pibenfoque_produccion %>%
    # pib_produccion <- read_excel("Data/Real/pibenfoque_produccion.xls", skip = 7) %>%
    stats::na.omit() %>%
    dplyr::filter(CONCEPTO != "CONCEPTO") %>%
    dplyr::mutate(N = 1:60,
                  Tipo_Valor = case_when(N %in% 1:20 ~ "Corrientes",
                                         N %in% 21:40 ~ "Constantes",
                                         N %in% 41:60 ~ "\u00CDndice")) %>%
    dplyr::select(N,Tipo_Valor,everything()) %>%
    dplyr::rename(Nombre_Serie = CONCEPTO) %>%
    dplyr::select(c(1:22)) %>%
    tidyr::gather("Fecha","Valor",4:ncol(.)) %>%
    dplyr::mutate(Valor = as.double(Valor),
                  Enfoque_PIB = "Producci\u00F3n",
                  Tipo_Serie = "Original",
                  Archivo_Origen = "pibenfoque_produccion") %>%
    dplyr::select(Archivo_Origen,Enfoque_PIB,Tipo_Serie,Tipo_Valor,Nombre_Serie,Fecha,Valor)
  
  
  ##### PIB, Enfoque del Gasto, en Valores Corrientes y Constantes, 2000-2018 #####
  ## Bajar archivos desde webpage
  url1 <- 'https://www.bch.hn/esteco/sector_real/pib/pibenfoque_gasto.xls'
  httr::GET(url1, httr::write_disk(tf <- tempfile(fileext = ".xls")))
  pibenfoque_gasto <- readxl::read_excel(tf, 1L)
  names(pibenfoque_gasto) <- pibenfoque_gasto[6,]
  ## Procesar datos
  pibenfoque_gasto <- pibenfoque_gasto %>%
    # pibenfoque_gasto <- read_excel("Data/Real/pibenfoque_gasto.xls", skip = 6) %>%
    stats::na.omit() %>%
    dplyr::filter(CONCEPTO != "CONCEPTO") %>%
    dplyr::mutate(N = 1:48,
                  Tipo_Valor = case_when(N %in% 1:16 ~ "Corrientes",
                                         N %in% 17:32 ~ "Constantes",
                                         N %in% 33:48 ~ "\u00CDndice")) %>%
    dplyr::select(N,Tipo_Valor,everything()) %>%
    dplyr::rename(Nombre_Serie = CONCEPTO) %>%
    dplyr::select(c(1:22)) %>%
    tidyr::gather("Fecha","Valor",4:ncol(.)) %>%
    dplyr::mutate(Valor = as.double(Valor),
                  Enfoque_PIB = "Gasto",
                  Tipo_Serie = "Original",
                  Archivo_Origen = "pibenfoque_gasto") %>%
    dplyr::select(Archivo_Origen,Enfoque_PIB,Tipo_Serie,Tipo_Valor,Nombre_Serie,Fecha,Valor)
  
  ##### PIB, Enfoque del Ingreso, en Valores Corrientes, 2000-2018 #####
  ## Bajar archivos desde webpage
  url1 <- 'https://www.bch.hn/esteco/sector_real/pib/pibenfoque_ingreso.xls'
  httr::GET(url1, httr::write_disk(tf <- tempfile(fileext = ".xls")))
  pibenfoque_ingreso <- readxl::read_excel(tf, 1L)
  names(pibenfoque_ingreso) <- pibenfoque_ingreso[8,]
  ## Procesar datos
  pibenfoque_ingreso <- pibenfoque_ingreso %>%
    # pibenfoque_ingreso <- read_excel("Data/Real/pibenfoque_ingreso.xls", skip = 8) %>%
    stats::na.omit() %>%
    dplyr::filter(COMPONENTES != "COMPONENTES") %>%
    dplyr::mutate(Tipo_Valor = "Corrientes") %>%
    dplyr::select(Tipo_Valor,everything()) %>%
    dplyr::rename(Nombre_Serie = COMPONENTES) %>%
    dplyr::select(c(1:21)) %>%
    # dplyr::mutate(N = 1:nrow(.)) %>%
    tidyr::gather("Fecha","Valor",3:ncol(.)) %>%
    dplyr::mutate(Valor = as.double(Valor),
                  Enfoque_PIB = "Ingreso",
                  Tipo_Serie = "Original",
                  N = 1:nrow(.),
                  Archivo_Origen = "pibenfoque_ingreso") %>%
    dplyr::select(Archivo_Origen,Enfoque_PIB,Tipo_Serie,Tipo_Valor,Nombre_Serie,Fecha,Valor)
  
  ##### PIB e Ingreso Nacional Per-Cápita en Lempiras, 2000-2018 #####
  ## Bajar archivos desde webpage
  url1 <- 'https://www.bch.hn/esteco/sector_real/pib/pibinpc_lempiras.xls'
  httr::GET(url1, httr::write_disk(tf <- tempfile(fileext = ".xls")))
  pibinpc_lempiras <- readxl::read_excel(tf, 1L)
  names(pibinpc_lempiras) <- pibinpc_lempiras[7,]
  ## Procesar datos
  pibinpc_lempiras <- pibinpc_lempiras %>%
    # pibinpc_lempiras <- read_excel("Data/Real/pibinpc_lempiras.xls", skip = 7) %>%
    stats::na.omit() %>%
    tidyr::gather("Fecha","Valor",2:ncol(.))
  names(pibinpc_lempiras) <- c("Nombre_Serie","Fecha","Valor")
  pibinpc_lempiras <- pibinpc_lempiras %>%
    dplyr::mutate(Tipo_Valor = "Corrientes",
                  Valor = as.double(Valor),
                  Enfoque_PIB = "General",
                  Tipo_Serie = "Original",
                  N = 1:nrow(.),
                  Archivo_Origen = "pibinpc_lempiras") %>%
    dplyr::select(Archivo_Origen,Enfoque_PIB,Tipo_Serie,Tipo_Valor,Nombre_Serie,Fecha,Valor)
  
  ##### PIB e Ingreso Nacional Per-Cápita en Dólares, 2000-2018 #####
  ## Bajar archivos desde webpage
  url1 <- 'https://www.bch.hn/esteco/sector_real/pib/pibinpc_dolares.xls'
  httr::GET(url1, httr::write_disk(tf <- tempfile(fileext = ".xls")))
  pibinpc_dolares <- readxl::read_excel(tf, 1L)
  names(pibinpc_dolares) <- pibinpc_dolares[7,]
  ## Procesar datos
  pibinpc_dolares <- pibinpc_dolares %>%
    # pibinpc_dolares <- read_excel("Data/Real/pibinpc_dolares.xls", skip = 7) %>%
    stats::na.omit() %>%
    tidyr::gather("Fecha","Valor",2:ncol(.)) 
  names(pibinpc_dolares) <- c("Nombre_Serie","Fecha","Valor")
  pibinpc_dolares <- pibinpc_dolares %>%
    dplyr::mutate(Tipo_Valor = "Corrientes",
                  Valor = as.double(Valor),
                  Enfoque_PIB = "General",
                  Tipo_Serie = "Original",
                  N = 1:nrow(.),
                  Archivo_Origen = "pibinpc_dolares") %>%
    dplyr::select(Archivo_Origen,Enfoque_PIB,Tipo_Serie,Tipo_Valor,Nombre_Serie,Fecha,Valor)
  
  ##### Oferta y Demanda Global en Valores Corrientes y Constantes, 2000-2018 #####
  ## Bajar archivos desde webpage
  url1 <- 'https://www.bch.hn/esteco/sector_real/pib/oferta_demandagl.xls'
  httr::GET(url1, httr::write_disk(tf <- tempfile(fileext = ".xls")))
  oferta_demandagl <- readxl::read_excel(tf, 1L)
  names(oferta_demandagl) <- oferta_demandagl[5,]
  ## Procesar datos
  oferta_demandagl <- oferta_demandagl %>%
    # oferta_demandagl <- read_excel("Data/Real/oferta_demandagl.xls", skip = 5) %>%
    stats::na.omit() %>%
    dplyr::filter(CONCEPTO != "CONCEPTO") %>%
    dplyr::mutate(N = 1:46,
                  Tipo_Valor = case_when(N %in% 1:23 ~ "Corrientes",
                                         N %in% 24:46 ~ "Constantes",)) %>%
    dplyr::select(N,Tipo_Valor,everything()) %>%
    dplyr::rename(Nombre_Serie = CONCEPTO) %>%
    dplyr::select(c(1:22)) %>%
    tidyr::gather("Fecha","Valor",4:ncol(.)) %>%
    dplyr::mutate(Valor = as.double(Valor),
                  Enfoque_PIB = "General",
                  Tipo_Serie = "Original",
                  Archivo_Origen = "oferta_demandagl") %>%
    dplyr::select(Archivo_Origen,Enfoque_PIB,Tipo_Serie,Tipo_Valor,Nombre_Serie,Fecha,Valor)
  
  ##### Valor Agregado de la Agricultura, Ganaderia, Caza, Silvicultura y Pesca en Valores Corrientes y Constantes, 2000-2018 #####
  ## Bajar archivos desde webpage
  url1 <- 'https://www.bch.hn/esteco/sector_real/pib/vab_agropecuario.xls'
  httr::GET(url1, httr::write_disk(tf <- tempfile(fileext = ".xls")))
  vab_agropecuario <- readxl::read_excel(tf, 1L)
  names(vab_agropecuario) <- vab_agropecuario[8,]
  ## Procesar datos
  vab_agropecuario <- vab_agropecuario %>%
    # vab_agropecuario <- read_excel("Data/Real/vab_agropecuario.xls", skip = 8) %>%
    stats::na.omit() %>%
    dplyr::rename(Nombre_Serie = 1) %>%
    dplyr::filter(Nombre_Serie != "ACTIVIDAD ECON\u00D3MICA") %>%
    dplyr::mutate(N = 1:30,
                  Tipo_Valor = case_when(N %in% 1:15 ~ "Corrientes",
                                         N %in% 16:30 ~ "Constantes",)) %>%
    dplyr::select(N,Tipo_Valor,everything()) %>%
    dplyr::select(c(1:22)) %>%
    tidyr::gather("Fecha","Valor",4:ncol(.)) %>%
    dplyr::mutate(Valor = as.double(Valor),
                  Enfoque_PIB = "General",
                  Tipo_Serie = "Original",
                  Archivo_Origen = "vab_agropecuario") %>%
    dplyr::select(Archivo_Origen,Enfoque_PIB,Tipo_Serie,Tipo_Valor,Nombre_Serie,Fecha,Valor)
  
  ##### Valor Agregado de las Industrias Manufactureras en Valores Corrientes y Constantes, 2000-2018 #####
  ## Bajar archivos desde webpage
  url1 <- 'https://www.bch.hn/esteco/sector_real/pib/vab_manufactura.xls'
  httr::GET(url1, httr::write_disk(tf <- tempfile(fileext = ".xls")))
  vab_manufactura <- readxl::read_excel(tf, 1L)
  names(vab_manufactura) <- vab_manufactura[7,]
  ## Procesar datos
  vab_manufactura <- vab_manufactura %>%
    # vab_manufactura <- read_excel("Data/Real/vab_manufactura.xls", skip = 7) %>%
    stats::na.omit() %>%
    dplyr::rename(Nombre_Serie = 1) %>%
    dplyr::filter(Nombre_Serie != "ACTIVIDAD ECON\u00D3MICA") %>%
    dplyr::mutate(N = 1:32,
                  Tipo_Valor = case_when(N %in% 1:16 ~ "Corrientes",
                                         N %in% 17:32 ~ "Constantes")) %>%
    dplyr::select(N,Tipo_Valor,everything()) %>%
    dplyr::select(c(1:22)) %>%
    tidyr::gather("Fecha","Valor",4:ncol(.)) %>%
    dplyr::mutate(Valor = as.double(Valor),
                  Enfoque_PIB = "General",
                  Tipo_Serie = "Original",
                  Archivo_Origen = "vab_manufactura") %>%
    dplyr::select(Archivo_Origen,Enfoque_PIB,Tipo_Serie,Tipo_Valor,Nombre_Serie,Fecha,Valor)
  
  #### Unir Informes del Portal ####
  PIB_Anual <- rbind(oferta_demandagl,pibenfoque_gasto,pibenfoque_ingreso,pibenfoque_produccion,
                     pibinpc_dolares,pibinpc_lempiras,vab_agropecuario,vab_manufactura)
  rm(list=setdiff(ls(), "PIB_Anual"))
  saveRDS(PIB_Anual, file = paste0("RData/",nombre_datos,".rds"))

}
