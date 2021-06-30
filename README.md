# PIB Anual de Honduras, Webpage BCH

En este sitio se presenta una forma de manipular los datos correspondientes a la p&#225;gina web del Banco Central de Honduras, creando un archivo unificado de los archivos disponibles en la arista [Producto Interno Bruto, Base 2000](https://www.bch.hn/pib_base2000.php).

El archivo `PIB_Anual.Rmd` contiene los c&#243;digos en RStudio para obtener los resultados a nivel de tabla y gr&#225;fico din&#225;mico de todos los archivos de la arista mencionada (no se descargan las variaciones porcentuales). Para ejecutar c&#243;digos desde su computadora, puede descargar el contenido de este sitio con el bot&#243;n verde `Clone or download` ubicado arriba y a la derecha de este mensaje. Puede ver los resultados en html, sin actualizar, [aqu&#237;](https://rpubs.com/ElvisCasco/PIB_Anual_BCH)

Los archivos `ui.R` y `server.R` ejecutan un proceso que permite visualizar los datos en una tabla y descargar los datos de origen para dicha tabla en su computadora, en un archivo `.csv`. Los resultados din&#225;micos usando Shiny se encuentran en [este v&#237;nculo](https://elviscasco.shinyapps.io/EstadisticaBCH/).
