library(data.table) #data.table_1.9.5

#USO DEL rbindlist
#rbindlist is a function to bind rows in case we have big data.

#rbindlist is an r-function (provided by data.table package) which was
#written in C-code and wraped in R. It allows to work with great perfomance in case of binding rows.




#fp <- "C:\\Omar-2015\\LiliTemp\\temperaturas.xlsx"
fp <- "nombre_del_archivo_columnas_temperaturas.xlsx"
datos_tbl <- readxl::read_excel(path = fp,sheet = "Columnas")
datos_df <- as.data.frame(datos_tbl)

ncolumnas <- ncol(datos_df)
nfilas <- nrow(datos_df)


nombres_estaciones <- names(datos_df)[4:ncolumnas]
estaciones <- names(datos_df)[4:n]
estaciones <- rep(estaciones,nfilas)
estaciones <- as.data.frame(estaciones)
names(estaciones) <- "Estaciones"


temp_colum <- lapply(X = 4:ncolumnas, function(x) (datos_df[x]))
temp_colum <- rbindlist(temp_colum)
temp_colum <- as.data.frame(temp_colum)
names(temp_colum) <- "Temperatura"

data_cols <- lapply(X=4:ncolumnas,function(x) datos_df[1:3])
fechas_colum <- rbindlist(data_cols)
fechas_colum <- as.data.frame(fechas_colum)

estaciones <- lapply(X = 1:length(nombres_estaciones),function(x) data.frame(rep(nombres_estaciones[x],nfilas)))
estaciones <- rbindlist(estaciones)
estaciones <- as.data.frame(estaciones)
names(estaciones) <- "Estaciones"


fr <- cbind(estaciones,fechas_colum,temp_colum)
