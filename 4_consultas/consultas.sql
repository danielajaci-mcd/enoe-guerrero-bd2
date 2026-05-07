-- =============================================
-- 10 CONSULTAS SQL - ENOE 4T2025 GUERRERO
-- Motor: MySQL 8.0
-- =============================================

USE enoe_guerrero;

-- =============================================
-- CONSULTAS SIMPLES (1-3)
-- =============================================

-- Consulta 1: Personas ocupadas ordenadas por ingreso
-- Recupera las personas ocupadas en Guerrero ordenadas de mayor
-- a menor ingreso mensual.
SELECT n_ren, sex, eda, ingocup, hrsocup, clase1
FROM sociodemografico
WHERE clase1 = '1'
ORDER BY ingocup DESC
LIMIT 20;

-- Consulta 2: Viviendas por tamaño de localidad
-- Distribución de viviendas según el tamaño de la localidad
-- (1=+100k hab, 2=15k-99k, 3=2.5k-14k, 4=-2.5k).
SELECT t_loc_tri,
       COUNT(*) AS total_viviendas
FROM vivienda
GROUP BY t_loc_tri
ORDER BY t_loc_tri;

-- Consulta 3: Personas ocupadas sin seguridad social
-- Filtra personas ocupadas sin acceso a seguridad social,
-- indicador clave de informalidad laboral.
SELECT n_ren, sex, eda, rama, ingocup
FROM sociodemografico
WHERE seg_soc = '2'
  AND clase1 = '1'
ORDER BY eda
LIMIT 20;

-- =============================================
-- CONSULTAS CON AGREGACIÓN (4-6)
-- =============================================

-- Consulta 4: Ingreso promedio por sexo
-- Cuantifica la brecha salarial de género en Guerrero.
SELECT 
  CASE sex WHEN '1' THEN 'Hombre' WHEN '2' THEN 'Mujer' END AS sexo,
  COUNT(*) AS total_ocupados,
  ROUND(AVG(ingocup), 2) AS ingreso_promedio,
  ROUND(MIN(ingocup), 2) AS ingreso_minimo,
  ROUND(MAX(ingocup), 2) AS ingreso_maximo
FROM sociodemografico
WHERE clase1 = '1' AND ingocup > 0
GROUP BY sex;

-- Consulta 5: Horas trabajadas promedio por rama de actividad
-- Identifica qué sectores demandan mayor carga horaria.
SELECT rama,
       COUNT(*) AS total_personas,
       ROUND(AVG(hrsocup), 1) AS horas_promedio
FROM sociodemografico
WHERE clase1 = '1' AND hrsocup > 0
GROUP BY rama
ORDER BY horas_promedio DESC;

-- Consulta 6: Distribución porcentual de nivel de escolaridad
-- Dimensiona el rezago educativo en la población de Guerrero.
SELECT niv_ins,
       COUNT(*) AS total,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS porcentaje
FROM sociodemografico
WHERE niv_ins IS NOT NULL
GROUP BY niv_ins
ORDER BY niv_ins;

-- =============================================
-- CONSULTAS CON JOIN (7-9)
-- =============================================

-- Consulta 7: Personas con seguridad social por municipio
-- Cruza SDEM, HOGAR y VIVIENDA para comparar cobertura
-- de seguridad social entre municipios de Guerrero.
SELECT v.cve_mun,
       COUNT(*) AS total_con_seg_social
FROM sociodemografico s
JOIN hogar h ON s.cd_a = h.cd_a AND s.cve_ent = h.cve_ent
            AND s.con = h.con AND s.v_sel = h.v_sel
            AND s.n_hog = h.n_hog AND s.per = h.per
JOIN vivienda v ON h.cd_a = v.cd_a AND h.cve_ent = v.cve_ent
              AND h.con = v.con AND h.v_sel = v.v_sel
              AND h.per = v.per
WHERE s.seg_soc = '1'
  AND s.clase1 = '1'
GROUP BY v.cve_mun
ORDER BY total_con_seg_social DESC;

-- Consulta 8: Ingreso y horas trabajadas por posición en el empleo
-- Compara condiciones laborales según la posición en el empleo
-- (empleado, jornalero, cuenta propia, patrón, sin pago).
SELECT s.pos_ocu,
       COUNT(*) AS total,
       ROUND(AVG(s.ingocup), 2) AS ingreso_promedio,
       ROUND(AVG(s.hrsocup), 1) AS horas_semana_promedio
FROM sociodemografico s
JOIN coe2 c2 ON s.cd_a = c2.cd_a AND s.cve_ent = c2.cve_ent
             AND s.con = c2.con AND s.v_sel = c2.v_sel
             AND s.n_hog = c2.n_hog AND s.n_ren = c2.n_ren
             AND s.per = c2.per
WHERE s.clase1 = '1' AND s.ingocup > 0
GROUP BY s.pos_ocu
ORDER BY ingreso_promedio DESC;

-- Consulta 9: Hogares con al menos un desocupado
-- Identifica núcleos familiares en situación de vulnerabilidad
-- económica por desempleo.
SELECT h.n_hog, h.cd_a, h.cve_ent,
       COUNT(*) AS total_desocupados
FROM hogar h
JOIN sociodemografico s ON h.cd_a = s.cd_a AND h.cve_ent = s.cve_ent
                       AND h.con = s.con AND h.v_sel = s.v_sel
                       AND h.n_hog = s.n_hog AND h.per = s.per
WHERE s.clase1 = '2'
GROUP BY h.n_hog, h.cd_a, h.cve_ent
HAVING COUNT(*) >= 1
ORDER BY total_desocupados DESC
LIMIT 20;

-- =============================================
-- CONSULTA AVANZADA (10)
-- =============================================

-- Consulta 10: Perfil de la población subocupada
-- JOIN triple con subconsulta para identificar personas que trabajan,
-- están disponibles para más horas y ganan por debajo del promedio estatal.
SELECT 
  CASE s.sex WHEN '1' THEN 'Hombre' WHEN '2' THEN 'Mujer' END AS sexo,
  s.eda,
  s.niv_ins,
  s.ingocup,
  s.hrsocup AS horas_trabajadas,
  c2.p6h_c AS rango_horas,
  c1.p4a AS tiene_imss,
  c2.p8_1 AS disponible_mas_horas
FROM sociodemografico s
JOIN coe1 c1 ON s.cd_a = c1.cd_a AND s.cve_ent = c1.cve_ent
             AND s.con = c1.con AND s.v_sel = c1.v_sel
             AND s.n_hog = c1.n_hog AND s.n_ren = c1.n_ren
             AND s.per = c1.per
JOIN coe2 c2 ON s.cd_a = c2.cd_a AND s.cve_ent = c2.cve_ent
             AND s.con = c2.con AND s.v_sel = c2.v_sel
             AND s.n_hog = c2.n_hog AND s.n_ren = c2.n_ren
             AND s.per = c2.per
WHERE s.clase1 = '1'
  AND c2.p8_1 = '1'
  AND s.ingocup > 0
  AND s.ingocup < (
      SELECT AVG(ingocup) 
      FROM sociodemografico 
      WHERE clase1 = '1' AND ingocup > 0
  )
ORDER BY s.ingocup ASC
LIMIT 20;
