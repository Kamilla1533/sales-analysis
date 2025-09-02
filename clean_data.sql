CREATE TABLE sales_Canada(
    transaction_id VARCHAR(200) DEFAULT NULL,
    date DATE DEFAULT NULL,
    country VARCHAR(20) DEFAULT NULL,
    product_id VARCHAR(200) DEFAULT NULL,
    product_name VARCHAR(30) DEFAULT NULL,
    category VARCHAR(50) DEFAULT NULL,
    price_per_unit FLOAT DEFAULT NULL,
    quantity_purchased INT DEFAULT NULL,
    cost_price FLOAT DEFAULT NULL,
    discount_applied FLOAT DEFAULT NULL,
    payment_method VARCHAR(20) DEFAULT NULL,
    customer_age_group VARCHAR(20) DEFAULT NULL,
    customer_gender VARCHAR(20) DEFAULT NULL,
    store_location VARCHAR(20) DEFAULT NULL,
    sales_rep VARCHAR(100) DEFAULT NULL
);

COPY public."sales_canada" FROM 'path_file' DELIMITER ',' CSV HEADER NULL 'NULL';

CREATE TABLE sales_china AS TABLE sales_canada WITH NO DATA;
COPY public."sales_china" FROM 'path_file' DELIMITER ',' CSV HEADER NULL 'NULL';

CREATE TABLE sales_india AS TABLE sales_canada WITH NO DATA;
COPY public."sales_india" FROM 'path_file' DELIMITER ',' CSV HEADER NULL 'NULL';

CREATE TABLE sales_nigeria AS TABLE sales_canada WITH NO DATA;
COPY public."sales_nigeria" FROM 'path_file' DELIMITER ',' CSV HEADER NULL 'NULL';

CREATE TABLE sales_uk AS TABLE sales_canada WITH NO DATA;
COPY public."sales_uk" FROM 'path_file' DELIMITER ',' CSV HEADER NULL 'NULL';

CREATE TABLE sales_us AS TABLE sales_canada WITH NO DATA;
COPY public."sales_us" FROM 'path_file' DELIMITER ',' CSV HEADER NULL 'NULL';

CREATE TABLE sales_data AS
SELECT * FROM sales_canada
UNION ALL
SELECT * FROM sales_china
UNION ALL
SELECT * FROM sales_india
UNION ALL
SELECT * FROM sales_nigeria
UNION ALL
SELECT * FROM sales_uk
UNION ALL
SELECT * FROM sales_us;

SELECT DISTINCT(country) FROM sales_data;
--|  country
--|---------
--|  UK
--|  US
--|  Nigeria
--|  China
--|  Canada
--|  India

-- BACKUP:
CREATE TABLE sales_data_backup AS TABLE sales_data;

-- DATA CLEANING:
-- 1) Removing duplicates --
WITH duplicate_cte AS(
    SELECT *,
    ROW_NUMBER() OVER(PARTITION BY transaction_id, date, country,product_id, product_name, category, price_per_unit, quantity_purchased, cost_price, discount_applied, payment_method, customer_age_group, customer_gender,store_location, sales_rep) AS row_num FROM sales_data)

SELECT * FROM duplicate_cte
WHERE row_num > 1;

-- 2) NULL VALUES AND BLANK DATA --
SELECT
    SUM(CASE WHEN date IS NULL THEN 1 ELSE 0 END) AS date,
    SUM(CASE WHEN price_per_unit IS NULL THEN 1 ELSE 0 END) AS price_per_unit,
    SUM(CASE WHEN quantity_purchased IS NULL THEN 1 ELSE 0 END) AS quantity_purchased,
    SUM(CASE WHEN cost_price IS NULL THEN 1 ELSE 0 END) AS cost_price,
    SUM(CASE WHEN discount_applied IS NULL THEN 1 ELSE 0 END) AS discount_applied
FROM sales_data;
--| date | price_per_unit | quantity_purchased | cost_price | discount_applied
--|------+----------------+--------------------+------------+------------------
--|    0 |              0 |                  0 |          0 |                0

SELECT
    SUM(CASE WHEN transaction_id='' THEN 1 ELSE 0 END) AS transaction_id,
    SUM(CASE WHEN country='' THEN 1 ELSE 0 END) AS country,
    SUM(CASE WHEN product_id='' THEN 1 ELSE 0 END) AS product_id,
    SUM(CASE WHEN product_name='' THEN 1 ELSE 0 END) AS product_name,
    SUM(CASE WHEN category='' THEN 1 ELSE 0 END) AS category,
    SUM(CASE WHEN payment_method='' THEN 1 ELSE 0 END) AS payment_method,
    SUM(CASE WHEN customer_age_group='' THEN 1 ELSE 0 END) AS customer_age_group,
    SUM(CASE WHEN customer_gender='' THEN 1 ELSE 0 END) AS customer_gender,
    SUM(CASE WHEN store_location='' THEN 1 ELSE 0 END) AS store_location,
    SUM(CASE WHEN sales_rep='' THEN 1 ELSE 0 END) AS sales_rep
FROM sales_data;

--| transaction_id | country | product_id | product_name | category | payment_method | customer_age_group | customer_gender | store_location | sales_rep
--|----------------+---------+------------+--------------+----------+----------------+--------------------+-----------------+----------------+-----------
--|              0 |       0 |          0 |            0 |        0 |              0 |                  0 |               0 |              0 |         0