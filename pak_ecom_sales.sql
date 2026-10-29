CREATE DATABASE pak_ecom;
USE pak_ecom;
SELECT * FROM pak_ecom_sales;

-- Total Revenue and Avg Order Value
SELECT SUM(total_spent) AS "Total_Revenue" FROM pak_ecom_sales;
SELECT  ROUND(SUM(total_spent) / COUNT(DISTINCT order_id), 2) AS "Avg Order Value" FROM pak_ecom_sales;

-- Top Category
SELECT category, SUM(total_spent) AS `total_revenue` FROM pak_ecom_sales
GROUP BY category
ORDER BY `total_revenue` DESC;
-- Top 10 Selling Products by Revenue
SELECT product_name, SUM(total_spent) AS `total_revenue` FROM pak_ecom_sales
GROUP BY product_name
ORDER BY total_revenue DESC
LIMIT 10;
-- Top 10 Selling Products by Quantity
SELECT product_name, SUM(quantity) AS `total_units_sold` FROM pak_ecom_sales
GROUP BY product_name
ORDER BY total_units_sold DESC
LIMIT 10;

-- Which products sell well but gets the biggest discount
SELECT product_name, category,
SUM(quantity) AS units_sold,
SUM(total_spent) AS total_revenue,
ROUND(AVG(discount) * 100, 1) AS  avg_discount_pct,
SUM(price_per_unit * quantity) - SUM(total_spent) AS discount_given
FROM pak_ecom_sales
GROUP BY product_name, category
HAVING SUM(quantity) > (
SELECT AVG(units )
FROM (
SELECT SUM(quantity) AS units
FROM pak_ecom_sales
GROUP BY product_name
) AS t
)
ORDER BY discount_given  DESC
LIMIT 10;
-- Top Cities
SELECT city,
SUM(total_spent) AS total_revenue,
COUNT(DISTINCT order_id) AS total_orders
FROM pak_ecom_sales
GROUP BY city
ORDER BY total_revenue DESC;

-- Top provinces
SELECT province,
SUM(total_spent) AS total_revenue,
COUNT(DISTINCT order_id) AS total_orders
FROM pak_ecom_sales
GROUP BY province
ORDER BY total_revenue DESC;

-- Top Selling Category By Province
WITH RankedCategories AS (
SELECT province, category,
SUM(total_spent) AS total_revenue,
RANK() OVER (
PARTITION BY province
ORDER BY SUM(total_spent) DESC
) AS rank_num
FROM pak_ecom_sales
GROUP BY province, category
)
SELECT province,
category AS top_category,
total_revenue
FROM RankedCategories
WHERE rank_num = 1
ORDER BY total_revenue DESC;

-- Revenue given away in discounts
SELECT SUM(price_per_unit * quantity) AS gross_revenue,
SUM(total_spent) AS revenue_after_discount,
SUM(price_per_unit * quantity) - SUM(total_spent) AS discount_given,
ROUND((SUM(price_per_unit * quantity) - SUM(total_spent))
/ SUM(price_per_unit * quantity) * 100, 1) AS discount_pct_of_gross
FROM pak_ecom_sales;

