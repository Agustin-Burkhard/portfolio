# Análisis de Incidentes de Ciberseguridad con Python

Proyecto de análisis exploratorio de datos enfocado en incidentes de
ciberseguridad, desarrollado con Python para analizar patrones de ataques,
severidad, exfiltración de datos, acciones de respuesta y comportamiento
temporal de los incidentes.

## Objetivo

Analizar un dataset de 20.000 incidentes de ciberseguridad para identificar
patrones relevantes relacionados con:

- Tipos de ataque.
- Niveles de severidad.
- Exfiltración de datos.
- Acciones de respuesta.
- Distribución temporal de incidentes.
- IPs de origen.
- Plataformas identificadas mediante User Agent.
- Relaciones entre variables de seguridad.

## Tecnologías utilizadas

- Python
- Pandas
- Matplotlib
- Jupyter Notebook

## Proceso de análisis

El proyecto incluye:

1. Exploración inicial del dataset.
2. Validación de valores nulos y registros duplicados.
3. Conversión y preparación de variables temporales.
4. Análisis de tipos de ataque y severidades.
5. Análisis de exfiltración de datos.
6. Análisis de incidentes críticos.
7. Análisis temporal por año, mes y hora.
8. Análisis de relaciones entre variables.
9. Identificación de plataformas mediante User Agent.
10. Visualización de resultados con Matplotlib.

## Análisis de seguridad

Se analizaron diferentes relaciones entre los incidentes, incluyendo:

- Tasa de exfiltración por tipo de ataque.
- Tasa de exfiltración por severidad.
- Incidentes críticos con exfiltración.
- IPs de origen más frecuentes.
- Tipo de ataque vs. severidad.
- Tipo de ataque vs. acción de respuesta.
- Severidad vs. acción de respuesta.
- Exfiltración según tipo de ataque y severidad.

## Principales hallazgos

- Se analizaron **20.000 incidentes de ciberseguridad**.
- **Malware** fue el tipo de ataque más frecuente, con **4.081 incidentes**.
- La severidad más frecuente fue **Low**, con **5.073 incidentes**.
- Se detectaron **1.919 incidentes con exfiltración de datos**, equivalentes al
  **9,59 %** del total.
- Malware presentó la mayor tasa de exfiltración, con aproximadamente
  **10,88 %**.
- La combinación de exfiltración más frecuente fue **Malware de severidad High**,
  con **124 casos**.
- La acción de respuesta más frecuente fue **Eradicated**, con **5.063 incidentes**.
- Entre 2020 y 2023 no se observó una tendencia sostenida de crecimiento o
  disminución de los tipos de ataque.
- Windows fue la plataforma más frecuente entre los User Agents analizados,
  representando aproximadamente el **44,58 %** de los registros.

> Los registros de 2024 no se utilizaron para comparar tendencias anuales debido
> a que el dataset contiene información únicamente hasta el 30 de enero de 2024.

## Visualizaciones

El notebook incluye visualizaciones sobre:

- Distribución de incidentes por tipo de ataque.
- Distribución por severidad.
- Tasa de exfiltración por tipo de ataque.
- Distribución de incidentes por hora.
- Evolución de tipos de ataque por año.
- Distribución de incidentes por plataforma.

## Estructura del proyecto

```text
analisis-incidentes-ciberseguridad/
│
├── analisis_incidentes.ipynb
├── data/
│   └── cybersecurity_dataset.csv
├── sql/
│   └── (análisis SQL - próximo paso)
└── README.md
```
