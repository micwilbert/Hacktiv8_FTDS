--=================================================

--  Challenge 2

-- Nama  : Michael Wilbert Puradisastra
-- Batch : RMT-37

--=================================================
-- BUAT TABLE
CREATE TABLE segments (
    id_segment SERIAL PRIMARY KEY,
    segment_name VARCHAR(50) NOT NULL
);

CREATE TABLE products (
    id_product SERIAL PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL
);

CREATE TABLE countries (
    id_country SERIAL PRIMARY KEY,
    country_name VARCHAR(50) NOT NULL
);

CREATE TABLE discount_band (
    id_discount_band SERIAL PRIMARY KEY,
    discount_band_name VARCHAR(50) NOT NULL
);

CREATE TABLE transactions (
    id_transaction SERIAL PRIMARY KEY,
    id_segment INT REFERENCES segments(id_segment),
    id_product INT REFERENCES products(id_product),
    id_country INT REFERENCES countries(id_country),
    id_discount_band INT REFERENCES discount_band(id_discount_band),
    units_sold FLOAT NOT NULL,
    gross_sales FLOAT NOT NULL,
    discounts FLOAT NOT NULL,
    sales FLOAT NOT NULL,
    cogs FLOAT NOT NULL,
    profit FLOAT NOT NULL
);

-- COPY ISI TABLR
COPY segments(id_segment, segment_name) 
FROM 'D:\Hacktiv8_Assignment\p0-ftds037-rmt-g2-micwilbert/segments.csv' 
DELIMITER ',' 
CSV HEADER;

COPY products(id_product, product_name) 
FROM 'D:\Hacktiv8_Assignment\p0-ftds037-rmt-g2-micwilbert/products.csv' 
DELIMITER ',' 
CSV HEADER;

COPY countries(id_country, country_name) 
FROM 'D:\Hacktiv8_Assignment\p0-ftds037-rmt-g2-micwilbert/countries.csv' 
DELIMITER ',' 
CSV HEADER;

COPY discount_band(id_discount_band, discount_band_name) 
FROM 'D:\Hacktiv8_Assignment\p0-ftds037-rmt-g2-micwilbert/discount_band.csv' 
DELIMITER ',' 
CSV HEADER;

SELECT * FROM segments
SELECT * FROM products
SELECT * FROM countries
SELECT * FROM discount_band

COPY transactions(
    id_segment, id_product, id_country, 
    id_discount_band, units_sold, gross_sales, discounts, 
    sales, cogs, profit, id_transaction
) 
FROM 'D:\Hacktiv8_Assignment\p0-ftds037-rmt-g2-micwilbert/tabel_utama.csv' 
DELIMITER ',' 
CSV HEADER;

SELECT * FROM transactions

-- CREATE USER 
CREATE USER noob WITH PASSWORD 'noobpass';
CREATE USER admin_user WITH PASSWORD 'adminpass';

-- Grant Permissions
GRANT CONNECT ON DATABASE financial_data TO noob;
GRANT USAGE ON SCHEMA public TO noob;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO noob;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO noob;

GRANT ALL PRIVILEGES ON DATABASE financial_data TO admin_user;


-- TABLE TOTAL PROFIT DI TIAP JENIS SEGMENTASI
SELECT 
    s.segment_name AS segment, 
    SUM(t.profit) AS total_profit
FROM 
    transactions t
JOIN 
    segments s ON t.id_segment = s.id_segment
JOIN 
    discount_band d ON t.id_discount_band = d.id_discount_band
WHERE 
    d.discount_band_name != 'None'
GROUP BY 
    s.segment_name;

--  RANGKUMAN STATISTIK SALES MASING-MASING NEGARA
SELECT 
    c.country_name AS country,
    AVG(t.sales) AS average_sales,
    MIN(t.sales) AS min_sales,
    MAX(t.sales) AS max_sales
FROM 
    transactions t
JOIN 
    countries c ON t.id_country = c.id_country
GROUP BY 
    c.country_name;