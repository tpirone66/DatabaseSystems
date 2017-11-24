---Trevor Pirone---
---DBMS 308---
---Lab #10---
---11/24/17---
---Prerequesite Function---

---Returns the immediate prerequisites for the passed-in course	number.---
CREATE OR REPLACE FUNCTION Prerequisite(INT, REFCURSOR) RETURNS refcursor AS 
$$
DECLARE
   input_course INT := $1;
   resultset REFCURSOR := $2;
BEGIN
   open resultset FOR 
      SELECT preReqNum
      FROM Prerequisites
      WHERE courseNum = input_course;
   RETURN resultset;
END;
$$ 
LANGUAGE plpgsql;

---Returns the courses for which the passed-in course number is an immediate pre-requisite.---
CREATE OR REPLACE FUNCTION isPrerequisite(INT, REFCURSOR) RETURNS refcursor AS
$$
DECLARE
   input_course INT := $1;
   resultset REFCURSOR := $2;
BEGIN
   open resultset FOR 
      SELECT courseNum
      FROM Prerequisites
      WHERE preReqNum = input_course;
   RETURN resultset;
END;
$$ 
LANGUAGE plpgsql;
