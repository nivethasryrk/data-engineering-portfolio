-- ============================================
-- SQL Practice for Data Analytics Interviews
-- ============================================

-- 1. Second Highest Salary
SELECT MAX(salary) AS second_highest_salary
FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);


-- 2. Latest Record Per Customer
SELECT customer_id, order_id, order_date, amount
FROM (
    SELECT customer_id,
           order_id,
           order_date,
           amount,
           ROW_NUMBER() OVER (
               PARTITION BY customer_id
               ORDER BY order_date DESC
           ) AS rn
    FROM orders
) t
WHERE rn = 1;


-- 3. Total Sales Per Customer
SELECT customer_id,
       SUM(amount) AS total_sales
FROM orders
GROUP BY customer_id;


-- 4. Employee Count Per Department
SELECT department,
       COUNT(*) AS employee_count
FROM employees
GROUP BY department;


-- 5. Customer Orders With Names
SELECT c.customer_id,
       c.customer_name,
       o.order_id,
       o.amount
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id;


-- 6. Find Duplicate Emails
SELECT email,
       COUNT(*) AS duplicate_count
FROM users
GROUP BY email
HAVING COUNT(*) > 1;


-- 7. Remove Duplicate Rows Conceptually Using ROW_NUMBER
SELECT *
FROM (
    SELECT user_id,
           email,
           created_at,
           ROW_NUMBER() OVER (
               PARTITION BY email
               ORDER BY created_at DESC
           ) AS rn
    FROM users
) t
WHERE rn = 1;


-- 8. Revenue By Region
SELECT region,
       SUM(revenue) AS total_revenue
FROM sales
GROUP BY region;


-- 9. Running Total of Sales
SELECT order_date,
       amount,
       SUM(amount) OVER (
           ORDER BY order_date
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS running_total
FROM orders;


-- 10. Top 3 Salaries Per Department
SELECT department,
       employee_name,
       salary
FROM (
    SELECT department,
           employee_name,
           salary,
           DENSE_RANK() OVER (
               PARTITION BY department
               ORDER BY salary DESC
           ) AS salary_rank
    FROM employees
) t
WHERE salary_rank <= 3;


-- 11. Null Check Example
SELECT *
FROM customers
WHERE customer_name IS NULL
   OR email IS NULL;


-- 12. Source vs Target Count Validation
SELECT 'source_table' AS table_name, COUNT(*) AS row_count
FROM source_table
UNION ALL
SELECT 'target_table' AS table_name, COUNT(*) AS row_count
FROM target_table;


-- 13. CTE Example for High Value Customers
WITH customer_sales AS (
    SELECT customer_id,
           SUM(amount) AS total_amount
    FROM orders
    GROUP BY customer_id
)
SELECT customer_id,
       total_amount
FROM customer_sales
WHERE total_amount > 10000;


-- 14. Average Sales By Month
SELECT DATE_TRUNC('month', order_date) AS sales_month,
       AVG(amount) AS avg_sales
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY sales_month;


-- 15. Identify Missing Keys Between Source and Target
SELECT s.customer_id
FROM source_customers s
LEFT JOIN target_customers t
    ON s.customer_id = t.customer_id
WHERE t.customer_id IS NULL;
