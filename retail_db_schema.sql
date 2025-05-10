-- Making a database
mysql> CREATE DATABASE retail_db;
Query OK, 1 row affected (0.172 sec)

mysql> USE retail_db;
Database changed

-- Creating tables
mysql> CREATE TABLE customers (
    ->     customer_id INT PRIMARY KEY,
    ->     name VARCHAR(100),
    ->     region VARCHAR(100)
    -> );
Query OK, 0 rows affected (0.524 sec)

mysql> CREATE TABLE products (
    ->     product_id INT PRIMARY KEY,
    ->     product_name VARCHAR(100),
    ->     category VARCHAR(100),
    ->     price DECIMAL(10, 2)
    -> );
Query OK, 0 rows affected (0.535 sec)

mysql> CREATE TABLE orders (
    ->     order_id INT PRIMARY KEY,
    ->     customer_id INT,
    ->     order_date DATE,
    ->     FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    -> );
Query OK, 0 rows affected (0.860 sec)

mysql> CREATE TABLE order_items (
    ->     order_item_id INT PRIMARY KEY,
    ->     order_id INT,
    ->     product_id INT,
    ->     quantity INT,
    ->     FOREIGN KEY (order_id) REFERENCES orders(order_id),
    ->     FOREIGN KEY (product_id) REFERENCES products(product_id)
    -> );
Query OK, 0 rows affected (1.002 sec)

-- Loadind Data(fictional data)
mysql> LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.3/Uploads/customers.csv'
    -> INTO TABLE customers
    -> FIELDS TERMINATED BY ','
    -> ENCLOSED BY '"'
    -> LINES TERMINATED BY '\r\n'
    -> IGNORE 1 ROWS;
Query OK, 10 rows affected (0.528 sec)
Records: 10  Deleted: 0  Skipped: 0  Warnings: 0
-- Check if the data was loaded successfully
mysql> SELECT * FROM customers;
+-------------+----------+--------------+
| customer_id | name     | region       |
+-------------+----------+--------------+
|           1 | Alice    | Auckland     |
|           2 | Bob      | Wellington   |
|           3 | Carol    | Christchurch |
|           4 | Dave     | Hamilton     |
|           5 | Nomi     | Queenstown   |
|           6 | Justin   | Wellington   |
|           7 | Scott    | Wellington   |
|           8 | Emi      | Auckland     |
|           9 | Kathalin | Rotorua      |
|          10 | Ed       | Christchurch |
+-------------+----------+--------------+
10 rows in set (0.014 sec)

mysql> LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.3/Uploads/products.csv'
    -> INTO TABLE products
    -> FIELDS TERMINATED BY ','
    -> ENCLOSED BY '"'
    -> LINES TERMINATED BY '\r\n'
    -> IGNORE 1 ROWS;
Query OK, 10 rows affected (0.138 sec)
Records: 10  Deleted: 0  Skipped: 0  Warnings: 0

mysql> LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.3/Uploads/orders.csv'
    -> INTO TABLE orders
    -> FIELDS TERMINATED BY ','
    -> ENCLOSED BY '"'
    -> LINES TERMINATED BY '\r\n'
    -> IGNORE 1 ROWS;
Query OK, 20 rows affected, 20 warnings (0.115 sec)
Records: 20  Deleted: 0  Skipped: 0  Warnings: 20

mysql> LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.3/Uploads/order_items.csv'
    -> INTO TABLE order_items
    -> FIELDS TERMINATED BY ','
    -> ENCLOSED BY '"'
    -> LINES TERMINATED BY '\r\n'
    -> IGNORE 1 ROWS;
Query OK, 40 rows affected (0.129 sec)
Records: 40  Deleted: 0  Skipped: 0  Warnings: 0
-- Check if the data was loaded successfully
mysql> SELECT * FROM orders;
+----------+-------------+------------+
| order_id | customer_id | order_date |
+----------+-------------+------------+
|     1001 |          10 | 2025-01-21 |
|     1002 |          10 | 2025-04-15 |
|     1003 |           7 | 2025-01-18 |
|     1004 |           8 | 2025-03-02 |
|     1005 |           2 | 2025-01-30 |
|     1006 |           6 | 2025-02-05 |
|     1007 |           1 | 2025-01-23 |
|     1008 |           2 | 2025-01-16 |
|     1009 |           2 | 2025-01-18 |
|     1010 |          10 | 2025-02-20 |
|     1011 |           2 | 2025-03-13 |
|     1012 |           8 | 2025-02-17 |
|     1013 |           5 | 2025-02-21 |
|     1014 |           4 | 2025-02-08 |
|     1015 |           6 | 2025-03-15 |
|     1016 |           8 | 2025-01-13 |
|     1017 |           9 | 2025-04-06 |
|     1018 |           6 | 2025-03-31 |
|     1019 |           9 | 2025-04-17 |
|     1020 |           2 | 2025-02-16 |
+----------+-------------+------------+
20 rows in set (0.031 sec)

mysql> SELECT * FROM order_items
    -> SELECT * FROM products;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'SELECT * FROM products' at line 2
mysql>  SELECT * FROM order_items;
+---------------+----------+------------+----------+
| order_item_id | order_id | product_id | quantity |
+---------------+----------+------------+----------+
|             1 |     1015 |        109 |        2 |
|             2 |     1008 |        102 |        3 |
|             3 |     1010 |        101 |        3 |
|             4 |     1014 |        108 |        4 |
|             5 |     1014 |        103 |        4 |
|             6 |     1009 |        109 |        4 |
|             7 |     1002 |        101 |        1 |
|             8 |     1015 |        103 |        4 |
|             9 |     1005 |        105 |        1 |
|            10 |     1020 |        110 |        4 |
|            11 |     1019 |        108 |        5 |
|            12 |     1012 |        106 |        5 |
|            13 |     1012 |        104 |        5 |
|            14 |     1007 |        109 |        1 |
|            15 |     1004 |        110 |        2 |
|            16 |     1004 |        106 |        5 |
|            17 |     1016 |        102 |        4 |
|            18 |     1004 |        101 |        1 |
|            19 |     1005 |        108 |        4 |
|            20 |     1008 |        106 |        2 |
|            21 |     1009 |        105 |        1 |
|            22 |     1009 |        104 |        5 |
|            23 |     1019 |        102 |        3 |
|            24 |     1011 |        101 |        5 |
|            25 |     1014 |        108 |        1 |
|            26 |     1007 |        101 |        1 |
|            27 |     1013 |        101 |        3 |
|            28 |     1007 |        102 |        2 |
|            29 |     1002 |        105 |        3 |
|            30 |     1008 |        109 |        2 |
|            31 |     1006 |        107 |        3 |
|            32 |     1018 |        110 |        3 |
|            33 |     1002 |        107 |        2 |
|            34 |     1001 |        106 |        4 |
|            35 |     1007 |        108 |        3 |
|            36 |     1020 |        101 |        3 |
|            37 |     1013 |        101 |        3 |
|            38 |     1013 |        101 |        4 |
|            39 |     1015 |        102 |        4 |
|            40 |     1013 |        107 |        2 |
+---------------+----------+------------+----------+
40 rows in set (0.012 sec)
-- Evaluate the impact of seasonality on sales growth
mysql> SELECT
    ->     YEAR(o.order_date) AS year,
    ->     MONTH(o.order_date) AS month,
    ->     SUM(oi.quantity * p.price) AS monthly_sales
    -> FROM orders o
    -> JOIN order_items oi ON o.order_id = oi.order_id
    -> JOIN products p ON oi.product_id = p.product_id
    -> GROUP BY YEAR(o.order_date), MONTH(o.order_date)
    -> ORDER BY year, month;
+------+-------+---------------+
| year | month | monthly_sales |
+------+-------+---------------+
| 2025 |     1 |         71.14 |
| 2025 |     2 |        263.64 |
| 2025 |     3 |        159.44 |
| 2025 |     4 |         40.47 |
+------+-------+---------------+
4 rows in set (0.155 sec)
-- Best-selling products ranking
mysql> SELECT
    -> p.product_name,
    -> SUM(oi.quantity) AS total_sold
    -> FROM order_items oi
    -> JOIN products p ON oi.product_id = p.product_id
    -> GROUP BY p.product_id
    -> ORDER BY total_sold DESC;
+--------------+------------+
| product_name | total_sold |
+--------------+------------+
| Notebook     |         24 |
| Marker       |         17 |
| Pen          |         16 |
| Ruler        |         16 |
| Pencil       |         10 |
| Folder       |          9 |
| Glue         |          9 |
| Backpack     |          8 |
| Stapler      |          7 |
| Eraser       |          5 |
+--------------+------------+
10 rows in set (0.060 sec)
-- Regional sales
mysql> SELECT
    ->     c.region,
    ->     SUM(oi.quantity * p.price) AS total_sales
    -> FROM orders o
    -> JOIN customers c ON o.customer_id = c.customer_id
    -> JOIN order_items oi ON o.order_id = oi.order_id
    -> JOIN products p ON oi.product_id = p.product_id
    -> GROUP BY c.region
    -> ORDER BY total_sales DESC;
+--------------+-------------+
| region       | total_sales |
+--------------+-------------+
| Wellington   |      232.44 |
| Hamilton     |      112.50 |
| Queenstown   |       75.88 |
| Auckland     |       50.63 |
| Christchurch |       46.24 |
| Rotorua      |       17.00 |
+--------------+-------------+
6 rows in set (0.065 sec)
-- Average Revenue Per User
mysql> SELECT
    -> ROUND(SUM(oi.quantity * p.price) / COUNT(DISTINCT o.customer_id), 2) AS arpu
    -> FROM orders o
    -> JOIN order_items oi ON o.order_id = oi.order_id
    -> JOIN products p ON oi.product_id = p.product_id;
+-------+
| arpu  |
+-------+
| 66.84 |
+-------+
1 row in set (0.063 sec)
