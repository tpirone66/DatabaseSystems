/*
-- Trevor Pirone --
-- 10/15/2017 --
-- CMPT 308L --
-- Lab Assignment #6 --
*/

--------------------------------------------------------------

-- Query 1 --

SELECT name, city
FROM Customers
WHERE city IN (SELECT city
	       FROM Products
	       GROUP BY city
	       ORDER BY COUNT(pid) ASC
	       LIMIT 1 -- if we want both Dallas and Duluth, change LIMIT 1 to LIMIT 2
	      ); 

--------------------------------------------------------------

--------------------------------------------------------------

-- Query 2 --

SELECT name
FROM Products
WHERE priceUSD >= (SELECT AVG(priceUSD)
		   FROM Products
		  )
ORDER BY name DESC;

--------------------------------------------------------------

--------------------------------------------------------------

-- Query 3 --

SELECT name, pid, totalUSD
FROM Orders
-- Inner Join --
JOIN Customers ON Orders.cid = Customers.cid
ORDER BY totalUSD ASC;

--------------------------------------------------------------

--------------------------------------------------------------

-- Query 4 --

SELECT name, COALESCE(SUM(quantity), 0) AS "Total Quantity"
FROM Customers
LEFT OUTER JOIN Orders ON Orders.cid = Customers.cid
GROUP BY name
ORDER BY name ASC;
/*To use a right outer join, change FROM clause to Orders
 *and RIGHT OUTER JOIN Customers on Orders.cid = Customers.cid.
 */

--------------------------------------------------------------

--------------------------------------------------------------

-- Query 5 --

SELECT Customers.name AS Customer, Products.name AS Product, Agents.name AS Agent 
FROM Orders
JOIN Customers ON Orders.cid = Customers.cid
JOIN Products ON Orders.pid = Products.pid
JOIN Agents ON Orders.aid = Agents.aid
WHERE Agents.city = 'Newark';

--------------------------------------------------------------

--------------------------------------------------------------

-- Query 6 --

SELECT Orders.ordno AS "Order Number", Orders.totalUSD AS "Original Total", calculatedOrdersTable.calculatedTotalUSD AS "Calculated Orders"
-- Rounding the calculatedTotalUSD because that is how money is rounded to (with 2 decimal places and easier to read and understand).
FROM Orders, (SELECT ordno, ROUND(quantity * priceUSD * (1 - (discountPct / 100)), 2) AS calculatedTotalUSD
	      FROM Orders, Products, Customers
	      WHERE Orders.pid = Products.pid
	      AND Customers.cid = Orders.cid
             ) AS calculatedOrdersTable
WHERE Orders.ordno = calculatedOrdersTable.ordno
AND Orders.totalUSD <> calculatedOrdersTable.calculatedTotalUSD;

--------------------------------------------------------------

--------------------------------------------------------------

-- Question 7 --

/*A right outer join or simply a right join will return all of the values from the right table and 
 *any matching values of the left table even if the values are NULL. A left outer join or simply
 *a left join will return all of the values from the left table and any matching values of the 
 *right table even if the values are NULL. Let's use query 4 as an example!
 */

 -- Right Outer Join --

SELECT name, COALESCE(SUM(quantity), 0) AS "Total Quantity"
FROM Orders
RIGHT OUTER JOIN Customers ON Customers.cid = Orders.cid
GROUP BY name
ORDER BY name ASC;

-- Left Outer Join --

SELECT name, COALESCE(SUM(quantity), 0) AS "Total Quantity"
FROM Customers
LEFT OUTER JOIN Orders ON Orders.cid = Customers.cid
GROUP BY name
ORDER BY name ASC;

/*These queries return the same reult written with either a right or left outer join.
 *What would happen if we switched the first query into a left outer join?
 */

 -- Left Outer Join --

SELECT name, COALESCE(SUM(quantity), 0) AS "Total Quantity"
FROM Orders
LEFT OUTER JOIN Customers ON Customers.cid = Orders.cid
GROUP BY name
ORDER BY name ASC;

/*The query above had one less result when we changed from a right to left outer join, but the rest
 *of the structure remainded the same. This is because the Orders table is the left table in this case.
 *The query is trying to fetch matching results from the Customers table. Since Weyland, the customer, 
 *did not make any orders, there are no records on that customer, so the data is not outputted when
 *the query is executed.
 */

 -- Right Outer Join --

SELECT name, COALESCE(SUM(quantity), 0) AS "Total Quantity"
FROM Customers
RIGHT OUTER JOIN Orders ON Orders.cid = Customers.cid
GROUP BY name
ORDER BY name ASC;

/*The query above yielded the same result as the previous query. There exists a similar problem here.
 *The Customers table is the right table and the query is fetching results from the Orders table and 
 *is trying to match the results. When the query is executed, Weyland is left off because Weyland did 
 *not have any matches or records in Orders, so the data was not outputted.
 *Sometimes, a simple syntax error can yield a different query than expected, so be cautious!
 
--------------------------------------------------------------
