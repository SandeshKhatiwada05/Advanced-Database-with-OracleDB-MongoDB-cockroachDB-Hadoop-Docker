CREATE SEQUENCE sq_employees
START WITH 150;

INSERT INTO EMPLOYEES 
    (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
     HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID)
VALUES
    (sq_employees.NEXTVAL,
     'Sandesh',
     'Khadka',
     'SA@GMAIL.COM',
     '977',
     SYSDATE,
     'ST_CLERK',
     2500,
     NULL,
     121,
     50);
SELECT * FROM employees WHERE employee_id=150;




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