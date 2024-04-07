-- This codespace aims to demonstrate my ability to use SQL to perform queries relevant to data science and business intelligence applications. 
-- Author: Leo Genders
-- Date: 31 March 2024
-- The db code can be found at the bottom of the text. 

-- Query #1
-- Please use all lowercase for table names. 
-- In the Code window on the upper left, write a query that will:
-- Write a SELECT statement that returns four columns from the Products table: 
-- `product_code`, `product_name`, `list_price`, and `discount_percent`. 
-- Sort the result set by `list price` 
SELECT product_code, product_name, list_price, discount_percent
FROM my_guitar_shop.products
ORDER BY list_price;


-- Query #2
-- Write a SELECT statement that returns one column from the Customers table named `full_name` that joins the `last_name` and `first_name` columns.
-- Format this column with the `last name`, a comma, a space, and the `first` name like this:
-- Doe, John
-- Sort the result set by the `last_name` column in ascending sequence.
-- Return only the customers whose last name begins with letters from M to Z.
-- *NOTE: When comparing strings of characters, ‘M’ comes before any string of characters that begins with ‘M’. For example, ‘M’ comes before ‘Murach’.*
SELECT CONCAT(last_name, ',', ' ', first_name) 
	AS full_name
FROM customers
WHERE last_name BETWEEN 'M' AND 'Z'
ORDER BY last_name;


-- Query #3
-- Write a SELECT statement that returns these columns from the Products table:
-- `product_name`  The product_name column
-- `list_price`    The list_price column
-- `date_added`    The date_added column
-- Return only the rows with a `list price` that’s greater than 500 and less than 2000.
-- Sort the result set by the `date_added` column in descending sequence.
SELECT product_name, list_price, date_added
FROM products
WHERE list_price BETWEEN 501 AND 1999;


-- Query #4
-- Write a SELECT statement that returns these column names and data from the Products table:
-- `product_name`  	    The product_name column
-- `list_price`    	    The list_price column
-- `discount_percent`  	The discount_percent column
-- `discount_amount`   	A column that’s calculated from the previous two columns
-- `discount_price`    	A column that’s calculated from the previous three columns
-- Round the `discount_amount` and `discount_price` columns to 2 decimal places.
-- Sort the result set by the `discount_price` column in descending sequence.
-- Use the LIMIT clause so the result set contains only the first 5 rows.
SELECT product_name, list_price, discount_percent, 
	ROUND(discount_percent * list_price, 2) AS discount_amount, 
	ROUND((discount_percent * list_price) - list_price, 2) AS discount_price
FROM products
ORDER BY discount_price DESC
LIMIT 5;


-- Query #5
-- Write a SELECT statement that returns these column names and data from the Order_Items table:
-- `item_id`	- The item_id column
-- `item_price`	- The item_price column
-- `discount_amount`	- The discount_amount column
-- `quantity` -	The quantity column
-- `price_total` -	A column that’s calculated by multiplying the item price by the quantity
-- `discount_total` -	A column that’s calculated by multiplying the discount amount by the quantity
-- `item_total` -	A column that’s calculated by subtracting the discount amount from the item price and then multiplying by the quantity
-- Only return rows where the `item_total` is greater than 500.
-- Sort the result set by the `item_total` column in descending sequence.
SELECT item_id, item_price, discount_amount, quantity, 
	item_price * quantity AS price_total, 
	discount_amount * quantity AS discount_total, 
    (item_price - discount_amount) * quantity AS item_total
FROM order_items
WHERE (item_price - discount_amount) * quantity > 500
ORDER BY item_total DESC;


-- Query #6 
-- Write a SELECT statement that returns these columns from the Orders table:
-- `order_id` -	The order_id column
-- `order_date` -	The order_date column
-- `ship_date`	- The ship_date column
-- Return only the rows where the `ship_date` column contains a null value.
SELECT order_id, order_date, ship_date
FROM orders
WHERE ship_date IS NULL;


-- Query #7
-- select that `last name`, `first name` and 
-- `initials` (first name initial, last name initial) from the customer table
-- Return only customers with a yahoo.com email address
SELECT last_name, first_name, 
	CONCAT(LEFT(first_name, 1), LEFT(last_name, 1)) AS initials
FROM customers
WHERE email_address REGEXP 'yahoo.com$';


-- Query #8
-- Write a SELECT statement without a FROM clause that creates a row with these columns:
-- `price`	- 100 (dollars)
-- `tax_rate` -	.07 (7 percent)
-- `tax_amount` -	The price multiplied by the tax
-- `total`	 - The price plus the tax
-- To calculate the fourth column, add the expressions you used for the first and third columns.       
SELECT 100 AS price, .07 AS tax_rate, 100 * .07 AS tax_amount, 100 + (100 * .07) AS total;

       
-- Query #9
-- Write a query that selects 'line1' 'line2','city','state,' 'zip_code' from the addresses table as `address`
-- Insert  carriage return before displaying 'city','state', 'zip' 
-- *hint: use '\n'*
-- **Example format:**
-- address
-- 100 East Ridgewood Ave. 
-- Paramus,NJ 07652
-- 21 Rosewood Rd. 
-- Woodcliff Lake,NJ 07677
-- YOU MIGHT NEED TO UNSELECT Wrap Cell Content in the Result Window
SELECT CONCAT(line1, '\n', line2, '\n', city, ', ', state, ' ', zip_code) AS address
FROM addresses;
-- ****I inserted an additional carriage return to accomodate line 2 addresses such as 'Suite 2' for 3829 Broadway Ave****
-- ****I added a space after the comma following city to properly space the 'city, state' format****
-- ****I needed to unselect 'wrap cell content' to properly view****


-- Query #10 
-- Retrieve all orders between given March 1,2018 and March 31, 2018
-- Select the following columns:order_id, order_date and ship_date
SELECT order_id, order_date, ship_date
FROM orders
WHERE order_date BETWEEN '2018-03-01' AND '2018-03-31';


-- Query #11 - Retrieve data from one or more tables- use zagi
-- Marketing needs a list of customers and what product they have purchased
-- which also shows category name and vendor name for that product.  To do this:
-- Create a query that returns customername, productname, categoryname, vendorname
-- order the list by customer name
-- Your list should contain 9 items
SELECT customername, productname, categoryname, vendorname
FROM zagi.customer cu, zagi.product p, zagi.category ct, zagi.vendor v, zagi.includes i, zagi.salestransaction s
WHERE cu.customerid=s.customerid
	AND s.tid=i.tid
	AND i.productid=p.productid
	AND p.categoryid=ct.categoryid
  AND p.vendorid=v.vendorid
ORDER BY customername;


-- Query #12 - Retrieve data from one or more tables - outer join- use hafh
-- Write three separate queries that return the bulding id, apartment number and corporate client name:
-- Which apartments have no corporate clients currently leasing them?
SELECT buildingid, aptno AS apartment_number, ccname AS corp_client_name
FROM hafh.apartment a
	LEFT JOIN corpclient c
    ON a.ccid=c.ccid;
-- ANSWER: Apartment Number 41 in Building B1 and Apartment Number 31 in B2 currently have no corporate clients leasing them.


-- Which corporate clients are currently not leasing any appartments?
SELECT buildingid, aptno AS apartment_number, ccname AS corp_client_name
FROM hafh.corpclient c
	LEFT JOIN apartment a
    ON c.ccid=a.ccid;
-- ANSWER: SouthAlps is a corporate client not currently leasing any apartments.


-- A list that combines the two above queries - a full outer join
	SELECT buildingid, aptno AS apartment_number, ccname AS corp_client_name
	FROM hafh.apartment a
		LEFT JOIN corpclient c
		ON a.ccid=c.ccid
UNION
	SELECT buildingid, aptno AS apartment_number, ccname AS corp_client_name
	FROM hafh.corpclient c
		LEFT JOIN apartment a
		ON c.ccid=a.ccid;


-- Query #13 - Summary queries - use my_guitar_shop
-- Write a SELECT statement that answers this question: What is the total quantity 
-- purchased for each product within each category? Return these columns:
-- The category_name column from the category table
-- The product_name column from the products table
-- The total quantity purchased for each product with orders in the Order_Items table
-- Use the WITH ROLLUP operator to include rows that give a summary for each 
-- category name as well as a row that gives the grand total.
-- Use the IF and GROUPING functions to replace null values in the category_name 
-- and product_name columns with literal values if they’re for summary rows. 
SELECT IF(GROUPING(category_name) = 1, 'GRAND TOTAL', category_name) AS category_name,
	IF(GROUPING(product_name) = 1, 'CATEGORY ORDERED TOTAL', product_name) AS product_name, 
    SUM(quantity) as total_quantity
FROM categories c 
	JOIN products p
		ON c.category_id=p.category_id
    JOIN order_items o
		ON p.product_id=o.product_id
GROUP BY category_name, product_name WITH ROLLUP;
    

-- Query #14 - Summary queries - use my_guitar_shop
-- Write a SELECT statement that uses an aggregate window function to get the total 
-- amount of each order. Return these columns:
-- The order_id column from the Order_Items table
-- The total amount for each order item in the Order_Items table (Hint: You can 
-- calculate the total amount by subtracting the discount amount from the item 
-- price and then multiplying it by the quantity)
-- The total amount for each order
-- Sort the result set in ascending sequence by the order_id column.
SELECT order_id, SUM((item_price - discount_amount) * quantity) OVER(PARTITION BY item_id) AS item_total_amount, 
	SUM((item_price - discount_amount) * quantity) OVER(PARTITION BY order_id) AS total_order_amount
FROM order_items
ORDER BY order_id;


-- Query #15 - Summary queries - use my_guitar_shop
-- Modify the solution to exercise Query 4 so the column that contains the total amount for 
-- each order contains a cumulative total by item amount.
-- Add another column to the SELECT statement that uses an aggregate window 
-- function to get the average item amount for each order.
-- Modify the SELECT statement so it uses a named window for the two aggregate 
-- functions.
SELECT order_id, (item_price - discount_amount) * quantity AS item_amount, 
SUM((item_price - discount_amount) * quantity) OVER (order_window ORDER BY item_id) AS cumulative_total_amount,
AVG((item_price - discount_amount) * quantity) OVER (order_window) AS item_average_by_order
FROM order_items
WINDOW order_window AS (PARTITION BY order_id)
ORDER BY order_id;


-- Query #16 - Summary queries - use my_guitar_shop
-- Write a SELECT statement that uses aggregate window functions to calculate the 
-- order total for each customer and the order total for each customer by date. Return 
-- these columns:
-- The customer_id column from the Orders table
-- The order_date column from the Orders table
-- The total amount for each order item in the Order_Items table
-- The sum of the order totals for each customer
-- The sum of the order totals for each customer by date (Hint: You can create a 
-- peer group to get these values)
SELECT customer_id, order_date, (item_price - discount_amount) * quantity AS item_amount, 
SUM((item_price - discount_amount) * quantity) OVER (PARTITION BY customer_id) AS customer_order_total, 
SUM((item_price - discount_amount) * quantity) OVER (PARTITION BY customer_id, order_date) AS date_total
FROM orders o
	JOIN order_items oi 
		ON o.order_id=oi.order_id
ORDER BY customer_id, order_date;


-- Query #17
-- Write a SELECT statement that joins the Categories table to the Products table and returns these columns: category_name, product_name, list_price.
-- Sort the result set by the category_name column and then by the product_name column in ascending sequence.
SELECT category_name, product_name, list_price
FROM categories c
   JOIN products p ON (c.category_id=p.category_id)
ORDER BY category_name ASC, product_name ASC;

-- Query #18
-- Write a SELECT statement that joins the Customers table to the Addresses table and returns these columns: first_name, last_name, line1, city, state, zip_code.
-- Return one row for each address for the customer with an email address of allan.sherwood@yahoo.com.
SELECT first_name, last_name, line1, city, state, zip_code
FROM customers cst
	JOIN addresses a ON (cst.customer_id=a.customer_id)
WHERE email_address = 'allan.sherwood@yahoo.com';


-- Query #19
-- Write a SELECT statement that joins the Customers table to the Addresses table and returns these columns: first_name, last_name, line1, city, state, zip_code.
-- Return one row for each customer, but only return addresses that are the shipping address for a customer.
SELECT first_name, last_name, line1, city, state, zip_code
FROM customers cst
	JOIN addresses a ON (cst.customer_id=a.customer_id)
WHERE shipping_address_id = address_id;

 
-- Query #20
-- Write a SELECT statement that joins the Customers, Orders, Order_Items, and Products tables. 
-- This statement should return these columns: last_name, first_name, order_date, product_name, item_price, discount_amount, and quantity.
-- Use aliases for the tables.
-- Sort the final result set by the last_name, order_date, and product_name columns.
SELECT last_name, first_name, order_date, product_name, item_price, discount_amount, quantity
FROM customers cst
	JOIN orders o ON (cst.customer_id=o.customer_id)
    JOIN order_items oi ON (o.order_id=oi.order_id)
    JOIN products p ON (oi.product_id=p.product_id)
ORDER BY last_name, order_date, product_name;


-- Query #21
-- Write a SELECT statement that returns the product_name and list_price columns from the Products table.
-- Return one row for each product that has the same list price as another product.
-- Sort the result set by the product_name column.
SELECT p1.product_name, p1.list_price
FROM products p1 JOIN products p2 
	ON (p1.list_price = p2.list_price) AND
    p1.product_id <> p2.product_id
ORDER BY p1.product_name;


-- Query #22
-- Write a SELECT statement that returns these two columns:
-- category_name The category_name column from the Categories table
-- product_id The product_id column from the Products table
-- Return one row for each category that has never been used.
-- Hint: Use an outer join and only return rows where the product_id column contains a null value.
SELECT category_name, product_id
FROM categories LEFT JOIN products ON categories.category_id=products.category_id
WHERE product_id IS NULL;


-- Query #23
-- Use the UNION operator to generate a result set consisting of three columns from the Orders table:
-- ship_status A calculated column that contains a value of SHIPPED or NOT SHIPPED
-- order_id The order_id column
-- order_date The order_date column
-- If the order has a value in the ship_date column, the ship_status column should contain a value of SHIPPED. Otherwise, it should contain a value of NOT SHIPPED.
-- Sort the final result set by the order_date column.
SELECT order_id, order_date,
	CASE
		WHEN (ship_date >= order_date)
			THEN 'SHIPPED'
		ELSE 'NOT SHIPPED'
	END AS ship_status
FROM orders
ORDER BY order_date;
-- Reference: Pg. 284-285 in text book (Murach, 2019, p. 284-285)


-- Query #24
-- Write a SELECT statement that returns these columns:
-- The count of the number of orders in the Orders table
-- The sum of the tax_amount columns in the Orders table
SELECT COUNT(order_id) AS order_count, sum(tax_amount)
FROM orders;


-- Query #25
-- Write a SELECT statement that returns one row for each category that has products with these columns:
-- The category_name column from the Categories table
-- The count of the products in the Products table as product_count
-- The list price of the most expensive product in the Products table as most_expensive_product
-- Sort the result set so the category with the most products appears first.
SELECT category_name, count(product_id) AS product_count, MAX(list_price) AS most_expensive_product
FROM categories c
	JOIN products p ON (p.category_id=c.category_id)
GROUP BY category_name
ORDER BY category_name DESC;


-- Query #26
-- Write a SELECT statement that returns one row for each customer that has orders with these columns:
-- The email_address column from the Customers table
-- The sum of the item price in the Order_Items table multiplied by the quantity in the Order_Items table as item_price_total
-- The sum of the discount amount column in the Order_Items table multiplied by the quantity in the Order_Items table as discount_amount_total
-- Sort the result set in descending sequence by the item price total for each customer.
SELECT email_address, SUM(item_price * quantity) AS item_price_total, SUM(discount_amount * quantity) AS discount_amount_total
FROM customers c
	JOIN orders o ON (c.customer_id=o.customer_id)
    JOIN order_items oi ON (o.order_id=oi.order_id)
GROUP BY email_address
ORDER BY SUM(item_price * quantity) DESC;


-- Query #27
-- Write a SELECT statement that returns one row for each customer that has orders with these columns:
-- The email_address column from the Customers table
-- A count of the number of orders from orders table as order_count
-- The order total for each order from orders table calculated from order_items
-- Return only those rows where the customer has more than 1 order.
-- Sort the result set in descending sequence by order_total.
SELECT email_address, COUNT(o.order_id) AS order_count, SUM((item_price - discount_amount) * quantity) AS order_total
FROM customers c
	JOIN orders o ON (c.customer_id=o.customer_id)
    JOIN order_items oi ON (o.order_id=oi.order_id)
GROUP BY email_address
HAVING COUNT(o.order_id) > 1
ORDER BY SUM((item_price - discount_amount) * quantity) DESC;


-- Query #28
-- Write a SELECT statement that answers this question:
-- What is the total amount ordered for each product? Return these columns:
-- The product_name column from the Products table
-- The total amount for each product in the Order_Items table
-- Use the WITH ROLLUP operator to include a row that gives the grand total.
SELECT IF(GROUPING(product_name)= 1, 'GRAND TOTAL', product_name), SUM((item_price - discount_amount) * quantity) AS total_amount
FROM products p 
	JOIN order_items oi ON (p.product_id=oi.product_id)
GROUP BY product_name WITH ROLLUP;
-- *** I added a 'GRAND TOTAL' name to the row with the rollup for visual ease***


-- Query #29
-- Write a SELECT statement that answers this question:
-- Which customers have ordered more than one product? Return these columns:
-- The email_address column from the Customers table
-- The count of distinct products from the customer’s orders as number_of_products
-- Sort the result set in ascending sequence by the email_address column.
SELECT email_address, COUNT(*) AS number_of_products
FROM customers c
	JOIN orders o ON (c.customer_id=o.customer_id)
    JOIN order_items oi ON (o.order_id=oi.order_id)
    JOIN products p ON (oi.product_id=p.product_id)
GROUP BY email_address
HAVING COUNT(*) > 1
ORDER BY email_address ASC;


-- Query #30
-- SELECT DISTINCT category_name
-- FROM categories c JOIN products p
--  ON c.category_id = p.category_id
--  ORDER BY category_name;
 -- solution:
USE my_guitar_shop;
SELECT DISTINCT category_name
FROM categories
WHERE category_id IN
	(SELECT category_id
    FROM products)
ORDER BY category_name;


-- Query #31
-- Write a SELECT statement that answers this question: 
-- Which products have a list price that’s greater than the average list price for all products?
-- Return the `product_name` and `list_price` columns for each product.
-- Sort the result set by the `list_price` column in descending sequence.
USE my_guitar_shop;
SELECT product_name, list_price
FROM products
WHERE list_price > 
	(SELECT AVG(list_price)
     FROM products)
ORDER BY list_price DESC;


-- Query #32
-- Write a SELECT statement that returns the `category_name` column from the Categories table.
-- Return one row for each category that has never been assigned to any product in the Products table. 
-- To do that, use a subquery introduced with the NOT EXISTS operator.
USE my_guitar_shop;
SELECT category_name
FROM categories
WHERE NOT EXISTS
	(SELECT *
    FROM products
    WHERE (category_id=categories.category_id));


-- Query #33
-- Write a SELECT statement that returns three columns: `email_address`, `order_id`, and the `order total` for each customer. 
-- To do this, you can group the result set by the `email_address` and `order_id` columns. 
-- In addition, you must calculate the order total from the columns in the Order_Items table.
-- **Do not submit this query - use it as a subquery**
-- Write a second SELECT statement that uses the first SELECT statement in its FROM clause.
--  The main query should return two columns: the customer’s `email address` and the largest order for that customer. 
--  To do this, you can group the result set by the `email_address`. 
--  Sort the result set by the largest order in descending sequence.  
USE my_guitar_shop;
SELECT email_address, MAX(order_total) AS max_order_total
FROM
(SELECT email_address, o.order_id, SUM((item_price - discount_amount) * quantity) AS order_total
FROM customers c
	JOIN orders o ON (c.customer_id=o.customer_id)
	JOIN order_items oi ON (o.order_id=oi.order_id)
GROUP BY email_address, order_id) AS subquery_in_from
GROUP BY email_address
ORDER BY MAX(order_total) DESC;


-- Query #34
-- Write a SELECT statement that returns the `product_name` and `discount percent` of each product that has a unique `discount percent`. 
-- In other words, don’t include products that have the same `discount percent` as another product.
-- Sort the result set by the `product_name` column.
USE my_guitar_shop;
SELECT product_name, discount_percent
FROM products 
WHERE discount_percent IN
	(SELECT discount_percent
     FROM products
     GROUP BY discount_percent
     HAVING COUNT(*) =1)
ORDER BY product_name;


-- Query #35
-- Use a correlated subquery to return one row per customer, representing the customer’s oldest order (the one with the earliest date). Each row should include these three columns: email_address, order_id, and order_date.
-- Sort the result set by the order_date and order_id columns.
USE my_guitar_shop;
SELECT email_address, o.order_id, order_date
FROM customers c
	JOIN orders o ON (c.customer_id=o.customer_id)
	JOIN order_items oi ON (o.order_id=oi.order_id)
WHERE order_date = 
	(SELECT MIN(order_date) -- for earliest date or oldest order date
	FROM orders
    WHERE customer_id=c.customer_id) -- need to reference the outer query to be correlated
GROUP BY o.order_id -- prevent duplicates in the results with same dates
ORDER BY order_date, order_id;


-- Query #36
-- Write a SELECT statement that returns these columns from the Products table:
-- The `list_price` column
-- A column that uses the FORMAT function to return the `list_price` column with 1 digit to the right of the decimal point
-- A column that uses the CONVERT function to return the `list_price` column as an integer
-- A column that uses the CAST function to return the `list_price` column as an integer
USE my_guitar_shop;
SELECT list_price, FORMAT(list_price, 1) AS format_list_price, CONVERT(list_price, SIGNED) AS convert_list_price, 
	CAST(list_price AS SIGNED) AS cast_list_price
FROM products;


-- Query #37
-- Write a SELECT statement that returns these columns from the Products table:
-- The `date_added` column
-- A column that uses the CAST function to return the date_added column with its date only (year, month, and day)
-- A column that uses the CAST function to return the date_added column with just the year and the month
-- A column that uses the CAST function to return the date_added column with its full time only (hour, minutes, and seconds)
USE my_guitar_shop;
SELECT date_added, CAST(date_added AS CHAR(7)) AS y_m_d_date, CAST(date_added AS CHAR(10)) AS year_month_date, CAST(date_added AS TIME) AS hr_min_sec_date
FROM products;


-- Query #38
-- Write a SELECT statement that returns these columns from the Products table:
-- The `list_price` column
-- The `discount_percent` column
-- A column named `discount_amount` that uses the previous two columns to calculate the discount amount and uses the ROUND function to round the result so it has 2 decimal digits
USE my_guitar_shop;
SELECT list_price, discount_percent, ROUND((list_price * (discount_percent)/100), 2) AS discount_amount
FROM products;


-- Query #39
-- Write a SELECT statement that returns these columns from the Orders table:
-- The `order_date` column
-- A column that uses the DATE_FORMAT function to return the four-digit year that’s stored in the `order_date` column
-- A column that uses the DATE_FORMAT function to return the `order_date` column in this format: Mon-DD-YYYY. In other words, use abbreviated months and separate each date component with dashes.
-- A column that uses the DATE_FORMAT function to return the `order_date` column with only the hours and minutes on a 12-hour clock with an am/pm indicator
-- A column that uses the DATE_FORMAT function to return the `order_date` column in this format: MM/DD/YY HH:i. In other words, use two-digit months, days, and years and separate them by slashes. Use 2-digit hours and minutes on a 24-hour clock. And use leading zeros for all date/time components.
USE my_guitar_shop;
SELECT order_date, DATE_FORMAT(order_date, '%Y') AS four_dig_year_date, DATE_FORMAT(order_date, '%b-%e-%Y') AS Mon_DD_YYYY,
	DATE_FORMAT(order_date, '%h:%i %p') AS hr_min_clock, DATE_FORMAT(order_date, '%m/%d/%y %H:%i') AS two_dig_mdy_with_24hr
FROM orders;


-- Query #40
-- Write a SELECT statement that returns these columns from the Orders table:
-- The `card_number` column
-- The length of the `card_number` column
-- When you get that working right, add the columns that follow to the result set. This is more difficult because these columns require the use of functions within functions.
-- The last four digits of the `card_number` column
-- A column that displays an X for each digit of the `card_number` column except for the last four digits.
-- If the card number contains 16 digits, it should be displayed in this format: XXXX-XXXX-XXXX-1234, where 1234 are the actual last four digits of the number. 
-- If the card number contains 15 digits, it should be displayed in this format: XXXX-XXXXXX-X1234. 
-- Use an IF function to determine which format to use.
USE my_guitar_shop;
SELECT card_number, LENGTH(card_number) AS len_card_numb, RIGHT(card_number, 4) AS last_four,
    IF( -- Show open seperate to keep the parentheses organized
    LENGTH(card_number) = 16, -- If the card_number length is 16 characters, 
		CONCAT(REGEXP_REPLACE((LEFT(card_number, 12)), '[0-9]+', 'XXXX-XXXX-XXXX'), '-', RIGHT(card_number, 4)), -- THEN concat(regexp_replace(from the left 12 chars, any number, replace with 'XXXX-XXXX-XXXX'), add a '-', take the last four from the right side of card_number
		CONCAT(REGEXP_REPLACE((LEFT(card_number, 12)), '[0-9]+', 'XXXX-XXXXXX-X'), RIGHT(card_number, 4)) -- ELSE concat(regexp_replace(from the left 12 chars, any number, replace with 'XXXX-XXXXXX-X'), take the last four from the right side of card_number
	) AS X_card_number_last4 -- Close seperately to keep the parentheses organized, naming column as X_card_number_last4
FROM orders;


-- Query #41
-- Write a SELECT statement that returns these columns from the Orders table:
-- The `order_id` column
-- The `order_date` column
-- A column named `approx_ship_date` that’s calculated by adding 2 days to the `order_date` column
-- The `ship_date` column if it doesn’t contain a null value
-- A column named `days_to_ship` that shows the number of days between the order date and the ship date
-- When you have this working, add a WHERE clause that retrieves just the orders for March 2018.
USE my_guitar_shop;
SELECT order_id, DATE(order_date) AS order_date, DATE(DATE_ADD(order_date, INTERVAL 2 DAY)) AS approx_ship_date, IF(ship_date IS NOT NULL, DATE(ship_date), NULL) AS ship_date,
	DATEDIFF(ship_date, order_date) AS days_to_ship
FROM orders
WHERE order_date BETWEEN '2018-03-01' AND '2018-03-31';




-- *****************************************************************************************************************************
-- ********************************************************** DB CODE ********************************************************** 
-- *****************************************************************************************************************************
CREATE DATABASE  IF NOT EXISTS `zagi` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `zagi`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: zagi
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `categoryid` char(2) NOT NULL,
  `categoryname` varchar(25) NOT NULL,
  PRIMARY KEY (`categoryid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES ('CP','Camping'),('FW','Footwear');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customerid` char(7) NOT NULL,
  `customername` varchar(15) NOT NULL,
  `customerzip` char(5) NOT NULL,
  PRIMARY KEY (`customerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES ('1-2-333','Tina','60137'),('2-3-444','Tony','60611'),('3-4-555','Pam','35401');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `includes`
--

DROP TABLE IF EXISTS `includes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `includes` (
  `productid` char(3) NOT NULL,
  `tid` varchar(8) NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`productid`,`tid`),
  KEY `tid` (`tid`),
  CONSTRAINT `includes_ibfk_1` FOREIGN KEY (`productid`) REFERENCES `product` (`productid`),
  CONSTRAINT `includes_ibfk_2` FOREIGN KEY (`tid`) REFERENCES `salestransaction` (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `includes`
--

LOCK TABLES `includes` WRITE;
/*!40000 ALTER TABLE `includes` DISABLE KEYS */;
INSERT INTO `includes` VALUES ('1X1','T111',1),('1X1','T333',1),('2X2','T222',1),('2X2','T444',2),('3X3','T333',5),('4X4','T444',1),('4X4','T555',4),('5X5','T555',2),('6X6','T555',1);
/*!40000 ALTER TABLE `includes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `productid` char(3) NOT NULL,
  `productname` varchar(25) NOT NULL,
  `productprice` decimal(7,2) NOT NULL,
  `vendorid` char(2) NOT NULL,
  `categoryid` char(2) NOT NULL,
  PRIMARY KEY (`productid`),
  KEY `vendorid` (`vendorid`),
  KEY `categoryid` (`categoryid`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`vendorid`) REFERENCES `vendor` (`vendorid`),
  CONSTRAINT `product_ibfk_2` FOREIGN KEY (`categoryid`) REFERENCES `category` (`categoryid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES ('1X1','Zzz Bag',100.00,'PG','CP'),('2X2','Easy Boot',70.00,'MK','FW'),('3X3','Cosy Sock',15.00,'MK','FW'),('4X4','Dura Boot',90.00,'PG','FW'),('5X5','Tiny Tent',150.00,'MK','CP'),('6X6','Biggy Tent',250.00,'MK','CP');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `region`
--

DROP TABLE IF EXISTS `region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `region` (
  `regionid` char(1) NOT NULL,
  `regionname` varchar(25) NOT NULL,
  PRIMARY KEY (`regionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `region`
--

LOCK TABLES `region` WRITE;
/*!40000 ALTER TABLE `region` DISABLE KEYS */;
INSERT INTO `region` VALUES ('C','Chicagoland'),('T','Tristate');
/*!40000 ALTER TABLE `region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salestransaction`
--

DROP TABLE IF EXISTS `salestransaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salestransaction` (
  `tid` varchar(8) NOT NULL,
  `customerid` char(7) NOT NULL,
  `storeid` varchar(3) NOT NULL,
  `tdate` date NOT NULL,
  PRIMARY KEY (`tid`),
  KEY `customerid` (`customerid`),
  KEY `storeid` (`storeid`),
  CONSTRAINT `salestransaction_ibfk_1` FOREIGN KEY (`customerid`) REFERENCES `customer` (`customerid`),
  CONSTRAINT `salestransaction_ibfk_2` FOREIGN KEY (`storeid`) REFERENCES `store` (`storeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salestransaction`
--

LOCK TABLES `salestransaction` WRITE;
/*!40000 ALTER TABLE `salestransaction` DISABLE KEYS */;
INSERT INTO `salestransaction` VALUES ('T111','1-2-333','S1','2020-01-01'),('T222','2-3-444','S2','2020-01-01'),('T333','1-2-333','S3','2020-01-02'),('T444','3-4-555','S3','2020-01-02'),('T555','2-3-444','S3','2020-01-02');
/*!40000 ALTER TABLE `salestransaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store`
--

DROP TABLE IF EXISTS `store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store` (
  `storeid` varchar(3) NOT NULL,
  `storezip` char(5) NOT NULL,
  `regionid` char(1) NOT NULL,
  PRIMARY KEY (`storeid`),
  KEY `regionid` (`regionid`),
  CONSTRAINT `store_ibfk_1` FOREIGN KEY (`regionid`) REFERENCES `region` (`regionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store`
--

LOCK TABLES `store` WRITE;
/*!40000 ALTER TABLE `store` DISABLE KEYS */;
INSERT INTO `store` VALUES ('S1','60600','C'),('S2','60605','C'),('S3','35400','T');
/*!40000 ALTER TABLE `store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendor`
--

DROP TABLE IF EXISTS `vendor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendor` (
  `vendorid` char(2) NOT NULL,
  `vendorname` varchar(25) NOT NULL,
  PRIMARY KEY (`vendorid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendor`
--

LOCK TABLES `vendor` WRITE;
/*!40000 ALTER TABLE `vendor` DISABLE KEYS */;
INSERT INTO `vendor` VALUES ('MK','Mountain King'),('PG','Pacifica Gear');
/*!40000 ALTER TABLE `vendor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-07 11:44:40
CREATE DATABASE  IF NOT EXISTS `my_guitar_shop` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `my_guitar_shop`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: my_guitar_shop
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `addresses` (
  `address_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `line1` varchar(60) NOT NULL,
  `line2` varchar(60) DEFAULT NULL,
  `city` varchar(40) NOT NULL,
  `state` varchar(2) NOT NULL,
  `zip_code` varchar(10) NOT NULL,
  `phone` varchar(12) NOT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`address_id`),
  KEY `addresses_fk_customers` (`customer_id`),
  CONSTRAINT `addresses_fk_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addresses`
--

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
INSERT INTO `addresses` VALUES (1,1,'100 East Ridgewood Ave.','','Paramus','NJ','07652','201-653-4472',0),(2,1,'21 Rosewood Rd.','','Woodcliff Lake','NJ','07677','201-653-4472',0),(3,2,'16285 Wendell St.','','Omaha','NE','68135','402-896-2576',0),(4,3,'19270 NW Cornell Rd.','','Beaverton','OR','97006','503-654-1291',0),(5,4,'186 Vermont St.','Apt. 2','San Francisco','CA','94110','415-292-6651',0),(6,4,'1374 46th Ave.','','San Francisco','CA','94129','415-292-6651',0),(7,5,'6982 Palm Ave.','','Fresno','CA','93711','559-431-2398',0),(8,6,'23 Mountain View St.','','Denver','CO','80208','303-912-3852',0),(9,7,'7361 N. 41st St.','Apt. B','New York','NY','10012','212-335-2093',0),(10,7,'3829 Broadway Ave.','Suite 2','New York','NY','10012','212-239-1208',0),(11,8,'2381 Buena Vista St.','','Los Angeles','CA','90023','213-772-5033',0),(12,8,'291 W. Hollywood Blvd.','','Los Angeles','CA','90024','213-391-2938',0);
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `administrators`
--

DROP TABLE IF EXISTS `administrators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `administrators` (
  `admin_id` int NOT NULL AUTO_INCREMENT,
  `email_address` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrators`
--

LOCK TABLES `administrators` WRITE;
/*!40000 ALTER TABLE `administrators` DISABLE KEYS */;
INSERT INTO `administrators` VALUES (1,'admin@myguitarshop.com','6a718fbd768c2378b511f8249b54897f940e9022','Admin','User'),(2,'joel@murach.com','971e95957d3b74d70d79c20c94e9cd91b85f7aae','Joel','Murach'),(3,'mike@murach.com','3f2975c819cefc686282456aeae3a137bf896ee8','Mike','Murach');
/*!40000 ALTER TABLE `administrators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_name` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (2,'Basses'),(3,'Drums'),(1,'Guitars'),(4,'Keyboards');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `email_address` varchar(255) NOT NULL,
  `password` varchar(60) NOT NULL,
  `first_name` varchar(60) NOT NULL,
  `last_name` varchar(60) NOT NULL,
  `shipping_address_id` int DEFAULT NULL,
  `billing_address_id` int DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `email_address` (`email_address`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'allan.sherwood@yahoo.com','650215acec746f0e32bdfff387439eefc1358737','Allan','Sherwood',1,2),(2,'barryz@gmail.com','3f563468d42a448cb1e56924529f6e7bbe529cc7','Barry','Zimmer',3,3),(3,'christineb@solarone.com','ed19f5c0833094026a2f1e9e6f08a35d26037066','Christine','Brown',4,4),(4,'david.goldstein@hotmail.com','b444ac06613fc8d63795be9ad0beaf55011936ac','David','Goldstein',5,6),(5,'erinv@gmail.com','109f4b3c50d7b0df729d299bc6f8e9ef9066971f','Erin','Valentino',7,7),(6,'frankwilson@sbcglobal.net','3ebfa301dc59196f18593c45e519287a23297589','Frank Lee','Wilson',8,8),(7,'gary_hernandez@yahoo.com','1ff2b3704aede04eecb51e50ca698efd50a1379b','Gary','Hernandez',9,10),(8,'heatheresway@mac.com','911ddc3b8f9a13b5499b6bc4638a2b4f3f68bf23','Heather','Esway',11,12);
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `item_price` decimal(10,2) NOT NULL,
  `discount_amount` decimal(10,2) NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`item_id`),
  KEY `items_fk_orders` (`order_id`),
  KEY `items_fk_products` (`product_id`),
  CONSTRAINT `items_fk_orders` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `items_fk_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,1,2,1199.00,359.70,1),(2,2,4,489.99,186.20,1),(3,3,3,2517.00,1308.84,1),(4,3,6,415.00,161.85,1),(5,4,2,1199.00,359.70,2),(6,5,5,299.00,0.00,1),(7,6,5,299.00,0.00,1),(8,7,1,699.00,209.70,1),(9,7,7,799.99,240.00,1),(10,7,9,699.99,210.00,1),(11,8,10,799.99,120.00,1),(12,9,1,699.00,209.70,1);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `order_date` datetime NOT NULL,
  `ship_amount` decimal(10,2) NOT NULL,
  `tax_amount` decimal(10,2) NOT NULL,
  `ship_date` datetime DEFAULT NULL,
  `ship_address_id` int NOT NULL,
  `card_type` varchar(50) NOT NULL,
  `card_number` char(16) NOT NULL,
  `card_expires` char(7) NOT NULL,
  `billing_address_id` int NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `orders_fk_customers` (`customer_id`),
  CONSTRAINT `orders_fk_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,'2018-03-28 09:40:28',5.00,32.32,'2018-03-30 15:32:51',1,'Visa','4111111111111111','04/2020',2),(2,2,'2018-03-28 11:23:20',5.00,0.00,'2018-03-29 12:52:14',3,'Visa','4012888888881881','08/2019',3),(3,1,'2018-03-29 09:44:58',10.00,89.92,'2018-03-31 09:11:41',1,'Visa','4111111111111111','04/2017',2),(4,3,'2018-03-30 15:22:31',5.00,0.00,'2018-04-03 16:32:21',4,'American Express','378282246310005','04/2016',4),(5,4,'2018-03-31 05:43:11',5.00,0.00,'2018-04-02 14:21:12',5,'Visa','4111111111111111','04/2019',6),(6,5,'2018-03-31 18:37:22',5.00,0.00,NULL,7,'Discover','6011111111111117','04/2019',7),(7,6,'2018-04-01 23:11:12',15.00,0.00,'2018-04-03 10:21:35',8,'MasterCard','5555555555554444','04/2019',8),(8,7,'2018-04-02 11:26:38',5.00,0.00,NULL,9,'Visa','4012888888881881','04/2019',10),(9,4,'2018-04-03 12:22:31',5.00,0.00,NULL,5,'Visa','4111111111111111','04/2019',6);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL,
  `product_code` varchar(10) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `list_price` decimal(10,2) NOT NULL,
  `discount_percent` decimal(10,2) NOT NULL DEFAULT '0.00',
  `date_added` datetime DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `product_code` (`product_code`),
  KEY `products_fk_categories` (`category_id`),
  CONSTRAINT `products_fk_categories` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,1,'strat','Fender Stratocaster','The Fender Stratocaster is the electric guitar design that changed the world. New features include a tinted neck, parchment pickguard and control knobs, and a \'70s-style logo. Includes select alder body, 21-fret maple neck with your choice of a rosewood or maple fretboard, 3 single-coil pickups, vintage-style tremolo, and die-cast tuning keys. This guitar features a thicker bridge block for increased sustain and a more stable point of contact with the strings. At this low price, why play anything but the real thing?\r\n\r\nFeatures:\r\n\r\n* New features:\r\n* Thicker bridge block\r\n* 3-ply parchment pick guard\r\n* Tinted neck',699.00,30.00,'2017-10-30 09:32:40'),(2,1,'les_paul','Gibson Les Paul','This Les Paul guitar offers a carved top and humbucking pickups. It has a simple yet elegant design. Cutting-yet-rich tone?the hallmark of the Les Paul?pours out of the 490R and 498T Alnico II magnet humbucker pickups, which are mounted on a carved maple top with a mahogany back. The faded finish models are equipped with BurstBucker Pro pickups and a mahogany top. This guitar includes a Gibson hardshell case (Faded and satin finish models come with a gig bag) and a limited lifetime warranty.\r\n\r\nFeatures:\r\n\r\n* Carved maple top and mahogany back (Mahogany top on faded finish models)\r\n* Mahogany neck, \'59 Rounded Les Paul\r\n* Rosewood fingerboard (Ebony on Alpine white)\r\n* Tune-O-Matic bridge with stopbar\r\n* Chrome or gold hardware\r\n* 490R and 498T Alnico 2 magnet humbucker pickups (BurstBucker Pro on faded finish models)\r\n* 2 volume and 2 tone knobs, 3-way switch',1199.00,30.00,'2017-12-05 16:33:13'),(3,1,'sg','Gibson SG','This Gibson SG electric guitar takes the best of the \'62 original and adds the longer and sturdier neck joint of the late \'60s models. All the classic features you\'d expect from a historic guitar. Hot humbuckers go from rich, sweet lightning to warm, tingling waves of sustain. A silky-fast rosewood fretboard plays like a dream. The original-style beveled mahogany body looks like a million bucks. Plus, Tune-O-Matic bridge and chrome hardware. Limited lifetime warranty. Includes hardshell case.\r\n\r\nFeatures:\r\n\r\n* Double-cutaway beveled mahogany body\r\n* Set mahogany neck with rounded \'50s profile\r\n* Bound rosewood fingerboard with trapezoid inlays\r\n* Tune-O-Matic bridge with stopbar tailpiece\r\n* Chrome hardware\r\n* 490R humbucker in the neck position\r\n* 498T humbucker in the bridge position\r\n* 2 volume knobs, 2 tone knobs, 3-way switch\r\n* 24-3/4\" scale',2517.00,52.00,'2018-02-04 11:04:31'),(4,1,'fg700s','Yamaha FG700S','The Yamaha FG700S solid top acoustic guitar has the ultimate combo for projection and pure tone. The expertly braced spruce top speaks clearly atop the rosewood body. It has a rosewood fingerboard, rosewood bridge, die-cast tuners, body and neck binding, and a tortoise pickguard.\r\n\r\nFeatures:\r\n\r\n* Solid Sitka spruce top\r\n* Rosewood back and sides\r\n* Rosewood fingerboard\r\n* Rosewood bridge\r\n* White/black body and neck binding\r\n* Die-cast tuners\r\n* Tortoise pickguard\r\n* Limited lifetime warranty',489.99,38.00,'2018-06-01 11:12:59'),(5,1,'washburn','Washburn D10S','The Washburn D10S acoustic guitar is superbly crafted with a solid spruce top and mahogany back and sides for exceptional tone. A mahogany neck and rosewood fingerboard make fretwork a breeze, while chrome Grover-style machines keep you perfectly tuned. The Washburn D10S comes with a limited lifetime warranty.\r\n\r\nFeatures:\r\n\r\n    * Spruce top\r\n    * Mahogany back, sides\r\n    * Mahogany neck Rosewood fingerboard\r\n    * Chrome Grover-style machines',299.00,0.00,'2018-07-30 13:58:35'),(6,1,'rodriguez','Rodriguez Caballero 11','Featuring a carefully chosen, solid Canadian cedar top and laminated bubinga back and sides, the Caballero 11 classical guitar is a beauty to behold and play. The headstock and fretboard are of Indian rosewood. Nickel-plated tuners and Silver-plated frets are installed to last a lifetime. The body binding and wood rosette are exquisite.\r\n\r\nThe Rodriguez Guitar is hand crafted and glued to create precise balances. From the invisible careful sanding, even inside the body, that ensures the finished instrument\'s purity of tone, to the beautifully unique rosette inlays around the soundhole and on the back of the neck, each guitar is a credit to its luthier and worthy of being handed down from one generation to another.\r\n\r\nThe tone, resonance and beauty of fine guitars are all dependent upon the wood from which they are made. The wood used in the construction of Rodriguez guitars is carefully chosen and aged to guarantee the highest quality. No wood is purchased before the tree has been cut down, and at least 2 years must elapse before the tree is turned into lumber. The wood has to be well cut from the log. The grain must be close and absolutely vertical. The shop is totally free from humidity.',415.00,39.00,'2018-07-30 14:12:41'),(7,2,'precision','Fender Precision','The Fender Precision bass guitar delivers the sound, look, and feel today\'s bass players demand. This bass features that classic P-Bass old-school design. Each Precision bass boasts contemporary features and refinements that make it an excellent value. Featuring an alder body and a split single-coil pickup, this classic electric bass guitar lives up to its Fender legacy.\r\n\r\nFeatures:\r\n\r\n* Body: Alder\r\n* Neck: Maple, modern C shape, tinted satin urethane finish\r\n* Fingerboard: Rosewood or maple (depending on color)\r\n* 9-1/2\" Radius (241 mm)\r\n* Frets: 20 Medium-jumbo frets\r\n* Pickups: 1 Standard Precision Bass split single-coil pickup (Mid)\r\n* Controls: Volume, Tone\r\n* Bridge: Standard vintage style with single groove saddles\r\n* Machine heads: Standard\r\n* Hardware: Chrome\r\n* Pickguard: 3-Ply Parchment\r\n* Scale Length: 34\" (864 mm)\r\n* Width at Nut: 1-5/8\" (41.3 mm)\r\n* Unique features: Knurled chrome P Bass knobs, Fender transition logo',799.99,30.00,'2018-06-01 11:29:35'),(8,2,'hofner','Hofner Icon','With authentic details inspired by the original, the Hofner Icon makes the legendary violin bass available to the rest of us. Don\'t get the idea that this a just a \"nowhere man\" look-alike. This quality instrument features a real spruce top and beautiful flamed maple back and sides. The semi-hollow body and set neck will give you the warm, round tone you expect from the violin bass.\r\n\r\nFeatures:\r\n\r\n* Authentic details inspired by the original\r\n* Spruce top\r\n* Flamed maple back and sides\r\n* Set neck\r\n* Rosewood fretboard\r\n* 30\" scale\r\n* 22 frets\r\n* Dot inlay',499.99,25.00,'2018-07-30 14:18:33'),(9,3,'ludwig','Ludwig 5-piece Drum Set with Cymbals','This product includes a Ludwig 5-piece drum set and a Zildjian starter cymbal pack.\r\n\r\nWith the Ludwig drum set, you get famous Ludwig quality. This set features a bass drum, two toms, a floor tom, and a snare?each with a wrapped finish. Drum hardware includes LA214FP bass pedal, snare stand, cymbal stand, hi-hat stand, and a throne.\r\n\r\nWith the Zildjian cymbal pack, you get a 14\" crash, 18\" crash/ride, and a pair of 13\" hi-hats. Sound grooves and round hammer strikes in a simple circular pattern on the top surface of these cymbals magnify the basic sound of the distinctive alloy.\r\n\r\nFeatures:\r\n\r\n* Famous Ludwig quality\r\n* Wrapped finishes\r\n* 22\" x 16\" kick drum\r\n* 12\" x 10\" and 13\" x 11\" toms\r\n* 16\" x 16\" floor tom\r\n* 14\" x 6-1/2\" snare drum kick pedal\r\n* Snare stand\r\n* Straight cymbal stand hi-hat stand\r\n* FREE throne',699.99,30.00,'2018-07-30 12:46:40'),(10,3,'tama','Tama 5-Piece Drum Set with Cymbals','The Tama 5-piece Drum Set is the most affordable Tama drum kit ever to incorporate so many high-end features.\r\n\r\nWith over 40 years of experience, Tama knows what drummers really want. Which is why, no matter how long you\'ve been playing the drums, no matter what budget you have to work with, Tama has the set you need, want, and can afford. Every aspect of the modern drum kit was exhaustively examined and reexamined and then improved before it was accepted as part of the Tama design. Which is why, if you start playing Tama now as a beginner, you\'ll still enjoy playing it when you\'ve achieved pro-status. That\'s how good these groundbreaking new drums are.\r\n\r\nOnly Tama comes with a complete set of genuine Meinl HCS cymbals. These high-quality brass cymbals are made in Germany and are sonically matched so they sound great together. They are even lathed for a more refined tonal character. The set includes 14\" hi-hats, 16\" crash cymbal, and a 20\" ride cymbal.\r\n\r\nFeatures:\r\n\r\n* 100% poplar 6-ply/7.5mm shells\r\n* Precise bearing edges\r\n* 100% glued finishes\r\n* Original small lugs\r\n* Drum heads\r\n* Accu-tune bass drum hoops\r\n* Spur brackets\r\n* Tom holder\r\n* Tom brackets',799.99,15.00,'2018-07-30 13:14:15');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-07 11:44:41
CREATE DATABASE  IF NOT EXISTS `hafh` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `hafh`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: hafh
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `apartment`
--

DROP TABLE IF EXISTS `apartment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `apartment` (
  `buildingid` char(3) NOT NULL,
  `aptno` char(5) NOT NULL,
  `anoofbedrooms` int NOT NULL,
  `ccid` char(4) DEFAULT NULL,
  PRIMARY KEY (`buildingid`,`aptno`),
  KEY `ccid` (`ccid`),
  CONSTRAINT `apartment_ibfk_1` FOREIGN KEY (`buildingid`) REFERENCES `building` (`buildingid`),
  CONSTRAINT `apartment_ibfk_2` FOREIGN KEY (`ccid`) REFERENCES `corpclient` (`ccid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apartment`
--

LOCK TABLES `apartment` WRITE;
/*!40000 ALTER TABLE `apartment` DISABLE KEYS */;
INSERT INTO `apartment` VALUES ('B1','21',1,'C111'),('B1','41',1,NULL),('B2','11',2,'C222'),('B2','31',2,NULL),('B3','11',2,'C777'),('B4','11',2,'C777');
/*!40000 ALTER TABLE `apartment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `building`
--

DROP TABLE IF EXISTS `building`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `building` (
  `buildingid` char(3) NOT NULL,
  `bnooffloors` int NOT NULL,
  `bmanagerid` char(4) NOT NULL,
  PRIMARY KEY (`buildingid`),
  KEY `bmanagerid` (`bmanagerid`),
  CONSTRAINT `building_ibfk_1` FOREIGN KEY (`bmanagerid`) REFERENCES `manager` (`managerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `building`
--

LOCK TABLES `building` WRITE;
/*!40000 ALTER TABLE `building` DISABLE KEYS */;
INSERT INTO `building` VALUES ('B1',5,'M12'),('B2',6,'M23'),('B3',4,'M23'),('B4',4,'M34');
/*!40000 ALTER TABLE `building` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cleaning`
--

DROP TABLE IF EXISTS `cleaning`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cleaning` (
  `buildingid` char(3) NOT NULL,
  `aptno` char(5) NOT NULL,
  `smemberid` char(4) NOT NULL,
  PRIMARY KEY (`buildingid`,`aptno`,`smemberid`),
  KEY `cleaningfk2` (`smemberid`),
  CONSTRAINT `cleaningfk1` FOREIGN KEY (`buildingid`, `aptno`) REFERENCES `apartment` (`buildingid`, `aptno`),
  CONSTRAINT `cleaningfk2` FOREIGN KEY (`smemberid`) REFERENCES `staffmember` (`smemberid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cleaning`
--

LOCK TABLES `cleaning` WRITE;
/*!40000 ALTER TABLE `cleaning` DISABLE KEYS */;
INSERT INTO `cleaning` VALUES ('B1','21','5432'),('B2','31','5432'),('B3','11','5432'),('B4','11','7652'),('B1','41','9876'),('B2','11','9876');
/*!40000 ALTER TABLE `cleaning` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corpclient`
--

DROP TABLE IF EXISTS `corpclient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `corpclient` (
  `ccid` char(4) NOT NULL,
  `ccname` varchar(25) NOT NULL,
  `ccindustry` varchar(25) NOT NULL,
  `cclocation` varchar(25) NOT NULL,
  `ccidreferredby` char(4) DEFAULT NULL,
  PRIMARY KEY (`ccid`),
  UNIQUE KEY `ccname` (`ccname`),
  KEY `ccidreferredby` (`ccidreferredby`),
  CONSTRAINT `corpclient_ibfk_1` FOREIGN KEY (`ccidreferredby`) REFERENCES `corpclient` (`ccid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corpclient`
--

LOCK TABLES `corpclient` WRITE;
/*!40000 ALTER TABLE `corpclient` DISABLE KEYS */;
INSERT INTO `corpclient` VALUES ('C111','BlingNotes','Music','Chicago',NULL),('C222','SkyJet','Airline','Oak Park','C111'),('C777','WindyCT','Music','Chicago','C222'),('C888','SouthAlps','Sports','Rosemont','C777');
/*!40000 ALTER TABLE `corpclient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inspecting`
--

DROP TABLE IF EXISTS `inspecting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inspecting` (
  `insid` char(3) NOT NULL,
  `buildingid` char(3) NOT NULL,
  `datelast` date NOT NULL,
  `datenext` date NOT NULL,
  PRIMARY KEY (`insid`,`buildingid`),
  KEY `buildingid` (`buildingid`),
  CONSTRAINT `inspecting_ibfk_1` FOREIGN KEY (`insid`) REFERENCES `inspector` (`insid`),
  CONSTRAINT `inspecting_ibfk_2` FOREIGN KEY (`buildingid`) REFERENCES `building` (`buildingid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inspecting`
--

LOCK TABLES `inspecting` WRITE;
/*!40000 ALTER TABLE `inspecting` DISABLE KEYS */;
INSERT INTO `inspecting` VALUES ('I11','B1','2019-05-05','2020-05-05'),('I11','B2','2019-02-02','2020-02-02'),('I22','B2','2019-04-03','2020-02-02'),('I22','B3','2019-08-09','2020-03-03'),('I33','B3','2019-04-04','2020-04-04'),('I33','B4','2019-05-05','2020-04-04');
/*!40000 ALTER TABLE `inspecting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inspector`
--

DROP TABLE IF EXISTS `inspector`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inspector` (
  `insid` char(3) NOT NULL,
  `insname` varchar(15) NOT NULL,
  PRIMARY KEY (`insid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inspector`
--

LOCK TABLES `inspector` WRITE;
/*!40000 ALTER TABLE `inspector` DISABLE KEYS */;
INSERT INTO `inspector` VALUES ('I11','Jane'),('I22','Niko'),('I33','Mick');
/*!40000 ALTER TABLE `inspector` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manager`
--

DROP TABLE IF EXISTS `manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manager` (
  `managerid` char(4) NOT NULL,
  `mfname` varchar(15) NOT NULL,
  `mlname` varchar(15) NOT NULL,
  `mbdate` date NOT NULL,
  `msalary` decimal(9,2) NOT NULL,
  `mbonus` decimal(9,2) DEFAULT NULL,
  `mresbuildingid` char(3) NOT NULL,
  PRIMARY KEY (`managerid`),
  KEY `fkresidesin` (`mresbuildingid`),
  CONSTRAINT `fkresidesin` FOREIGN KEY (`mresbuildingid`) REFERENCES `building` (`buildingid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager`
--

LOCK TABLES `manager` WRITE;
/*!40000 ALTER TABLE `manager` DISABLE KEYS */;
INSERT INTO `manager` VALUES ('M12','Boris','Grant','1980-06-20',60000.00,NULL,'B1'),('M23','Austin','Lee','1975-10-30',50000.00,5000.00,'B2'),('M34','George','Sherman','1976-01-11',52000.00,2000.00,'B4');
/*!40000 ALTER TABLE `manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `managerphone`
--

DROP TABLE IF EXISTS `managerphone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `managerphone` (
  `managerid` char(4) NOT NULL,
  `mphone` char(11) NOT NULL,
  PRIMARY KEY (`managerid`,`mphone`),
  CONSTRAINT `managerphone_ibfk_1` FOREIGN KEY (`managerid`) REFERENCES `manager` (`managerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `managerphone`
--

LOCK TABLES `managerphone` WRITE;
/*!40000 ALTER TABLE `managerphone` DISABLE KEYS */;
INSERT INTO `managerphone` VALUES ('M12','555-2222'),('M12','555-3232'),('M23','555-9988'),('M34','555-9999');
/*!40000 ALTER TABLE `managerphone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staffmember`
--

DROP TABLE IF EXISTS `staffmember`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staffmember` (
  `smemberid` char(4) NOT NULL,
  `smembername` varchar(15) NOT NULL,
  PRIMARY KEY (`smemberid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staffmember`
--

LOCK TABLES `staffmember` WRITE;
/*!40000 ALTER TABLE `staffmember` DISABLE KEYS */;
INSERT INTO `staffmember` VALUES ('5432','Brian'),('7652','Caroline'),('9876','Boris');
/*!40000 ALTER TABLE `staffmember` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-07 11:44:41
/********************************************************
* This script creates the database named my_guitar_shop 
*********************************************************/

DROP DATABASE IF EXISTS my_guitar_shop;
CREATE DATABASE my_guitar_shop;
USE my_guitar_shop;

-- create the tables for the database
CREATE TABLE categories (
  category_id        INT            PRIMARY KEY   AUTO_INCREMENT,
  category_name      VARCHAR(255)   NOT NULL      UNIQUE
);

CREATE TABLE products (
  product_id         INT            PRIMARY KEY   AUTO_INCREMENT,
  category_id        INT            NOT NULL,
  product_code       VARCHAR(10)    NOT NULL      UNIQUE,
  product_name       VARCHAR(255)   NOT NULL,
  description        TEXT           NOT NULL,
  list_price         DECIMAL(10,2)  NOT NULL,
  discount_percent   DECIMAL(10,2)  NOT NULL      DEFAULT 0.00,
  date_added         DATETIME                     DEFAULT NULL,
  CONSTRAINT products_fk_categories
    FOREIGN KEY (category_id)
    REFERENCES categories (category_id)
);

CREATE TABLE customers (
  customer_id           INT            PRIMARY KEY   AUTO_INCREMENT,
  email_address         VARCHAR(255)   NOT NULL      UNIQUE,
  password              VARCHAR(60)    NOT NULL,
  first_name            VARCHAR(60)    NOT NULL,
  last_name             VARCHAR(60)    NOT NULL,
  shipping_address_id   INT                          DEFAULT NULL,
  billing_address_id    INT                          DEFAULT NULL
);

CREATE TABLE addresses (
  address_id         INT            PRIMARY KEY   AUTO_INCREMENT,
  customer_id        INT            NOT NULL,
  line1              VARCHAR(60)    NOT NULL,
  line2              VARCHAR(60)                  DEFAULT NULL,
  city               VARCHAR(40)    NOT NULL,
  state              VARCHAR(2)     NOT NULL,
  zip_code           VARCHAR(10)    NOT NULL,
  phone              VARCHAR(12)    NOT NULL,
  disabled           TINYINT(1)     NOT NULL      DEFAULT 0,
  CONSTRAINT addresses_fk_customers
    FOREIGN KEY (customer_id)
    REFERENCES customers (customer_id)
);

CREATE TABLE orders (
  order_id           INT            PRIMARY KEY  AUTO_INCREMENT,
  customer_id        INT            NOT NULL,
  order_date         DATETIME       NOT NULL,
  ship_amount        DECIMAL(10,2)  NOT NULL,
  tax_amount         DECIMAL(10,2)  NOT NULL,
  ship_date          DATETIME                    DEFAULT NULL,
  ship_address_id    INT            NOT NULL,
  card_type          VARCHAR(50)    NOT NULL,
  card_number        CHAR(16)       NOT NULL,
  card_expires       CHAR(7)        NOT NULL,
  billing_address_id  INT           NOT NULL,
  CONSTRAINT orders_fk_customers
    FOREIGN KEY (customer_id)
    REFERENCES customers (customer_id)
);

CREATE TABLE order_items (
  item_id            INT            PRIMARY KEY  AUTO_INCREMENT,
  order_id           INT            NOT NULL,
  product_id         INT            NOT NULL,
  item_price         DECIMAL(10,2)  NOT NULL,
  discount_amount    DECIMAL(10,2)  NOT NULL,
  quantity           INT            NOT NULL,
  CONSTRAINT items_fk_orders
    FOREIGN KEY (order_id)
    REFERENCES orders (order_id), 
  CONSTRAINT items_fk_products
    FOREIGN KEY (product_id)
    REFERENCES products (product_id)
);

CREATE TABLE administrators (
  admin_id           INT            PRIMARY KEY   AUTO_INCREMENT,
  email_address      VARCHAR(255)   NOT NULL,
  password           VARCHAR(255)   NOT NULL,
  first_name         VARCHAR(255)   NOT NULL,
  last_name          VARCHAR(255)   NOT NULL
);

-- Insert data into the tables
INSERT INTO categories (category_id, category_name) VALUES
(1, 'Guitars'),
(2, 'Basses'),
(3, 'Drums'), 
(4, 'Keyboards');

INSERT INTO products (product_id, category_id, product_code, product_name, description, list_price, discount_percent, date_added) VALUES
(1, 1, 'strat', 'Fender Stratocaster', 'The Fender Stratocaster is the electric guitar design that changed the world. New features include a tinted neck, parchment pickguard and control knobs, and a ''70s-style logo. Includes select alder body, 21-fret maple neck with your choice of a rosewood or maple fretboard, 3 single-coil pickups, vintage-style tremolo, and die-cast tuning keys. This guitar features a thicker bridge block for increased sustain and a more stable point of contact with the strings. At this low price, why play anything but the real thing?\r\n\r\nFeatures:\r\n\r\n* New features:\r\n* Thicker bridge block\r\n* 3-ply parchment pick guard\r\n* Tinted neck', '699.00', '30.00', '2017-10-30 09:32:40'),
(2, 1, 'les_paul', 'Gibson Les Paul', 'This Les Paul guitar offers a carved top and humbucking pickups. It has a simple yet elegant design. Cutting-yet-rich tone?the hallmark of the Les Paul?pours out of the 490R and 498T Alnico II magnet humbucker pickups, which are mounted on a carved maple top with a mahogany back. The faded finish models are equipped with BurstBucker Pro pickups and a mahogany top. This guitar includes a Gibson hardshell case (Faded and satin finish models come with a gig bag) and a limited lifetime warranty.\r\n\r\nFeatures:\r\n\r\n* Carved maple top and mahogany back (Mahogany top on faded finish models)\r\n* Mahogany neck, ''59 Rounded Les Paul\r\n* Rosewood fingerboard (Ebony on Alpine white)\r\n* Tune-O-Matic bridge with stopbar\r\n* Chrome or gold hardware\r\n* 490R and 498T Alnico 2 magnet humbucker pickups (BurstBucker Pro on faded finish models)\r\n* 2 volume and 2 tone knobs, 3-way switch', '1199.00', '30.00', '2017-12-05 16:33:13'),
(3, 1, 'sg', 'Gibson SG', 'This Gibson SG electric guitar takes the best of the ''62 original and adds the longer and sturdier neck joint of the late ''60s models. All the classic features you''d expect from a historic guitar. Hot humbuckers go from rich, sweet lightning to warm, tingling waves of sustain. A silky-fast rosewood fretboard plays like a dream. The original-style beveled mahogany body looks like a million bucks. Plus, Tune-O-Matic bridge and chrome hardware. Limited lifetime warranty. Includes hardshell case.\r\n\r\nFeatures:\r\n\r\n* Double-cutaway beveled mahogany body\r\n* Set mahogany neck with rounded ''50s profile\r\n* Bound rosewood fingerboard with trapezoid inlays\r\n* Tune-O-Matic bridge with stopbar tailpiece\r\n* Chrome hardware\r\n* 490R humbucker in the neck position\r\n* 498T humbucker in the bridge position\r\n* 2 volume knobs, 2 tone knobs, 3-way switch\r\n* 24-3/4" scale', '2517.00', '52.00', '2018-02-04 11:04:31'),
(4, 1, 'fg700s', 'Yamaha FG700S', 'The Yamaha FG700S solid top acoustic guitar has the ultimate combo for projection and pure tone. The expertly braced spruce top speaks clearly atop the rosewood body. It has a rosewood fingerboard, rosewood bridge, die-cast tuners, body and neck binding, and a tortoise pickguard.\r\n\r\nFeatures:\r\n\r\n* Solid Sitka spruce top\r\n* Rosewood back and sides\r\n* Rosewood fingerboard\r\n* Rosewood bridge\r\n* White/black body and neck binding\r\n* Die-cast tuners\r\n* Tortoise pickguard\r\n* Limited lifetime warranty', '489.99', '38.00', '2018-06-01 11:12:59'),
(5, 1, 'washburn', 'Washburn D10S', 'The Washburn D10S acoustic guitar is superbly crafted with a solid spruce top and mahogany back and sides for exceptional tone. A mahogany neck and rosewood fingerboard make fretwork a breeze, while chrome Grover-style machines keep you perfectly tuned. The Washburn D10S comes with a limited lifetime warranty.\r\n\r\nFeatures:\r\n\r\n    * Spruce top\r\n    * Mahogany back, sides\r\n    * Mahogany neck Rosewood fingerboard\r\n    * Chrome Grover-style machines', '299.00', '0.00', '2018-07-30 13:58:35'),
(6, 1, 'rodriguez', 'Rodriguez Caballero 11', 'Featuring a carefully chosen, solid Canadian cedar top and laminated bubinga back and sides, the Caballero 11 classical guitar is a beauty to behold and play. The headstock and fretboard are of Indian rosewood. Nickel-plated tuners and Silver-plated frets are installed to last a lifetime. The body binding and wood rosette are exquisite.\r\n\r\nThe Rodriguez Guitar is hand crafted and glued to create precise balances. From the invisible careful sanding, even inside the body, that ensures the finished instrument''s purity of tone, to the beautifully unique rosette inlays around the soundhole and on the back of the neck, each guitar is a credit to its luthier and worthy of being handed down from one generation to another.\r\n\r\nThe tone, resonance and beauty of fine guitars are all dependent upon the wood from which they are made. The wood used in the construction of Rodriguez guitars is carefully chosen and aged to guarantee the highest quality. No wood is purchased before the tree has been cut down, and at least 2 years must elapse before the tree is turned into lumber. The wood has to be well cut from the log. The grain must be close and absolutely vertical. The shop is totally free from humidity.', '415.00', '39.00', '2018-07-30 14:12:41'),
(7, 2, 'precision', 'Fender Precision', 'The Fender Precision bass guitar delivers the sound, look, and feel today''s bass players demand. This bass features that classic P-Bass old-school design. Each Precision bass boasts contemporary features and refinements that make it an excellent value. Featuring an alder body and a split single-coil pickup, this classic electric bass guitar lives up to its Fender legacy.\r\n\r\nFeatures:\r\n\r\n* Body: Alder\r\n* Neck: Maple, modern C shape, tinted satin urethane finish\r\n* Fingerboard: Rosewood or maple (depending on color)\r\n* 9-1/2" Radius (241 mm)\r\n* Frets: 20 Medium-jumbo frets\r\n* Pickups: 1 Standard Precision Bass split single-coil pickup (Mid)\r\n* Controls: Volume, Tone\r\n* Bridge: Standard vintage style with single groove saddles\r\n* Machine heads: Standard\r\n* Hardware: Chrome\r\n* Pickguard: 3-Ply Parchment\r\n* Scale Length: 34" (864 mm)\r\n* Width at Nut: 1-5/8" (41.3 mm)\r\n* Unique features: Knurled chrome P Bass knobs, Fender transition logo', '799.99', '30.00', '2018-06-01 11:29:35'),
(8, 2, 'hofner', 'Hofner Icon', 'With authentic details inspired by the original, the Hofner Icon makes the legendary violin bass available to the rest of us. Don''t get the idea that this a just a "nowhere man" look-alike. This quality instrument features a real spruce top and beautiful flamed maple back and sides. The semi-hollow body and set neck will give you the warm, round tone you expect from the violin bass.\r\n\r\nFeatures:\r\n\r\n* Authentic details inspired by the original\r\n* Spruce top\r\n* Flamed maple back and sides\r\n* Set neck\r\n* Rosewood fretboard\r\n* 30" scale\r\n* 22 frets\r\n* Dot inlay', '499.99', '25.00', '2018-07-30 14:18:33'),
(9, 3, 'ludwig', 'Ludwig 5-piece Drum Set with Cymbals', 'This product includes a Ludwig 5-piece drum set and a Zildjian starter cymbal pack.\r\n\r\nWith the Ludwig drum set, you get famous Ludwig quality. This set features a bass drum, two toms, a floor tom, and a snare?each with a wrapped finish. Drum hardware includes LA214FP bass pedal, snare stand, cymbal stand, hi-hat stand, and a throne.\r\n\r\nWith the Zildjian cymbal pack, you get a 14" crash, 18" crash/ride, and a pair of 13" hi-hats. Sound grooves and round hammer strikes in a simple circular pattern on the top surface of these cymbals magnify the basic sound of the distinctive alloy.\r\n\r\nFeatures:\r\n\r\n* Famous Ludwig quality\r\n* Wrapped finishes\r\n* 22" x 16" kick drum\r\n* 12" x 10" and 13" x 11" toms\r\n* 16" x 16" floor tom\r\n* 14" x 6-1/2" snare drum kick pedal\r\n* Snare stand\r\n* Straight cymbal stand hi-hat stand\r\n* FREE throne', '699.99', '30.00', '2018-07-30 12:46:40'),
(10, 3, 'tama', 'Tama 5-Piece Drum Set with Cymbals', 'The Tama 5-piece Drum Set is the most affordable Tama drum kit ever to incorporate so many high-end features.\r\n\r\nWith over 40 years of experience, Tama knows what drummers really want. Which is why, no matter how long you''ve been playing the drums, no matter what budget you have to work with, Tama has the set you need, want, and can afford. Every aspect of the modern drum kit was exhaustively examined and reexamined and then improved before it was accepted as part of the Tama design. Which is why, if you start playing Tama now as a beginner, you''ll still enjoy playing it when you''ve achieved pro-status. That''s how good these groundbreaking new drums are.\r\n\r\nOnly Tama comes with a complete set of genuine Meinl HCS cymbals. These high-quality brass cymbals are made in Germany and are sonically matched so they sound great together. They are even lathed for a more refined tonal character. The set includes 14" hi-hats, 16" crash cymbal, and a 20" ride cymbal.\r\n\r\nFeatures:\r\n\r\n* 100% poplar 6-ply/7.5mm shells\r\n* Precise bearing edges\r\n* 100% glued finishes\r\n* Original small lugs\r\n* Drum heads\r\n* Accu-tune bass drum hoops\r\n* Spur brackets\r\n* Tom holder\r\n* Tom brackets', '799.99', '15.00', '2018-07-30 13:14:15');

INSERT INTO customers (customer_id, email_address, password, first_name, last_name, shipping_address_id, billing_address_id) VALUES
(1, 'allan.sherwood@yahoo.com', '650215acec746f0e32bdfff387439eefc1358737', 'Allan', 'Sherwood', 1, 2),
(2, 'barryz@gmail.com', '3f563468d42a448cb1e56924529f6e7bbe529cc7', 'Barry', 'Zimmer', 3, 3),
(3, 'christineb@solarone.com', 'ed19f5c0833094026a2f1e9e6f08a35d26037066', 'Christine', 'Brown', 4, 4),
(4, 'david.goldstein@hotmail.com', 'b444ac06613fc8d63795be9ad0beaf55011936ac', 'David', 'Goldstein', 5, 6),
(5, 'erinv@gmail.com', '109f4b3c50d7b0df729d299bc6f8e9ef9066971f', 'Erin', 'Valentino', 7, 7),
(6, 'frankwilson@sbcglobal.net', '3ebfa301dc59196f18593c45e519287a23297589', 'Frank Lee', 'Wilson', 8, 8),
(7, 'gary_hernandez@yahoo.com', '1ff2b3704aede04eecb51e50ca698efd50a1379b', 'Gary', 'Hernandez', 9, 10),
(8, 'heatheresway@mac.com', '911ddc3b8f9a13b5499b6bc4638a2b4f3f68bf23', 'Heather', 'Esway', 11, 12);

INSERT INTO addresses (address_id, customer_id, line1, line2, city, state, zip_code, phone, disabled) VALUES
(1, 1, '100 East Ridgewood Ave.', '', 'Paramus', 'NJ', '07652', '201-653-4472', 0),
(2, 1, '21 Rosewood Rd.', '', 'Woodcliff Lake', 'NJ', '07677', '201-653-4472', 0),
(3, 2, '16285 Wendell St.', '', 'Omaha', 'NE', '68135', '402-896-2576', 0),
(4, 3, '19270 NW Cornell Rd.', '', 'Beaverton', 'OR', '97006', '503-654-1291', 0),
(5, 4, '186 Vermont St.', 'Apt. 2', 'San Francisco', 'CA', '94110', '415-292-6651', 0),
(6, 4, '1374 46th Ave.', '', 'San Francisco', 'CA', '94129', '415-292-6651', 0),
(7, 5, '6982 Palm Ave.', '', 'Fresno', 'CA', '93711', '559-431-2398', 0),
(8, 6, '23 Mountain View St.', '', 'Denver', 'CO', '80208', '303-912-3852', 0),
(9, 7, '7361 N. 41st St.', 'Apt. B', 'New York', 'NY', '10012', '212-335-2093', 0),
(10, 7, '3829 Broadway Ave.', 'Suite 2', 'New York', 'NY', '10012', '212-239-1208', 0),
(11, 8, '2381 Buena Vista St.', '', 'Los Angeles', 'CA', '90023', '213-772-5033', 0),
(12, 8, '291 W. Hollywood Blvd.', '', 'Los Angeles', 'CA', '90024', '213-391-2938', 0);

INSERT INTO orders (order_id, customer_id, order_date, ship_amount, tax_amount, ship_date, ship_address_id, card_type, card_number, card_expires, billing_address_id) VALUES
(1, 1, '2018-03-28 09:40:28', '5.00', '32.32', '2018-03-30 15:32:51', 1, 'Visa', '4111111111111111', '04/2020', 2),
(2, 2, '2018-03-28 11:23:20', '5.00', '0.00', '2018-03-29 12:52:14', 3, 'Visa', '4012888888881881', '08/2019', 3),
(3, 1, '2018-03-29 09:44:58', '10.00', '89.92', '2018-03-31 9:11:41', 1, 'Visa', '4111111111111111', '04/2017', 2),
(4, 3, '2018-03-30 15:22:31', '5.00', '0.00', '2018-04-03 16:32:21', 4, 'American Express', '378282246310005', '04/2016', 4),
(5, 4, '2018-03-31 05:43:11', '5.00', '0.00', '2018-04-02 14:21:12', 5, 'Visa', '4111111111111111', '04/2019', 6),
(6, 5, '2018-03-31 18:37:22', '5.00', '0.00', NULL, 7, 'Discover', '6011111111111117', '04/2019', 7),
(7, 6, '2018-04-01 23:11:12', '15.00', '0.00', '2018-04-03 10:21:35', 8, 'MasterCard', '5555555555554444', '04/2019', 8),
(8, 7, '2018-04-02 11:26:38', '5.00', '0.00', NULL, 9, 'Visa', '4012888888881881', '04/2019', 10),
(9, 4, '2018-04-03 12:22:31', '5.00', '0.00', NULL, 5, 'Visa', '4111111111111111', '04/2019', 6);

INSERT INTO order_items (item_id, order_id, product_id, item_price, discount_amount, quantity) VALUES
(1, 1, 2, '1199.00', '359.70', 1),
(2, 2, 4, '489.99', '186.20', 1),
(3, 3, 3, '2517.00', '1308.84', 1),
(4, 3, 6, '415.00', '161.85', 1),
(5, 4, 2, '1199.00', '359.70', 2),
(6, 5, 5, '299.00', '0.00', 1),
(7, 6, 5, '299.00', '0.00', 1),
(8, 7, 1, '699.00', '209.70', 1),
(9, 7, 7, '799.99', '240.00', 1),
(10, 7, 9, '699.99', '210.00', 1),
(11, 8, 10, '799.99', '120.00', 1),
(12, 9, 1, '699.00', '209.70', 1);

INSERT INTO administrators (admin_id, email_address, password, first_name, last_name) VALUES
(1, 'admin@myguitarshop.com', '6a718fbd768c2378b511f8249b54897f940e9022', 'Admin', 'User'),
(2, 'joel@murach.com', '971e95957d3b74d70d79c20c94e9cd91b85f7aae', 'Joel', 'Murach'),
(3, 'mike@murach.com', '3f2975c819cefc686282456aeae3a137bf896ee8', 'Mike', 'Murach');
