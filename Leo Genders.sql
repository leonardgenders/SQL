-- M3-Q1
-- Please use all lowercase for table names. 
-- In the Code window on the upper left, write a query that will:
-- Write a SELECT statement that returns four columns from the Products table: 
-- `product_code`, `product_name`, `list_price`, and `discount_percent`. 
-- Sort the result set by `list price` 
SELECT product_code, product_name, list_price, discount_percent
FROM my_guitar_shop.products
ORDER BY list_price;



-- M3-Q2
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




-- M3-Q3
-- Write a SELECT statement that returns these columns from the Products table:
-- `product_name`  The product_name column
-- `list_price`    The list_price column
-- `date_added`    The date_added column
-- Return only the rows with a `list price` that’s greater than 500 and less than 2000.
-- Sort the result set by the `date_added` column in descending sequence.
SELECT product_name, list_price, date_added
FROM products
WHERE list_price BETWEEN 501 AND 1999;




-- M4-Q4
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




-- M3-Q5
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


-- M3-Q6
-- Write a SELECT statement that returns these columns from the Orders table:
-- `order_id` -	The order_id column
-- `order_date` -	The order_date column
-- `ship_date`	- The ship_date column
-- Return only the rows where the `ship_date` column contains a null value.
SELECT order_id, order_date, ship_date
FROM orders
WHERE ship_date IS NULL;



-- M3-Q7
-- select that `last name`, `first name` and 
-- `initials` (first name initial, last name initial) from the customer table
-- Return only customers with a yahoo.com email address
SELECT last_name, first_name, 
	CONCAT(LEFT(first_name, 1), LEFT(last_name, 1)) AS initials
FROM customers
WHERE email_address REGEXP 'yahoo.com$';





-- M3-Q8
-- Write a SELECT statement without a FROM clause that creates a row with these columns:
-- `price`	- 100 (dollars)
-- `tax_rate` -	.07 (7 percent)
-- `tax_amount` -	The price multiplied by the tax
-- `total`	 - The price plus the tax
-- To calculate the fourth column, add the expressions you used for the first and third columns.       
SELECT 100 AS price, .07 AS tax_rate, 100 * .07 AS tax_amount, 100 + (100 * .07) AS total;




       
-- M3-Q9
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


-- M3-Q10
-- Retrieve all orders between given March 1,2018 and March 31, 2018
-- Select the following columns:order_id, order_date and ship_date
SELECT order_id, order_date, ship_date
FROM orders
WHERE order_date BETWEEN '2018-03-01' AND '2018-03-31';


