---------------------------------------------------------
-- ANÁLISIS EXPLORATORIO DE DATOS (EDA) E INSIGHTS
---------------------------------------------------------


-- P11: Ranking de clientes por volumen de transacciones

WITH total_por_cliente AS (
    SELECT
        c.client_id,
        d.district_name,
        COUNT(t.trans_id) AS total_transacciones,
        SUM(t.amount) AS monto_total
    FROM client c
    JOIN disposition dis ON c.client_id = dis.client_id
    JOIN account a ON dis.account_id = a.account_id
    JOIN [transaction] t ON a.account_id = t.account_id
    JOIN district d ON c.district_id = d.district_id
    GROUP BY c.client_id, d.district_name
)
SELECT TOP 20
    client_id,
    district_name,
    total_transacciones,
    monto_total,
    ROW_NUMBER() OVER (ORDER BY total_transacciones DESC) AS ranking_global,
    RANK() OVER (PARTITION BY district_name ORDER BY total_transacciones DESC) AS ranking_distrito
FROM total_por_cliente
ORDER BY ranking_global;


-- P12 Análisis de rentabilidad de préstamos por distrito

SELECT d.district_name,
       COUNT(l.loan_id) as total_prestamos,
       SUM(l.amount) as monto_total,
       SUM(CASE
        WHEN l.status IN ('"A"','"B"') THEN l.amount
        ELSE 0
        END) AS monto_rentable,
       CAST(
            SUM(CASE WHEN l.status IN ('"A"','"B"') THEN l.amount ELSE 0 END)
            * 100.0 /
            SUM(l.amount)
            AS DECIMAL(5,2)) AS porcentaje_rentabilidad,
       CASE 
            WHEN SUM(CASE WHEN l.status IN ('"A"','"B"') THEN l.amount ELSE 0 END)* 100.0 /SUM(l.amount) > 90 then 'Excelente'
            WHEN SUM(CASE WHEN l.status IN ('"A"','"B"') THEN l.amount ELSE 0 END)* 100.0 /SUM(l.amount) > 80 then 'Bueno'
            WHEN SUM(CASE WHEN l.status IN ('"A"','"B"') THEN l.amount ELSE 0 END)* 100.0 /SUM(l.amount) > 70 then 'Regular'
            WHEN SUM(CASE WHEN l.status IN ('"A"','"B"') THEN l.amount ELSE 0 END)* 100.0 /SUM(l.amount) <= 70 then 'Crítico'
            end as clasificacion

FROM district d 
JOIN account a ON d.district_id = a.district_id
JOIN loan l ON a.account_id = l.account_id
GROUP by d.district_name
HAVING COUNT(l.loan_id) >= 3
ORDER BY porcentaje_rentabilidad DESC;


-- P13: Clientes de alto riesgo (predicción de morosidad)

WITH perfil_cliente AS (
    SELECT 
        c.client_id,
        d.district_name,
        COUNT(l.loan_id) AS total_prestamos,
        SUM(l.amount) AS deuda_total,
        COUNT(CASE WHEN l.status = '"D"' THEN 1 END) AS prestamos_morosos,
        COUNT(CASE WHEN l.status = '"C"' THEN 1 END) AS prestamos_riesgo,
        AVG(l.amount) AS monto_promedio_prestamo
    FROM client c
    JOIN district d ON c.district_id = d.district_id
    JOIN disposition dis ON c.client_id = dis.client_id
    JOIN account a ON dis.account_id = a.account_id
    JOIN loan l ON a.account_id = l.account_id
    GROUP BY c.client_id, d.district_name
    HAVING COUNT(l.loan_id) >= 1
)
SELECT TOP 20
    client_id,
    district_name,
    total_prestamos,
    deuda_total,
    prestamos_morosos,
    prestamos_riesgo,
    monto_promedio_prestamo,
    CASE 
        WHEN prestamos_morosos > 0 AND deuda_total > 400000 THEN 'Crítico'
        WHEN prestamos_morosos > 0 OR deuda_total > 500000 THEN 'Alto'
        WHEN prestamos_riesgo >= 1 AND deuda_total > 300000 THEN 'Moderado'
        ELSE 'Bajo'
    END AS nivel_riesgo,
    RANK() OVER (ORDER BY deuda_total DESC) AS ranking_deuda
FROM perfil_cliente
ORDER BY deuda_total DESC;





























