--- Trevor Pirone ---
--- Databse Management ---
--- 9/23/17 ---
--- Lab Assignment #4 ---

------------ Query #1 ----------------------

SELECT city
FROM Agents
WHERE aid IN (SELECT aid
	      FROM Orders
	      WHERE cid IN(SELECT cid
			   FROM Customers
			   WHERE cid = 'c006'
			  )
	      );
	      
--------------------------------------------

------------ Query #2 ----------------------

SELECT DISTINCT pid
FROM Orders
WHERE aid IN (SELECT aid
	      FROM Orders
	      WHERE cid = 'c006'
	     )
ORDER BY pid DESC;

--------------------------------------------

------------ Query #3 ----------------------

SELECT cid, name 
FROM Customers
WHERE cid NOT IN (SELECT cid 
		  FROM Orders 
		  WHERE aid = 'a03'
		 );
	     
--------------------------------------------

------------ Query #4 ----------------------

SELECT DISTINCT cid
FROM Customers
WHERE cid IN (SELECT cid
	      FROM Orders
	      WHERE pid = 'p01' OR pid = 'p07'
	     )
ORDER BY cid ASC;
	     
--------------------------------------------

------------ Query #5 ----------------------

SELECT DISTINCT pid
FROM Products
WHERE pid NOT IN (SELECT pid
                  FROM Orders
                  WHERE aid IN (SELECT aid
			        FROM Orders
			        WHERE aid = 'a02' or aid = 'a03'
			       )
                 )
ORDER BY pid DESC; 
	  
--------------------------------------------

------------ Query #6 ----------------------

SELECT name, discountPct, city 
FROM Customers
WHERE cid IN (SELECT cid
	      FROM Orders
	      WHERE aid IN (SELECT aid
			    FROM Agents
			    WHERE city = 'Tokyo' OR city = 'New York'
			   )
	     );
	     
--------------------------------------------

------------ Query #7 ----------------------

SELECT *
FROM Customers
WHERE discountPct IN (SELECT discountPct
		      FROM Customers
	              WHERE city = 'Duluth' OR city = 'London'		     
	              )
/*The part below is needed because the query with output the customers from Duluth and London.
This is okay, however, the query is incomplete because if another customer from a different city 
is added to the database and has the same discount price as someone from Duluth or London,
it will not output properly. */	              
AND city != 'Duluth' AND city != 'London';
	     
--------------------------------------------
