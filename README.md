# 🏦 Análisis de Riesgo Crediticio - Banco Checoslovaco

![Banner](images/banner_banca.png)

## 📌 Resumen Ejecutivo

**Contexto:** El equipo de riesgos del Banco Checoslovaco necesita identificar patrones de morosidad y factores de riesgo crediticio para reducir pérdidas y optimizar la cartera de préstamos.

**Mi rol:** Como Data Analyst, he analizado más de **1.5 millones de registros** (transacciones, préstamos, clientes y cuentas) utilizando **SQL Server** para generar **15 KPIs estratégicos** que permitan:

- 🔍 Identificar distritos con mayor riesgo crediticio
- 📊 Detectar clientes con alta probabilidad de default
- 💰 Calcular la rentabilidad por región
- 🎯 Proponer acciones concretas para reducir la morosidad

**Resultado:** El análisis reveló que **el 65.69% de los préstamos están en estados problemáticos**, con distritos como **Domažlice (50% de morosidad)** y **Bruntal (33.33%)** que requieren atención inmediata.

---

## 📩 Conéctate conmigo

<p align="center">
  <a href="https://www.linkedin.com/in/mac-alvarado/">
    <img src="https://img.shields.io/badge/LinkedIn-0077B5?style=flat-square&logo=linkedin&logoColor=white" />
  </a>
  <a href="https://github.com/Mac-Alvarado">
    <img src="https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=github&logoColor=white" />
  </a>
</p>

---

## 📊 Estructura del Proyecto

- [Sobre los Datos](#-sobre-los-datos)
- [Preguntas de Negocio](#-preguntas-de-negocio)
- [Consultas SQL y Resultados](#-consultas-sql-y-resultados)
- [Insights y KPIs Estratégicos](#-insights-y-kpis-estratégicos)
- [Conclusiones y Recomendaciones](#-conclusiones-y-recomendaciones)

---

## 📁 Sobre los Datos

### Origen de los Datos
Dataset **Berka** del banco checoslovaco, utilizado en el desafío PKDD'99. Contiene información real anonimizada de transacciones bancarias.

### Estructura (8 tablas normalizadas)

```mermaid
graph TD
    district --> account
    district --> client
    client --> disposition
    account --> disposition
    account --> loan
    account --> order
    account --> transaction
    disposition --> card