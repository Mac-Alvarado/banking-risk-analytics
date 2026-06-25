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






































