# CARGA DE DATOS A GOOGLE CLOUD SQL (MySQL)
# ENOE 4T2025 - Guerrero

library(RMySQL)
library(DBI)
library(tidyverse)

# ---------- CONEXIÓN ----------
con <- dbConnect(
  RMySQL::MySQL(),
  host     = "34.72.207.247",
  port     = 3306,
  dbname   = "enoe_guerrero",
  user     = "root",
  password = "\&A`Qnn&GxqK|]cR" 
)
cat("✅ Conexión exitosa\n")

# ---------- RUTA DE ARCHIVOS LIMPIOS ----------
ruta <- "C:/Users/djr15/OneDrive/Escritorio/enoe_2025_trim4_csv/"  
# ---------- LEER CSV LIMPIOS ----------
viv  <- read_csv(paste0(ruta, "limpio_VIV.csv"),  col_types = cols(.default = "c"))
hog  <- read_csv(paste0(ruta, "limpio_HOG.csv"),  col_types = cols(.default = "c"))
sdem <- read_csv(paste0(ruta, "limpio_SDEM.csv"), col_types = cols(.default = "c"))
coe1 <- read_csv(paste0(ruta, "limpio_COE1.csv"), col_types = cols(.default = "c"))
coe2 <- read_csv(paste0(ruta, "limpio_COE2.csv"), col_types = cols(.default = "c"))

# ---------- CONVERTIR COLUMNAS NUMÉRICAS ----------
viv  <- viv  %>% mutate(fac_tri = as.numeric(fac_tri))

hog  <- hog  %>% mutate(p4_1 = as.numeric(p4_1),
                        p4_2 = as.numeric(p4_2))

sdem <- sdem %>% mutate(fac_tri   = as.numeric(fac_tri),
                        ingocup   = as.numeric(ingocup),
                        hrsocup   = as.numeric(hrsocup),
                        anios_esc = as.numeric(anios_esc))

coe1 <- coe1 %>% mutate(fac_tri  = as.numeric(fac_tri),
                        p5b_thrs = as.numeric(p5b_thrs),
                        p5d_thrs = as.numeric(p5d_thrs))

coe2 <- coe2 %>% mutate(fac_tri = as.numeric(fac_tri),
                        p6b2    = as.numeric(p6b2),
                        p6c     = as.numeric(p6c),
                        p6h     = as.numeric(p6h))

# ---------- SUBIR TABLAS ----------
# Orden importante: respetar jerarquía de llaves foráneas

cat("Subiendo VIVIENDA...\n")
dbWriteTable(con, "vivienda", viv,  overwrite = TRUE, row.names = FALSE)
cat("✅ VIVIENDA:", nrow(viv), "registros\n")

cat("Subiendo HOGAR...\n")
dbWriteTable(con, "hogar", hog,  overwrite = TRUE, row.names = FALSE)
cat("✅ HOGAR:", nrow(hog), "registros\n")

cat("Subiendo SOCIODEMOGRAFICO...\n")
dbWriteTable(con, "sociodemografico", sdem, overwrite = TRUE, row.names = FALSE)
cat("✅ SOCIODEMOGRAFICO:", nrow(sdem), "registros\n")

cat("Subiendo COE1...\n")
dbWriteTable(con, "coe1", coe1, overwrite = TRUE, row.names = FALSE)
cat("✅ COE1:", nrow(coe1), "registros\n")

cat("Subiendo COE2...\n")
dbWriteTable(con, "coe2", coe2, overwrite = TRUE, row.names = FALSE)
cat("✅ COE2:", nrow(coe2), "registros\n")

# ---------- VERIFICACIÓN FINAL ----------
cat("\n--- Verificación ---\n")
tablas <- dbListTables(con)
for (t in tablas) {
  n <- dbGetQuery(con, paste0("SELECT COUNT(*) as n FROM ", t))$n
  cat(t, "→", n, "registros\n")
}

dbDisconnect(con)
cat("\n✅ ¡Carga completada!\n")
