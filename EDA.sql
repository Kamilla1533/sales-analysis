-- ADD COLUMNS--
-- column total amount --
ALTER TABLE sales_data
ADD COLUMN total_amount NUMERIC(10,2);

UPDATE sales_data
SET total_amount = (price_per_unit * quantity_purchased) - discount_applied;

-- column profit --
ALTER TABLE sales_data
ADD COLUMN profit NUMERIC(10, 2);

UPDATE sales_data
SET profit=total_amount - (cost_price + quantity_purchased);

-- Sales Revenue & Profit by Country --
SELECT country,
    SUM(total_amount) AS total_revenue,
    SUM(profit) AS total_profit
FROM sales_data
WHERE date BETWEEN '2025-02-10' AND '2025-02-14'
GROUP BY country
ORDER BY total_revenue DESC;
--| country | total_revenue | total_profit
--|---------|---------------|--------------
--| US      |      18573.89 |     16124.98
--| Nigeria |      17820.10 |     14276.19
--| UK      |      12751.25 |     10306.24
--| China   |       8858.04 |      7766.49
--| Canada  |       7365.62 |      6549.17

-- Top 10 Best-Selling Products --
SELECT product_name,
    SUM(quantity_purchased) AS total_units_sold
FROM sales_data
WHERE date BETWEEN '2025-02-10' AND '2025-02-14'
GROUP BY product_name
ORDER BY total_units_sold DESC
LIMIT 10;
--| product_name | total_units_sold
--|--------------|-----------------
--| Director     |               10
--| Indicate     |               10
--| Herself      |               10
--| School       |               10
--| Her          |               10
--| Dinner       |               10
--| Do           |                9
--| Bill         |                9
--| Police       |                9
--| Sell         |                9

-- Best Sales Representatives --
SELECT sales_rep,
    SUM(total_amount) AS total_sales
FROM sales_data
WHERE date BETWEEN '2025-02-10' AND '2025-02-14'
GROUP BY sales_rep
ORDER BY total_sales DESC
LIMIT 5;
--|    sales_rep     | total_sales
--|------------------|------------
--| Jeff Gonzalez    |     4283.52
--| Jennifer Miller  |     4238.46
--| Brandon Ward     |     4188.21
--| Henry Owens      |     3897.02
--| Kevin Ayers      |     3727.72

-- Top 5 store locations generated the highest sales --
SELECT store_location,
    SUM(total_amount) AS total_sales,
    SUM(profit) AS total_profit
FROM sales_data
GROUP BY store_location
ORDER BY total_sales DESC
LIMIT 5;
--| store_location | total_sales | total_profit
--|----------------|-------------|-------------
--| New York       |   273746.93 |    237393.57
--| Birmingham     |   266500.83 |    228061.48
--| Toronto        |   248312.34 |    213764.27
--| London         |   234247.29 |    199779.95
--| Shanghai       |   234110.00 |    201801.66

-- Key sales and profit data --
SELECT
    MIN(total_amount) AS min_sales_value,
    MAX(total_amount) AS max_sales_value,
    AVG(total_amount) AS avg_sales_value,
    SUM(total_amount) AS total_sales_value,
    MIN(profit) AS min_profit,
    MAX(profit) AS max_profit,
    AVG(profit) AS avg_profit,
    SUM(profit) AS total_profit
FROM sales_data;
--| min_sales_value | max_sales_value |    avg_sales_value    | total_sales_value | min_profit | max_profit |      avg_profit       | total_profit
--|-----------------|-----------------|-----------------------|-------------------|------------|------------|-----------------------|-------------
--|          -29.34 |         4906.26 | 1378.3481912058627582 |        4137801.27 |    -270.73 |    4532.87 | 1179.8262091938707528 |   3541838.28