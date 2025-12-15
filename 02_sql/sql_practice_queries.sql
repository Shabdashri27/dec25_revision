/* =========================================
   Sample Sales Database Schema (Assumed)

   customers(customer_id, name, city)
   orders(order_id, customer_id, product_id,
          order_date, amount)
   products(product_id, product_name, price)
   payments(payment_id, order_id, payment_method)

   ========================================= */

-- 1. List all customers
SELECT * FROM customers;

-- 2. List all orders
SELECT * FROM orders;

-- 3. Total number of customers
SELECT COUNT(*) AS total_customers FROM customers;

-- 4. Total number of orders
SELECT COUNT(*) AS total_orders FROM orders;

-- 5. Total revenue
SELECT SUM(amount) AS total_revenue FROM orders;

-- 6. Average order value
SELECT AVG(amount) AS avg_order_value FROM orders;

-- 7. Highest order value
SELECT MAX(amount) AS highest_order FROM orders;

-- 8. Lowest order value
SELECT MIN(amount) AS lowest_order FROM orders;

-- 9. Total spending per customer
SELECT customer_id, SUM(amount) AS total_spent
FROM orders
GROUP BY customer_id;

-- 10. Orders per customer
SELECT customer_id, COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id;

-- 11. Top 5 customers by spending
SELECT customer_id, SUM(amount) AS total_spent
FROM orders
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;

-- 12. Orders greater than 500
SELECT * FROM orders WHERE amount > 500;

-- 13. Customers with no orders
SELECT * FROM customers
WHERE customer_id NOT IN (
    SELECT DISTINCT customer_id FROM orders
);

-- 14. Inner join customers & orders
SELECT c.name, o.order_id, o.amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

-- 15. Left join customers & orders
SELECT c.name, o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- 16. Orders per product
SELECT product_id, COUNT(*) AS order_count
FROM orders
GROUP BY product_id;

-- 17. Revenue per product
SELECT product_id, SUM(amount) AS total_revenue
FROM orders
GROUP BY product_id;

-- 18. Orders in last 30 days
SELECT *
FROM orders
WHERE order_date >= CURRENT_DATE - INTERVAL 30 DAY;

-- 19. Customers from Mumbai
SELECT * FROM customers WHERE city = 'Mumbai';

-- 20. Orders above average value
SELECT *
FROM orders
WHERE amount > (SELECT AVG(amount) FROM orders);

-- 21. Categorize orders
SELECT order_id, amount,
CASE
  WHEN amount < 200 THEN 'Low'
  WHEN amount BETWEEN 200 AND 700 THEN 'Medium'
  ELSE 'High'
END AS order_category
FROM orders;

-- 22. Monthly revenue
SELECT MONTH(order_date) AS month,
       SUM(amount) AS revenue
FROM orders
GROUP BY MONTH(order_date);

-- 23. Rank customers by spending
SELECT customer_id,
       SUM(amount) AS total_spent,
       RANK() OVER (ORDER BY SUM(amount) DESC) AS rank
FROM orders
GROUP BY customer_id;

-- 24. First order date per customer
SELECT customer_id, MIN(order_date) AS first_order
FROM orders
GROUP BY customer_id;

-- 25. Last order date per customer
SELECT customer_id, MAX(order_date) AS last_order
FROM orders
GROUP BY customer_id;

-- 26. Orders with product names
SELECT o.order_id, p.product_name, o.amount
FROM orders o
JOIN products p ON o.product_id = p.product_id;

-- 27. Revenue per city
SELECT c.city, SUM(o.amount) AS city_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city;

-- 28. Orders with payment method
SELECT o.order_id, p.payment_method
FROM orders o
JOIN payments p ON o.order_id = p.order_id;

-- 29. Customers spending more than 1000
SELECT customer_id, SUM(amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING total_spent > 1000;

-- 30. Top 3 products by revenue
SELECT product_id, SUM(amount) AS revenue
FROM orders
GROUP BY product_id
ORDER BY revenue DESC
LIMIT 3;
