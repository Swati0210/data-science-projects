USE creating;

-- 1.Write a SQL query to retrieve the first 5 rows from the "customers" table .

SELECT 
    *
FROM
    customers
LIMIT 5;

-- 2. Write a SQL query to retrieve the unique city names from "customers" table sorted in descending order.

SELECT DISTINCT
    city
FROM
    customers
ORDER BY city DESC;

-- 3. Write a SQL query to get the number of unique city names "offices" table

SELECT 
    COUNT(DISTINCT city) AS unique_city_count
FROM
    offices; -- 7 unique are there
    
--  4. Write a SQL query to get the maximum, minimum and average value from the "age" column in the "customers" table.

SELECT min(age) as Minimum_age, max(age) as Maximum_age, avg(age) as Average_age FROM customers; -- AGE column is not present

-- 5. Write a SQL query to get the city names which are present in “offices” table but not in “customer” table.

SELECT city from offices 
except
select city from customers; -- Tokyo, Sydney, London

-- 6. Write a SQL query to get the city names which are present in “offices” table as well as in “customer” table
SELECT city from offices 
union
select city from customers;

-- 7. Write a SQL query to get records where city or state is not given in “customer” table and creditlimit is in the range – 80000 to 130000.

SELECT 
    city, state, creditLimit
FROM
    customers
WHERE
    city IS NULL OR state IS NULL
        AND creditLimit > 80000
        AND creditLimit < 130000
order by creditLimit;

-- 8. Write a SQL query to get the maximum number of orders placed on a particular date and what is that date in orders table.

SELECT 
    orderDate, MAX(customerNumber) AS Max_no_of_order_placed
FROM
    orders
GROUP BY orderDate
ORDER BY orderDate;

-- 9. For the records which we get in previous question(Q8), write a SQL query to get the customer names and their phone numbers

SELECT 
    a.orderDate, MAX(a.customerNumber) AS Max_no_of_order_placed, b.customerName, b.phone
FROM
    orders a
inner join customers b
on a.customerNumber= b.customerNumber
GROUP BY a.orderDate, b.customerName, b.phone
ORDER BY orderDate;

-- 10. SQL query to get the customer phone number and customer name from customers table where order is either cancelled or disputed in orders table.

SELECT 
    a.customerName, a.phone,  b.status
FROM
    customers a
inner join orders b
on a.customerNumber= b.customerNumber
where b.status in ('cancelled', 'disputed');

-- 11. Write a SQL query to get the top 4 highest selling products from orderdetails table.

SELECT 
    productcode, SUM(quantityOrdered) AS Total_quantity
FROM
    orderdetails
GROUP BY productcode
ORDER BY Total_quantity DESC
LIMIT 4;

-- 12. Write a SQL query to get the count of orders placed by each customer in 2003 and 2004

SELECT
    customerNumber,
    COUNT(*) AS order_Count
FROM
    orders
WHERE
    orderDate >= '2003-01-01' AND orderDate <= '2004-12-31'
GROUP BY
    customerNumber
order by order_Count;

-- 13. Write a SQL query to get the city names from customer table where more than 4 customers reside

SELECT 
    city, COUNT(customerName) Total_customer_count
FROM
    customers
GROUP BY city
HAVING Total_customer_count > 4; -- NYC, Madrid