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

-- P9: ¿Cuál es el saldo promedio de las cuentas por distrito?

WITH ultimo_saldo AS (
    SELECT 
        account_id,
        balance,
        ROW_NUMBER() OVER (PARTITION BY account_id ORDER BY trans_date DESC) AS rn
    FROM [transaction]
)
SELECT 
    d.district_name,
    COUNT(a.account_id) AS total_cuentas,
    CAST(AVG(us.balance) AS DECIMAL(15,2)) AS saldo_promedio
FROM ultimo_saldo us
JOIN account a ON us.account_id = a.account_id
JOIN district d ON a.district_id = d.district_id
WHERE us.rn = 1
GROUP BY d.district_name
HAVING COUNT(a.account_id) >= 5
ORDER BY saldo_promedio DESC;


-- P10: Tipos de transacciones más frecuentes

SELECT 
    type,
    operation,
    COUNT(1) AS total_transacciones,
    SUM(CAST(amount AS BIGINT)) AS total_transado  
FROM [transaction]
GROUP BY type, operation
ORDER BY total_transacciones DESC;















