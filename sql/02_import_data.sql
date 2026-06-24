-- ============================================================
-- PROYECTO: Análisis de Riesgo Crediticio - Banco Checoslovaco
-- SCRIPT: 02_import_data.sql
-- AUTOR: Mac Alvarado
-- FECHA: 24/06/2026
-- DESCRIPCIÓN: Importación de datos desde archivos CSV
-- ============================================================

USE BancoChecoslovaco;
GO

-- 1. IMPORTAR DISTRICT
PRINT 'Importando district...';
BULK INSERT district
FROM 'D:\Mis Documentos\GitHub\banking-risk-analytics\data\district.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ';', ROWTERMINATOR = '\n');
PRINT '✅ district: ' + CAST(@@ROWCOUNT AS VARCHAR) + ' registros';

-- 2. IMPORTAR CLIENT
PRINT 'Importando client...';
BULK INSERT client
FROM 'D:\Mis Documentos\GitHub\banking-risk-analytics\data\client.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ';', ROWTERMINATOR = '\n');
PRINT '✅ client: ' + CAST(@@ROWCOUNT AS VARCHAR) + ' registros';

-- 3. IMPORTAR ACCOUNT
PRINT 'Importando account...';
BULK INSERT account
FROM 'D:\Mis Documentos\GitHub\banking-risk-analytics\data\account.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ';', ROWTERMINATOR = '\n');
PRINT '✅ account: ' + CAST(@@ROWCOUNT AS VARCHAR) + ' registros';

-- 4. IMPORTAR DISPOSITION
PRINT 'Importando disposition...';
BULK INSERT disposition
FROM 'D:\Mis Documentos\GitHub\banking-risk-analytics\data\disp.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ';', ROWTERMINATOR = '\n');
PRINT '✅ disposition: ' + CAST(@@ROWCOUNT AS VARCHAR) + ' registros';

-- 5. IMPORTAR LOAN
PRINT 'Importando loan...';
BULK INSERT loan
FROM 'D:\Mis Documentos\GitHub\banking-risk-analytics\data\loan.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ';', ROWTERMINATOR = '\n');
PRINT '✅ loan: ' + CAST(@@ROWCOUNT AS VARCHAR) + ' registros';

-- 6. IMPORTAR ORDER
PRINT 'Importando [order]...';
BULK INSERT [order]
FROM 'D:\Mis Documentos\GitHub\banking-risk-analytics\data\order.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ';', ROWTERMINATOR = '\n');
PRINT '✅ [order]: ' + CAST(@@ROWCOUNT AS VARCHAR) + ' registros';

-- 7. IMPORTAR CARD
PRINT 'Importando card...';
BULK INSERT card
FROM 'D:\Mis Documentos\GitHub\banking-risk-analytics\data\card.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ';', ROWTERMINATOR = '\n');
PRINT '✅ card: ' + CAST(@@ROWCOUNT AS VARCHAR) + ' registros';

-- 8. IMPORTAR TRANSACTION
PRINT 'Importando [transaction]... (puede tardar 1-2 minutos)';
BULK INSERT [transaction]
FROM 'D:\Mis Documentos\GitHub\banking-risk-analytics\data\trans.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ';', ROWTERMINATOR = '\n');
PRINT '✅ [transaction]: ' + CAST(@@ROWCOUNT AS VARCHAR) + ' registros';

-- VERIFICAR FINAL
PRINT '========================================';
PRINT '📊 RESUMEN DE IMPORTACIÓN:';
SELECT 'district' AS tabla, COUNT(*) AS total FROM district
UNION ALL
SELECT 'client', COUNT(*) FROM client
UNION ALL
SELECT 'account', COUNT(*) FROM account
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