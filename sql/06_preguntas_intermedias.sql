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
