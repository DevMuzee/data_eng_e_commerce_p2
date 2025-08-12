
--- Creating the dimension table
CREATE TABLE dim_customer(
    customers_id SERIAL PRIMARY KEY,
    customers_code INT,
    location VARCHAR(40)
);

CREATE TABLE dim_stock(
    stock_id TEXT,
    sku TEXT,
    stock_name VARCHAR(400),
    unitprice INT
);

CREATE TABLE dim_date(
    date_id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    month INT,
    quarter INT,
    year INT
);

CREATE TABLE dim_store(
    store_id SERIAL,
    region VARCHAR(40)
);
*/



---creating the facts table
CREATE TABLE sales_facts(
    sales_id SERIAL PRIMARY KEY,
    customer_id INT,
    stock_code TEXT,
    date_id INT,
    store_id INT,
    quantity_sold INT,
    total_amount NUMERIC(5,2),
    FOREIGN KEY (customer_id) REFERENCES dim_customer(customers_id),
    FOREIGN KEY (stock_code) REFERENCES dim_stock(stock_id),
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (store_id) REFERENCES dim_store(store_id)
);




---altering the table dim_stock and dim_store
ALTER TABLE dim_stock
ADD PRIMARY KEY (stock_id);

ALTER TABLE dim_store
ADD PRIMARY KEY (store_id);




----- checking the constraint type of a single column
SELECT 
    tc.constraint_type,
    tc.constraint_name,
    kcu.column_name
FROM information_schema.table_constraints AS tc
JOIN information_schema.key_column_usage AS kcu
    ON tc.constraint_name = kcu.constraint_name
WHERE tc.table_name = 'dim_stock';
*/




---inserting into dim_customers tables
INSERT INTO dim_customer(customers_code, location)
SELECT customer_id, country 
FROM online_retail;

---inserting into dim_stocks tables
INSERT INTO dim_stock(stock_inv, sku, stock_name, unitprice)
SELECT invoiceno, stockcode, description, unitprice
FROM online_retail;

--inserting into the dim_store table
INSERT INTO dim_store(region)
SELECT country
FROM online_retail;


---inseritng into the sales_fact table
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name='dim_stock'


---inserting into the facts table
INSERT INTO sales_facts(customer_id, stock_code, date_id, store_id, quantity_sold, total_amount)
SELECT dc.customers_id,
        ds.stock_id,
        dd.date_id,
        dis.store_id,
        nr.quantity,
        nr.quantity * nr.unitprice AS total_amount

FROM online_retail nr
JOIN dim_customer dc ON nr.customer_id = dc.customers_id
JOIN dim_stock ds ON nr.invoiceno = ds.stock_inv
JOIN dim_date dd ON nr.invoicedate = dd.date
JOIN dim_store dis ON nr.country = dis.region
LIMIT 10; 
