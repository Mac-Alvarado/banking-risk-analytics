-- ============================================================
-- PROYECTO: Análisis de Riesgo Crediticio - Banco Checoslovaco
-- SCRIPT: 03_exploration_inicial.sql
-- AUTOR: Mac Alvarado
-- FECHA: 24/06/2026
-- DESCRIPCIÓN: Exploración inicial de las tablas
-- ============================================================

USE BancoChecoslovaco;
GO

-- 1. Ver todas las tablas
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'dbo'
ORDER BY TABLE_NAME;

-- 2. Ver estructura de cada tabla
-- District
SELECT TOP 10 * FROM district;
SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'district';

-- Client
SELECT TOP 10 * FROM client;
SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'client';

-- Account
SELECT TOP 10 * FROM [account];
SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'account';

-- Disposition
SELECT TOP 10 * FROM disposition;
SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'disposition';

-- Loan
SELECT TOP 10 * FROM loan;
SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'loan';

-- Order
SELECT TOP 10 * FROM [order];
SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'order';

-- Card
SELECT TOP 10 * FROM card;
SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'card';

-- Transaction
SELECT TOP 10 * FROM [transaction];
SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'transaction';

-- 3. Contar registros por tabla
SELECT 'district' AS tabla, COUNT(*) AS total FROM district
UNION ALL
SELECT 'client', COUNT(*) FROM client
UNION ALL
SELECT 'account', COUNT(*) FROM [account]
UNION ALL
SELECT 'disposition', COUNT(*) FROM disposition
UNION ALL
SELECT 'loan', COUNT(*) FROM loan
UNION ALL
SELECT '[order]', COUNT(*) FROM [order]
UNION ALL
SELECT 'card', COUNT(*) FROM card
UNION ALL
SELECT '[transaction]', COUNT(*) FROM [transaction]
ORDER BY total DESC;