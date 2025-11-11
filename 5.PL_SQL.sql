--LAB 5: PL/SQL
--DATE: 11/11/2025

--oBJECTIVES
--1. To be able to understand and implement PL/SQL
--hello world in PL/SQL

SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello world');
END;
/


--2. To calculate area of a circle
SET SERVEROUTPUT ON;

DECLARE
    pi CONSTANT NUMBER := 3.14;
    radius NUMBER := &r;
    area NUMBER;
BEGIN
    area := pi * radius * radius;
    DBMS_OUTPUT.PUT_LINE('The area is: ' || area);
END;
/



-- 3. Use IF-ELSE to check admission eligibility based on age
SET SERVEROUTPUT ON;

DECLARE
    age NUMBER := &age;
BEGIN
    IF age > 22 THEN
        DBMS_OUTPUT.PUT_LINE('Student is eligible for admission.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Student is NOT eligible for admission.');
    END IF;
END;
/


