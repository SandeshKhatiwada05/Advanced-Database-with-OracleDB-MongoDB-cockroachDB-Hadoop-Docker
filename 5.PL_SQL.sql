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



-- 4. using HR

select first_name, email, salary from employees where employee_id = 150;

SET SERVEROUTPUT ON;

DECLARE
    v_sal EMPLOYEES.salary%TYPE;
BEGIN
    SELECT salary
    INTO v_sal
    FROM EMPLOYEES
    WHERE employee_id = 150;

    -- IF ELSE block
    IF v_sal < 1000 THEN
        UPDATE employees
        SET commission_pct = 1.1 * commission_pct
        WHERE employee_id = 150;

    ELSIF v_sal >= 1000 AND v_sal < 5000 THEN
        UPDATE employees
        SET commission_pct = 1.2 * commission_pct
        WHERE employee_id = 150;

    ELSE
        UPDATE employees
        SET commission_pct = 1.3 * commission_pct
        WHERE employee_id = 150;
    END IF;

    COMMIT;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No employee found with ID 150');
END;
/

select first_name, email, salary from employees where employee_id = 150;


--wap to find even multiples of 5 less than 100
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





