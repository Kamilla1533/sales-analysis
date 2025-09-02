# Sales and Profit Analysis for a Retail Network

## Objective:
* Conduct a comprehensive analysis of sales data over a specific period (February 2025) to identify key revenue and profit metrics by country, product, sales representative, and store location, as well as to determine top performers and best areas for business optimization.

## Data Used:
* Transactional data from the sales_data table containing information on products, quantities, prices, discounts, cost price, sales date, country, sales reps, and store locations. The dataset includes several thousand records within the selected time frame.

## Methods and Tools:
* SQL (PostgreSQL) for creating new calculated columns (total_amount, profit) using ALTER TABLE and UPDATE;
* Aggregate functions (SUM, MIN, MAX, AVG);
* Data grouping (GROUP BY) to segment sales and profits by country, product, sales rep, and location,;
* Filtering by date range (WHERE date BETWEEN...);
* Sorting and limiting results (ORDER BY, LIMIT).

## Results:
* Identified leading countries and stores by revenue and profit volumes;
* Determined the top 10 best-selling products and top 5 highest-performing sales representatives;
* Calculated key aggregated statistics: minimum, maximum, average, and total revenue and profit
* Insights enable focused marketing and inventory allocation on products and regions with the highest potential.
