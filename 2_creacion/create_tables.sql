-- =============================================
-- CREACIÓN DE TABLAS - ENOE 4T2025 GUERRERO
-- Motor: MySQL 8.0 | Google Cloud SQL
-- =============================================

USE enoe_guerrero;

-- =====================
-- TABLA: vivienda
-- =====================
CREATE TABLE vivienda (
  cd_a      VARCHAR(2)    NOT NULL,
  cve_ent   VARCHAR(2)    NOT NULL,
  con       VARCHAR(5)    NOT NULL,
  v_sel     VARCHAR(2)    NOT NULL,
  n_ent     VARCHAR(2)    NOT NULL,
  per       VARCHAR(3)    NOT NULL,
  t_loc_tri VARCHAR(1),
  cve_mun   VARCHAR(3),
  est       VARCHAR(2),
  fac_tri   DECIMAL(10,2),
  p1        VARCHAR(2),
  p2        VARCHAR(1),
  p3        VARCHAR(2),
  ur        VARCHAR(1)    NOT NULL,
  cvegeo    VARCHAR(10),
  PRIMARY KEY (cd_a, cve_ent, con, v_sel, n_ent, per)
);

-- =====================
-- TABLA: hogar
-- =====================
CREATE TABLE hogar (
  cd_a    VARCHAR(2)  NOT NULL,
  cve_ent VARCHAR(2)  NOT NULL,
  con     VARCHAR(5)  NOT NULL,
  v_sel   VARCHAR(2)  NOT NULL,
  n_hog   VARCHAR(2)  NOT NULL,
  n_ent   VARCHAR(2)  NOT NULL,
  per     VARCHAR(3)  NOT NULL,
  r_def   VARCHAR(2),
  r_pre   VARCHAR(2),
  p4_1    INT,
  p4_2    INT,
  inf     VARCHAR(1),
  ur      VARCHAR(1)  NOT NULL,
  cvegeo  VARCHAR(10),
  PRIMARY KEY (cd_a, cve_ent, con, v_sel, n_hog, n_ent, per),
  FOREIGN KEY (cd_a, cve_ent, con, v_sel, n_ent, per)
    REFERENCES vivienda(cd_a, cve_ent, con, v_sel, n_ent, per)
);

-- =====================
-- TABLA: sociodemografico
-- =====================
CREATE TABLE sociodemografico (
  cd_a      VARCHAR(2)    NOT NULL,
  cve_ent   VARCHAR(2)    NOT NULL,
  con       VARCHAR(5)    NOT NULL,
  v_sel     VARCHAR(2)    NOT NULL,
  n_hog     VARCHAR(2)    NOT NULL,
  n_ren     VARCHAR(3)    NOT NULL,
  per       VARCHAR(3)    NOT NULL,
  r_def     VARCHAR(2),
  c_res     VARCHAR(1),
  sex       VARCHAR(1),
  eda       VARCHAR(2),
  cs_p13_1  VARCHAR(2),
  cs_p13_2  VARCHAR(2),
  cs_p14_c  VARCHAR(2),
  clase1    VARCHAR(1),
  clase2    VARCHAR(1),
  pos_ocu   VARCHAR(1),
  rama      VARCHAR(1),
  seg_soc   VARCHAR(1),
  ingocup   DECIMAL(10,2),
  ing7c     VARCHAR(1),
  hrsocup   DECIMAL(5,1),
  anios_esc DECIMAL(4,1),
  niv_ins   VARCHAR(2),
  ur        VARCHAR(1)    NOT NULL,
  zona      VARCHAR(1),
  fac_tri   DECIMAL(10,2),
  cvegeo    VARCHAR(10),
  PRIMARY KEY (cd_a, cve_ent, con, v_sel, n_hog, n_ren, per),
  FOREIGN KEY (cd_a, cve_ent, con, v_sel, n_hog, per)
    REFERENCES hogar(cd_a, cve_ent, con, v_sel, n_hog, per)
);

-- =====================
-- TABLA: coe1
-- =====================
CREATE TABLE coe1 (
  cd_a      VARCHAR(2)  NOT NULL,
  cve_ent   VARCHAR(2)  NOT NULL,
  con       VARCHAR(5)  NOT NULL,
  v_sel     VARCHAR(2)  NOT NULL,
  n_hog     VARCHAR(2)  NOT NULL,
  n_ren     VARCHAR(3)  NOT NULL,
  per       VARCHAR(3)  NOT NULL,
  eda       VARCHAR(2),
  p1        VARCHAR(1),
  p1a1      VARCHAR(1),
  p1b       VARCHAR(1),
  p1c       VARCHAR(1),
  p2_1      VARCHAR(1),
  p2_2      VARCHAR(1),
  p2_3      VARCHAR(1),
  p3        VARCHAR(1),
  p3a       VARCHAR(1),
  p3b       VARCHAR(1),
  p4        VARCHAR(1),
  p4a       VARCHAR(1),
  p4b       VARCHAR(1),
  p4c       VARCHAR(1),
  p5b_thrs  DECIMAL(5,1),
  p5d_thrs  DECIMAL(5,1),
  ur        VARCHAR(1)  NOT NULL,
  fac_tri   DECIMAL(10,2),
  cvegeo    VARCHAR(10),
  PRIMARY KEY (cd_a, cve_ent, con, v_sel, n_hog, n_ren, per),
  FOREIGN KEY (cd_a, cve_ent, con, v_sel, n_hog, n_ren, per)
    REFERENCES sociodemografico(cd_a, cve_ent, con, v_sel, n_hog, n_ren, per)
);

-- =====================
-- TABLA: coe2
-- =====================
CREATE TABLE coe2 (
  cd_a    VARCHAR(2)  NOT NULL,
  cve_ent VARCHAR(2)  NOT NULL,
  con     VARCHAR(5)  NOT NULL,
  v_sel   VARCHAR(2)  NOT NULL,
  n_hog   VARCHAR(2)  NOT NULL,
  n_ren   VARCHAR(3)  NOT NULL,
  per     VARCHAR(3)  NOT NULL,
  eda     VARCHAR(2),
  p6b1    VARCHAR(1),
  p6b2    DECIMAL(10,2),
  p6c     DECIMAL(10,2),
  p6h     DECIMAL(5,1),
  p6h_c   VARCHAR(1),
  p7      VARCHAR(1),
  p7a     VARCHAR(1),
  p7b     VARCHAR(1),
  p8_1    VARCHAR(1),
  p8_2    VARCHAR(1),
  p8a     VARCHAR(1),
  ur      VARCHAR(1)  NOT NULL,
  fac_tri DECIMAL(10,2),
  cvegeo  VARCHAR(10),
  PRIMARY KEY (cd_a, cve_ent, con, v_sel, n_hog, n_ren, per),
  FOREIGN KEY (cd_a, cve_ent, con, v_sel, n_hog, n_ren, per)
    REFERENCES sociodemografico(cd_a, cve_ent, con, v_sel, n_hog, n_ren, per)
);
