/*
-----finding all the foreign key attached
SELECT
    conname AS fk_name,
    conrelid::regclass AS referencing_table
FROM pg_constraint
WHERE confrelid = 'dim_stock'::regclass;

---dropping all temp foreign key attached
ALTER TABLE sales_facts
DROP CONSTRAINT sales_facts_stock_code_fkey;


----dropping the primary key constraints
ALTER TABLE dim_stock
DROP CONSTRAINT dim_stock_pkey;



--adding constraints on the 
ALTER TABLE sales_facts
ADD CONSTRAINT fact_sales_stock_id_fkey FOREIGN KEY (stock_code) REFERENCES dim_stock(stock_id);
*/

----checking for size consumption of each table
SELECT
  relname AS table_name,
  pg_size_pretty(pg_total_relation_size(relid)) AS total_size
FROM pg_catalog.pg_statio_user_tables
ORDER BY pg_total_relation_size(relid) DESC;

