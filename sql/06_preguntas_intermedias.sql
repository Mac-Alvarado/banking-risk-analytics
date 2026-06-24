---------------------------------------------------------
-- ANÁLISIS EXPLORATORIO DE DATOS (EDA) E INSIGHTS
---------------------------------------------------------


--P6: ¿Qué distritos tienen la mayor tasa de morosidad?

SELECT 
    d.district_name,
    COUNT(l.loan_id) AS total_prestamos,
    COUNT(CASE WHEN l.status = '"D"' THEN 1 END) AS prestamos_morosos,
    CAST(COUNT(CASE WHEN l.status = '"D"' THEN 1 END) * 100.0 / COUNT(l.loan_id) AS DECIMAL(5,2)) AS tasa_morosidad
FROM loan l
JOIN account a ON l.account_id = a.account_id
JOIN district d ON a.district_id = d.district_id
GROUP BY d.district_name
HAVING COUNT(CASE WHEN l.status = '"D"' THEN 1 END) > 0 
ORDER BY tasa_morosidad DESC;

--P7: ¿Cuál es la evolución mensual de préstamos otorgados?

SELECT YEAR(date_issued) as año,
        MONTH(date_issued) as mes,
        COUNT(1) AS cant_transaccion,
        SUM(amount) as total_prestado
FROM loan 
GROUP BY YEAR(date_issued),MONTH(date_issued)
ORDER BY año, mes;

-- P8 Clientes con más de 2 préstamos

SELECT 
    c.client_id,
    d.district_name,
    COUNT(l.loan_id) AS total_prestamo,
    SUM(l.amount) AS deuda_total
FROM client c
JOIN district d ON c.district_id = d.district_id
JOIN disposition dis ON c.client_id = dis.client_id   
JOIN account a ON dis.account_id = a.account_id      
JOIN loan l ON a.account_id = l.account_id           
GROUP BY c.client_id, d.district_name
HAVING COUNT(l.loan_id) > 2
ORDER BY total_prestamo DESC;

-- P9

WITH ultimo_saldo as (
        SELECT account_id
        FROM loan;

)



















