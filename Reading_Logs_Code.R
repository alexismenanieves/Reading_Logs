# Ejemplo para leer datos no estructurados, usando regex y agrupando

logs <- c("27-May-19 16:57:58.1244 (6628 6452) Module1.exe:Programg.cpp,v:854: ERROR: group 5 failed with error = 0x8008000f",
"27-May-19 16:57:58.1254 (6628 6452) Module1.exe:Programg.cpp,v:880: ERROR: group 5 failed on its 3 retry", 
"27-May-19 17:00:04.8385 ( -1 1376 13900) Module2.exe:Execute:803: Information - Executing command 1", 
"27-May-19 17:00:08.5115 ( -1 1376 13900) Module2.exe:Execute:603: Information - command 1 completed.", 
"27-May-19 17:00:09.5209 ( -1 1376 13900) Module2.exe:Execute:803: Information - Executing command 2")

# extraer fecha y hora, unir mediante espacio en blanco
fec_hor <- sapply(strsplit(logs,' '), '[', 1:2)
fec_hor <- apply(fec_hor, 2, paste, collapse = " ")

# eliminar fecha y hora para extraer data de parentesis
mod_x <- sub("^[^ ]+ [^(]+", "", logs) 
parentesis <- sub("(\\([^)]+\\)).*","\\1", mod_x)

# extraer el texto restante
detalle <- sub("[^)]+\\)","", mod_x)
detalle <- sub("^\\s","", detalle)

#unir datos en un data frame
logs_data_frame <- data.frame(fec_hor, parentesis, detalle)
logs_data_frame
