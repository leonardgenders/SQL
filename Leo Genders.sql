-- This codespace aims to demonstrate my ability to use SQL to perform queries relevant to data science and business intelligence applications. 
-- Author: Leo Genders
-- Date: 31 March 2024


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
