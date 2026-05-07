# LIMPIEZA ENOE 4T2025 - SOLO GUERRERO (cve_ent=12)
library(tidyverse)
ruta <- "C:/Users/djr15/OneDrive/Escritorio/enoe_2025_trim4_csv/"

# ---------- 1. VIVIENDA ----------
viv <- read_csv(paste0(ruta, "ENOE_VIVT425.csv"),
                col_types = cols(.default = "c"))

viv_gro <- viv %>%
  filter(cve_ent == "12") %>%
  select(cd_a, cve_ent, con, v_sel, n_ent, per,
         t_loc_tri, cve_mun, est, fac_tri,
         p1, p2, p3, ur, cvegeo)

write_csv(viv_gro, paste0(ruta, "limpio_VIV.csv"))
cat("VIV listo:", nrow(viv_gro), "registros\n")

# ---------- 2. HOGAR ----------
hog <- read_csv(paste0(ruta, "ENOE_HOGT425.csv"),
                col_types = cols(.default = "c"))

hog_gro <- hog %>%
  filter(cve_ent == "12") %>%
  select(cd_a, cve_ent, con, v_sel, n_hog,
         n_ent, per, r_def, r_pre,
         p4_1, p4_2, inf, ur, cvegeo)

write_csv(hog_gro, paste0(ruta, "limpio_HOG.csv"))
cat("HOG listo:", nrow(hog_gro), "registros\n")

# ---------- 3. SOCIODEMOGRÁFICO ----------
sdem <- read_csv(paste0(ruta, "ENOE_SDEMT425.csv"),
                 col_types = cols(.default = "c"))

sdem_gro <- sdem %>%
  filter(cve_ent == "12") %>%
  select(cd_a, cve_ent, con, v_sel, n_hog, n_ren,
         per, r_def, c_res, sex, eda,
         cs_p13_1, cs_p13_2, cs_p14_c,
         clase1, clase2,
         pos_ocu, rama, seg_soc,
         ingocup, ing7c, hrsocup,
         anios_esc, niv_ins,
         ur, zona, fac_tri, cvegeo)

write_csv(sdem_gro, paste0(ruta, "limpio_SDEM.csv"))
cat("SDEM listo:", nrow(sdem_gro), "registros\n")

# ---------- 4. COE1 ----------
coe1 <- read_csv(paste0(ruta, "ENOE_COE1T425.csv"),
                 col_types = cols(.default = "c"))

coe1_gro <- coe1 %>%
  filter(cve_ent == "12") %>%
  select(cd_a, cve_ent, con, v_sel, n_hog, n_ren,
         per, eda,
         p1, p1a1, p1b, p1c,
         p2_1, p2_2, p2_3,
         p3, p3a, p3b,
         p4, p4a, p4b, p4c,
         p5b_thrs, p5d_thrs,
         ur, fac_tri, cvegeo)

write_csv(coe1_gro, paste0(ruta, "limpio_COE1.csv"))
cat("COE1 listo:", nrow(coe1_gro), "registros\n")

# ---------- 5. COE2 ----------
coe2 <- read_csv(paste0(ruta, "ENOE_COE2T425.csv"),
                 col_types = cols(.default = "c"))

coe2_gro <- coe2 %>%
  filter(cve_ent == "12") %>%
  select(cd_a, cve_ent, con, v_sel, n_hog, n_ren,
         per, eda,
         p6b1, p6b2, p6c,
         p6h, p6h_c,
         p7, p7a, p7b,
         p8_1, p8_2, p8a,
         ur, fac_tri, cvegeo)

write_csv(coe2_gro, paste0(ruta, "limpio_COE2.csv"))
cat("COE2 listo:", nrow(coe2_gro), "registros\n")
