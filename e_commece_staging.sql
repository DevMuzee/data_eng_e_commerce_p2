--creating a database
CREATE DATABASE e_commerce

---creating the staging database
CREATE TABLE online_retail(
    InvoiceNo INT,
    StockCode TEXT,
    Description VARCHAR(200),
    Quantity INT,
    InvoiceDate TIMESTAMP,
    UnitPrice INT,
    Customer_ID INT,
    Country VARCHAR(50)
);


--altering the table column
ALTER TABLE online_retail 
ALTER COLUMN invoiceno TYPE TEXT USING invoiceno::TEXT;

-- getting the column name and data types
-SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name='online_retail';

--invoice no containing c
SELECT customer_id, quantity, unitprice, stockcode, invoiceno
FROM online_retail
WHERE invoiceno ILIKE 'C%'
LIMIT 3;

--- getting customer_id not null
SELECT *
FROM online_retail
WHERE customer_id IS NOT NULL
LIMIT 10;
