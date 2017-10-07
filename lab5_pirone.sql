/*
-- Trevor Pirone --
-- 10/06/2017 --
-- CMPT 308L --
-- Lab Assignment #5 --
*/

--------------------------------------------------------------

-- Query 1 --

SELECT DISTINCT city
FROM Agents
JOIN Orders
ON Orders.aid = Agents.aid
WHERE Orders.cid = 'c006';

--------------------------------------------------------------

--------------------------------------------------------------

-- Query 2 --

SELECT DISTINCT o1.pid from Orders o
INNER JOIN Customers c
ON c.cid = o.cid AND c.city = 'Beijing'
FULL JOIN Orders o1
ON o1.aid = o.aid
WHERE o.ordno IS NOT NULL
ORDER BY o1.pid DESC;

--------------------------------------------------------------

--------------------------------------------------------------

-- Query 3 --

SELECT name
FROM Customers
WHERE cid NOT IN (SELECT DISTINCT cid
		  FROM Orders
		 );

--------------------------------------------------------------

--------------------------------------------------------------

-- Query 4 --

SELECT name
FROM Customers
FULL OUTER JOIN Orders
ON Customers.cid = Orders.cid
WHERE Orders.cid IS NULL;

--------------------------------------------------------------

--------------------------------------------------------------

-- Query 5 --

SELECT DISTINCT Customers.name, Agents.name
FROM Customers, Agents, Orders
WHERE Customers.city = Agents.city
AND Customers.cid = Orders.cid
AND Orders.aid = Agents.aid;

--------------------------------------------------------------

--------------------------------------------------------------

-- Query 6 --

	
SELECT Customers.name , Agents.name , Customers.city
FROM Customers, Agents
WHERE Customers.city = Agents.city; 
--------------------------------------------------------------

--------------------------------------------------------------

-- Query 7 --

	
SELECT name, city
FROM Customers
WHERE city IN (SELECT city
	       FROM Products
	       GROUP BY city
	       ORDER BY COUNT(pid) ASC
	       LIMIT 1
	      ); 
--------------------------------------------------------------

