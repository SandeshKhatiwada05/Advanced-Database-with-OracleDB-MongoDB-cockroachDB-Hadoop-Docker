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


--2.1 To calculate area of a circle
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



-- 2.2. Use IF-ELSE to check admission eligibility based on age
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

--3 Create a functino
CREATE OR REPLACE FUNCTION get_total_salary_by_dept
(
    p_dept_id IN NUMBER
)
RETURN NUMBER
AS
    v_total_salary NUMBER;
BEGIN
    SELECT SUM(salary +  NVL(commission_pct,0)*salary)
    --SELECT SUM(salary)
    INTO v_total_salary
    FROM employees
    WHERE department_id = p_dept_id;
    RETURN NVL(v_total_salary, 0);
END;
/
SET SERVEROUTPUT ON;
DECLARE
    v_total NUMBER;
BEGIN
    v_total := get_total_salary_by_dept(80);
    DBMS_OUTPUT.PUT_LINE('Total Salary for Dept 80: ' || v_total);
END;
/


--4 Function
CREATE OR REPLACE FUNCTION get_total_employees_before_date
(
    p_hire_date IN DATE
)
RETURN NUMBER
AS
    v_total NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_total
    FROM employees
    WHERE hire_date < p_hire_date;

    RETURN NVL(v_total, 0);
END;
/
SET SERVEROUTPUT ON;

DECLARE
    v_total NUMBER;
BEGIN
    v_total := get_total_employees_before_date(TO_DATE('2021-01-01', 'YYYY-MM-DD'));
    DBMS_OUTPUT.PUT_LINE('Total Employees hired before 2021-01-01: ' || v_total);
END;
/


--5 STORED pROCEDURE
CREATE OR REPLACE PROCEDURE get_max_salary(
    v_max_salary OUT employees.salary%TYPE,
    dept_id IN employees.department_id%TYPE)
    AS
BEGIN
    
    SELECT MAX(salary)
    INTO v_max_salary
    FROM employees
    WHERE department_id=dept_id;
    
    
    DBMS_OUTPUT.PUT_LINE('Maximum Salary: ' || v_max_salary);
END get_max_salary ;
/

SET SERVEROUTPUT ON;

DECLARE
    v_max employees.salary%TYPE;  
BEGIN
    get_max_salary(v_max, 80);    
    
    DBMS_OUTPUT.PUT_LINE('Returned Max Salary: ' || v_max);
END;
/


--6 wap to find even multiples of 5 less than 100
SET SERVEROUTPUT ON;

DECLARE
    i NUMBER := 1;
    prod NUMBER;
BEGIN
    LOOP
        prod := i * 5;

        -- exit when product exceeds 100
        EXIT WHEN prod >= 100;

        -- print only even multiples
        IF MOD(prod, 2) = 0 THEN
            DBMS_OUTPUT.PUT_LINE(prod);
        END IF;

        i := i + 1;
    END LOOP;
END;
/





