/*
--function creation
CREATE OR REPLACE FUNCTION populate_date_parts()
RETURNS TRIGGER AS $$
BEGIN
        NEW.month := EXTRACT(MONTH FROM NEW.date);
        NEW.quarter := EXTRACT(Quarter FROM NEW.date);
        NEW.year := EXTRACT(YEAR FROM NEW.date);
        RETURN NEW;
END;

$$ LANGUAGE plpgsql;


---trigger creation
CREATE TRIGGER set_date_parts
BEFORE INSERT ON dim_date
FOR EACH ROW
EXECUTE FUNCTION populate_date_parts();
*/

/*
---inserting into date column
INSERT INTO dim_date(date)
SELECT InvoiceDate
FROM online_retail;
*/

SELECT *
FROM dim_stock
LIMIT 10;
