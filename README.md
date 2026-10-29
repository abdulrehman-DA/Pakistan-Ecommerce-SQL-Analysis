# Pakistan E-Commerce Sales Analysis: SQL

A SQL project that analyzes Pakistani e-commerce sales data in MySQL. It answers common business questions: how much revenue the store makes, which products and categories lead, where customers are, and how much revenue is given away in discounts.

## Dataset

Pakistani e-commerce order data loaded into a single MySQL table, `pak_ecom_sales`, in the database `pak_ecom`.

| Column | Meaning |
|---|---|
| `order_id` | Order identifier |
| `product_name`, `category` | What was sold |
| `quantity`, `price_per_unit` | Units and list price |
| `discount` | Discount applied (fraction) |
| `total_spent` | Amount paid after discount |
| `city`, `province` | Where the order came from |

## Business Questions Answered

| # | Question | SQL used |
|---|---|---|
| 1 | What is the total revenue? | `SUM` |
| 2 | What is the average order value? | `SUM` / `COUNT(DISTINCT)` |
| 3 | Which categories earn the most? | `GROUP BY`, `ORDER BY` |
| 4 | What are the top 10 products by revenue and by units sold? | `GROUP BY`, `ORDER BY`, `LIMIT` |
| 5 | Which high-selling products also get the biggest discounts? | `HAVING` with a subquery |
| 6 | Which cities and provinces bring in the most revenue and orders? | Aggregation with `COUNT(DISTINCT)` |
| 7 | What is the top-selling category in each province? | CTE + `RANK() OVER (PARTITION BY ...)` |
| 8 | How much revenue is given away in discounts, and what share of gross sales is it? | Calculated columns, percentage math |

## SQL Skills Demonstrated

- Aggregation: `SUM`, `AVG`, `COUNT(DISTINCT ...)`, `GROUP BY`, `HAVING`
- Subqueries: comparing each product's sales against the average across all products
- CTEs: breaking a multi-step question into a readable query
- Window functions: `RANK()` with `PARTITION BY` to find the top category per province
- Calculated metrics: gross revenue, discount given, discount percentage

## How to Run

1. Load the dataset into MySQL as a table named `pak_ecom_sales` in a database called `pak_ecom`.
2. Open `pak_ecom_sales.sql` in MySQL Workbench.
3. Run the queries one section at a time.


## Notes

- This project uses a single table, so it focuses on aggregation, subqueries, CTEs, and window functions rather than `JOIN`s.
- I'm continuing to practice SQL and plan to add multi-table projects with joins.

## Tools Used

MySQL, MySQL Workbench

## Files

- `pak_ecom_sales.sql`: all queries, in order
