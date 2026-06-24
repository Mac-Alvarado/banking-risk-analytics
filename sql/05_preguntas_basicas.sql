
---------------------------------------------------------
-- ANÁLISIS EXPLORATORIO DE DATOS (EDA) E INSIGHTS
---------------------------------------------------------

-- P1 ¿Cuántos clientes tiene el banco?

SELECT count(1) AS TOTAL_CLIENTES
FROM client;

-- P2 Distribución de cuentas por frecuencia (traducido del checo)

SELECT 
    CASE 
        WHEN frequency = '"POPLATEK TYDNE"' THEN 'Semanal'
        WHEN frequency = '"POPLATEK MESICNE"' THEN 'Mensual'
        WHEN frequency = '"POPLATEK PO OBRATU"' THEN 'Por Transacción'
        ELSE frequency
    END AS tipo_frecuencia,
    COUNT(1) AS total_cuentas,
    CAST(COUNT(1) * 100.0 / SUM(COUNT(1)) OVER () AS DECIMAL(5,2)) AS porcentaje
FROM [account]
GROUP BY frequency
ORDER BY total_cuentas DESC;

-- P3: ¿Cuáles son los 5 distritos con más clientes?

SELECT top 5 d.district_name, count(c.client_id) as total_clientes
FROM district d
JOIN client c ON d.district_id = c.district_id
GROUP BY d.district_name
ORDER BY total_clientes DESC;


--P4: ¿Cuántos préstamos hay por estado?

SELECT status, 
        count(1) as total_prestamos, 
        CAST(COUNT(1) * 100.0 / (SELECT COUNT(1) FROM loan) AS DECIMAL(5,2)) AS porcentaje
FROM loan
GROUP by status
ORDER BY total_prestamos DESC;

--P5: Estadísticas básicas de los montos de préstamos

SELECT 
    COUNT(1) AS total_prestamos,
    MIN(amount) AS monto_minimo,
    AVG(amount) AS monto_promedio,
    MAX(amount) AS monto_maximo,
    SUM(amount) AS monto_total
FROM loan;