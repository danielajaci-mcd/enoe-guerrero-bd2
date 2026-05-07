# Análisis del Mercado Laboral en Guerrero — ENOE 4T2025

## Descripción
Base de datos relacional construida con los microdatos de la Encuesta Nacional de Ocupación y Empleo (ENOE) del cuarto trimestre de 2025, publicados por el INEGI. El proyecto filtra únicamente los registros del estado de Guerrero y analiza las condiciones laborales de su población.

## Tecnologías utilizadas
- **Lenguaje de limpieza y carga:** R (tidyverse, RMySQL, DBI)
- **Motor de base de datos:** MySQL 8.0
- **Servicio en la nube:** Google Cloud SQL
- **Cliente:** MySQL Workbench

## Estructura del repositorio
```
enoe-guerrero-bd/
├── README.md
├── 1_limpieza/
│   └── limpieza_enoe.R        # Filtrado y selección de variables
├── 2_creacion/
│   └── create_tables.sql      # Definición del esquema relacional
├── 3_carga/
│   └── carga_datos.R          # Conexión y carga a Google Cloud SQL
└── 4_consultas/
    └── consultas.sql          # 10 consultas SQL del proyecto
```

## Modelo de datos
El modelo consta de 5 tablas relacionadas jerárquicamente:

```
VIVIENDA
 └── HOGAR
      └── SOCIODEMOGRAFICO
           ├── COE1
           └── COE2
```

Las tablas se relacionan mediante una llave primaria compuesta:
`cd_a + cve_ent + con + v_sel + n_ent/n_hog/n_ren + per`

## Volumen de datos (Guerrero, 4T2025)
| Tabla | Registros |
|---|---|
| vivienda | 4,465 |
| hogar | 4,498 |
| sociodemografico | 12,519 |
| coe1 | 10,021 |
| coe2 | 10,021 |

## Conexión a la base de datos
- **Host:** 34.72.207.247
- **Puerto:** 3306
- **Base de datos:** enoe_guerrero
- **Usuario:** root

## Materia
Bases de Datos — Dr. Ismael Domínguez  
Mayo 2026
