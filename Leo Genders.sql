-- Challenge #1
-- Please use all lowercase for table names. 
-- In the Code window on the upper left, write a query that will:
-- Write a SELECT statement that returns four columns from the Products table: 
-- `product_code`, `product_name`, `list_price`, and `discount_percent`. 
-- Sort the result set by `list price` 
SELECT product_code, product_name, list_price, discount_percent
FROM my_guitar_shop.products
ORDER BY list_price;


-- Challenge #2
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


-- Challenge #3
-- Write a SELECT statement that returns these columns from the Products table:
-- `product_name`  The product_name column
-- `list_price`    The list_price column
-- `date_added`    The date_added column
-- Return only the rows with a `list price` that’s greater than 500 and less than 2000.
-- Sort the result set by the `date_added` column in descending sequence.
SELECT product_name, list_price, date_added
FROM products
WHERE list_price BETWEEN 501 AND 1999;


-- Challenge #4
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


-- Challenge #5
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


-- Challenge #6 
-- Write a SELECT statement that returns these columns from the Orders table:
-- `order_id` -	The order_id column
-- `order_date` -	The order_date column
-- `ship_date`	- The ship_date column
-- Return only the rows where the `ship_date` column contains a null value.
SELECT order_id, order_date, ship_date
FROM orders
WHERE ship_date IS NULL;


-- Challenge #7
-- select that `last name`, `first name` and 
-- `initials` (first name initial, last name initial) from the customer table
-- Return only customers with a yahoo.com email address
SELECT last_name, first_name, 
	CONCAT(LEFT(first_name, 1), LEFT(last_name, 1)) AS initials
FROM customers
WHERE email_address REGEXP 'yahoo.com$';


-- Challenge #8
-- Write a SELECT statement without a FROM clause that creates a row with these columns:
-- `price`	- 100 (dollars)
-- `tax_rate` -	.07 (7 percent)
-- `tax_amount` -	The price multiplied by the tax
-- `total`	 - The price plus the tax
-- To calculate the fourth column, add the expressions you used for the first and third columns.       
SELECT 100 AS price, .07 AS tax_rate, 100 * .07 AS tax_amount, 100 + (100 * .07) AS total;

       
-- Challenge #9
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
SELECT CONCAT(line1, '\n', line2, '\n', city, ', ', state, ' ', zip_code) as address
FROM addresses;
-- ****I inserted an additional carriage return to accomodate line 2 addresses such as 'Suite 2' for 3829 Broadway Ave****
-- ****I added a space after the comma following city to properly space the 'city, state' format****
-- ****I needed to unselect 'wrap cell content' to properly view****


-- Challenge #10 
-- Retrieve all orders between given March 1,2018 and March 31, 2018
-- Select the following columns:order_id, order_date and ship_date
SELECT order_id, order_date, ship_date
FROM orders
WHERE order_date BETWEEN '2018-03-01' AND '2018-03-31';


-- Challenge #11 - Retrieve data from one or more tables- use zagi
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


-- Challenge #12 - Retrieve data from one or more tables - outer join- use hafh
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


-- Challenge #13 - Summary queries - use my_guitar_shop
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
    

-- Challenge #14 - Summary queries - use my_guitar_shop
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


-- Challenge #15 - Summary queries - use my_guitar_shop
-- Modify the solution to exercise Challenge 4 so the column that contains the total amount for 
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


-- Challenge #16 - Summary queries - use my_guitar_shop
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

