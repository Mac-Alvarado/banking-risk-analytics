----------------------------------------------
-- LIMPIEZA DE DATOS
----------------------------------------------

-- Verificar valores nulos en clientes

SELECT COUNT(1) AS total_registros,
        COUNT(CASE WHEN client_id IS NULL THEN 1 END) AS null_cliente_id,
        COUNT(CASE WHEN birth_number IS NULL THEN 1 END) AS null_birth,
        COUNT(CASE WHEN district_id IS NULL THEN 1 END) AS null_district
FROM client;

-- Verificar valores nulos en cuentas

SELECT COUNT(1) AS total_cuentas,
        COUNT(CASE WHEN account_id IS NULL THEN 1 END) AS null_account_id,
        COUNT(CASE WHEN district_id IS NULL THEN 1 END) AS null_district_id,
        COUNT(CASE WHEN frequency IS NULL THEN 1 END) AS null_frequency,
        COUNT(CASE WHEN date_created IS NULL THEN 1 END) AS null_date
FROM account;


-- Verificar valores nulos en préstamos

SELECT COUNT(*) AS total_registros,
        COUNT(CASE WHEN loan_id IS NULL THEN 1 END) AS null_loan_id,
        COUNT(CASE WHEN account_id IS NULL THEN 1 END) AS null_account,
        COUNT(CASE WHEN date_issued IS NULL THEN 1 END) AS null_date,
        COUNT(CASE WHEN amount IS NULL THEN 1 END) AS null_amount,
        COUNT(CASE WHEN status IS NULL THEN 1 END) AS null_status
FROM loan;

-- Verificar valores nulos en transacciones

SELECT COUNT(*) AS total_registros,
        COUNT(CASE WHEN trans_id IS NULL THEN 1 END) AS null_trans_id,
        COUNT(CASE WHEN account_id IS NULL THEN 1 END) AS null_account,
        COUNT(CASE WHEN trans_date IS NULL THEN 1 END) AS null_date,
        COUNT(CASE WHEN amount IS NULL THEN 1 END) AS null_amount,
        COUNT(CASE WHEN balance IS NULL THEN 1 END) AS null_balance
FROM [transaction];

-- Verificar duplicados en clientes

SELECT client_id, COUNT(1) AS cantidad
FROM client
GROUP BY client_id
HAVING COUNT(1) > 1;

-- Verificar duplicados en cuentas

SELECT account_id, COUNT(1) AS cantidad
FROM account
GROUP BY account_id
HAVING COUNT(1) > 1;

-- Verificar duplicados en préstamos

SELECT loan_id, COUNT(*) AS cantidad
FROM loan
GROUP BY loan_id
HAVING COUNT(*) > 1;

-- Verificar duplicados en transacciones

SELECT trans_id, COUNT(*) AS cantidad
FROM [transaction]
GROUP BY trans_id
HAVING COUNT(*) > 1;

-- Verificar que todas las cuentas tengan un distrito válido

SELECT COUNT(1) AS cuentas_sin_distrito
FROM [account] a
LEFT JOIN district d ON a.district_id = d.district_id
WHERE d.district_id IS NULL;

-- Verificar que todos los préstamos tengan una cuenta válida

SELECT COUNT(1) AS prestamos_sin_cuenta
FROM loan l
LEFT JOIN [account] a ON l.account_id = a.account_id
WHERE a.account_id IS NULL;

-- Verificar que todas las transacciones tengan una cuenta válida

SELECT COUNT(1) AS transacciones_sin_cuenta
FROM [transaction] t
LEFT JOIN [account] a ON t.account_id = a.account_id
WHERE a.account_id IS NULL;

-- Verificar montos de préstamos negativos o cero

SELECT COUNT(1) AS prestamos_anomalos
FROM loan
WHERE amount <= 0;

-- Verificar montos de transacciones negativos o cero

SELECT COUNT(1) AS transacciones_anomalas
FROM [transaction]
WHERE amount <= 0;

-- Verificar fechas fuera de rango

SELECT COUNT(1) AS fechas_anomalas
FROM loan
WHERE date_issued < '1990-01-01' OR date_issued > '2000-01-01';

-- Verificar fechas fuera de rango

SELECT COUNT(1) AS fechas_anomalas
FROM loan
WHERE date_issued < '1990-01-01' OR date_issued > '2000-01-01';

-- Verificar que los montos sean números válidos

SELECT COUNT(1) AS montos_invalidos
FROM loan
WHERE ISNUMERIC(amount) = 0;

-- Ver las cuentas sin distrito

SELECT TOP 10 a.account_id, a.district_id, a.frequency, a.date_created
FROM [account] a
LEFT JOIN district d ON a.district_id = d.district_id
WHERE d.district_id IS NULL;

-- Ver transacciones con monto <= 0

SELECT TOP 20 trans_id, account_id, trans_date, type, operation, amount, balance
FROM [transaction]
WHERE amount <= 0
ORDER BY amount ASC;