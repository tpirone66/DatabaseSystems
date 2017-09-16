/*
--Trevor Pirone--
--Lab Assignment #3--
--9/14/2017--
--CMPT 308--
*/

--Query 1--
SELECT Orders.ordno, Orders.totalUSD
	FROM Orders;
------------------------------------

--Query 2--
SELECT Agents.name, Agents.city
	FROM Agents
	WHERE name = 'Smith';
------------------------------------

--Query 3--
SELECT Products.pid, Products.name, Products.qty, Products.priceUSD
	FROM Products
	WHERE qty > 200010;
------------------------------------

--Query 4--
SELECT Customers.name, Customers.city
	FROM Customers
	WHERE city = 'Duluth';
------------------------------------

--Query 5--
--There are at least 2 possible WHERE clauses one can use to yield the same answer to this query.
SELECT Agents.name, Agents.city
	FROM Agents
	--WHERE NOT city = 'New York' AND NOT city = 'Duluth';
	WHERE city <> 'New York' AND city <> 'Duluth';
------------------------------------

--Query 6--
SELECT *
	FROM Products
	WHERE city <> 'Dallas' AND city <> 'Duluth' AND priceUSD >= 1;
------------------------------------

--Query 7--
SELECT *
	FROM Orders
	WHERE month = 'Mar' OR month = 'May';
------------------------------------

--Query 8--
SELECT *
	FROM Orders
	WHERE month = 'Feb' AND totalUSD >= 500;
------------------------------------

--Query 9--
SELECT *
	FROM Orders
	WHERE cid = 'c005';
------------------------------------