-- ============================================================
-- PROYECTO: Análisis de Riesgo Crediticio - Banco Checoslovaco
-- SCRIPT: 01_create_tables.sql
-- AUTOR: Mac Alvarado
-- FECHA: 22/06/2026
-- ============================================================

USE BancoChecoslovaco;
GO

-- 1. TABLA DISTRICT (Distritos) 
CREATE TABLE district (
    district_id INT PRIMARY KEY,
    district_name VARCHAR(100),
    region VARCHAR(50),
    no_inhabitants INT,
    no_municipalities_less_499 INT,
    no_municipalities_500_1999 INT,
    no_municipalities_2000_9999 INT,
    no_municipalities_10000_plus INT,
    no_cities INT,
    ratio_urban_inhabitants FLOAT,
    average_salary INT,
    unemployment_rate_1995 FLOAT,
    unemployment_rate_1996 FLOAT,
    no_entrepreneurs INT,
    no_committed_crimes_1995 INT,
    no_committed_crimes_1996 INT
);
GO

-- 2. TABLA CLIENT (Clientes) 
CREATE TABLE client (
    client_id INT PRIMARY KEY,
    birth_number VARCHAR(20),
    district_id INT,
    FOREIGN KEY (district_id) REFERENCES district(district_id)
);
GO

-- 3. TABLA ACCOUNT (Cuentas) 
CREATE TABLE account (
    account_id INT PRIMARY KEY,
    district_id INT,
    frequency VARCHAR(20),
    date_created DATE,
    FOREIGN KEY (district_id) REFERENCES district(district_id)
);
GO

-- 4. TABLA DISPOSITION (Relación Cliente-Cuenta) 
CREATE TABLE disposition (
    disp_id INT PRIMARY KEY,
    client_id INT,
    account_id INT,
    type VARCHAR(10),
    FOREIGN KEY (client_id) REFERENCES client(client_id),
    FOREIGN KEY (account_id) REFERENCES account(account_id)
);
GO

-- 5. TABLA CARD (Tarjetas) 
CREATE TABLE card (
    card_id INT PRIMARY KEY,
    disp_id INT,
    type VARCHAR(20),
    issued_date DATE,
    FOREIGN KEY (disp_id) REFERENCES disposition(disp_id)
);
GO

-- 6. TABLA LOAN (Préstamos) 
CREATE TABLE loan (
    loan_id INT PRIMARY KEY,
    account_id INT,
    date_issued DATE,
    amount INT,
    duration INT,
    payments INT,
    status VARCHAR(5),
    FOREIGN KEY (account_id) REFERENCES account(account_id)
);
GO

-- 7. TABLA ORDER (Órdenes de pago) 
CREATE TABLE [order] (
    order_id INT PRIMARY KEY,
    account_id INT,
    bank_to VARCHAR(20),
    account_to VARCHAR(20),
    amount INT,
    k_symbol VARCHAR(20),
    FOREIGN KEY (account_id) REFERENCES account(account_id)
);
GO

-- 8. TABLA TRANSACTION (Transacciones) 
CREATE TABLE [transaction] (
    trans_id INT PRIMARY KEY,
    account_id INT,
    trans_date DATE,
    type VARCHAR(10),
    operation VARCHAR(20),
    amount INT,
    balance INT,
    k_symbol VARCHAR(20),
    bank VARCHAR(20),
    account_other VARCHAR(20),
    FOREIGN KEY (account_id) REFERENCES account(account_id)
);
GO

-- Verificar que todas las tablas se crearon
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'dbo'
ORDER BY TABLE_NAME;