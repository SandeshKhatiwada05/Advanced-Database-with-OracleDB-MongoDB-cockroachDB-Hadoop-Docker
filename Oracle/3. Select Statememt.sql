-- =====================================================
-- LAB #3: SELECT STATEMENT (QUERY)
-- Student: Sandesh Khatiwada (Sandeshcsit)
-- Date: 09/11/2025
-- =====================================================

-- OBJECTIVES:
-- 1. Fetch data from a single table
-- 2. Fetch data conditionally [WHERE]
-- 3. Use IN, BETWEEN, AND, OR, NOT operations
-- 4. Apply aggregation (SUM, MIN, MAX, AVG, COUNT, STDDEV)
-- 5. Apply JOINs (CROSS, INNER, OUTER)
-- 6. Arrange data (ORDER BY) and fetch limited records

-- =====================================================
-- OBJECTIVE 1: FETCH DATA FROM A SINGLE TABLE
-- =====================================================

-- General Syntax:
-- SELECT * FROM <table_name>;

-- 1. Select all employees
SELECT * FROM employees;

-- 2. Select all departments
SELECT * FROM departments;

-- 3. Find employee first name, last name, and email from employees
SELECT first_name, last_name, email FROM employees;

-- 4. Find department name and location ID from departments
SELECT department_name, location_id FROM departments;

-- =====================================================
-- OBJECTIVE 2: FETCH DATA CONDITIONALLY [WHERE]
-- =====================================================

-- General Syntax:
-- SELECT * FROM <table_name> WHERE <condition>;

-- 5. Find all employees who work in department 60 (IT)
SELECT * FROM employees 
WHERE department_id = 60;

-- 6. Find list of all employees hired before 1st January 2006
SELECT * FROM employees 
WHERE hire_date < TO_DATE('01/01/2006', 'DD/MM/YYYY');

-- 7. Find employees with salary greater than 10000
SELECT * FROM employees 
WHERE salary > 10000;

-- =====================================================
-- OBJECTIVE 3: IN, BETWEEN, AND, OR, NOT OPERATIONS
-- =====================================================

-- 8. AND Operator - Find employees in IT dept (60) with salary > 5000
SELECT * FROM employees 
WHERE department_id = 60 AND salary > 5000;

-- 9. OR Operator - Find employees in department 50 OR 60
SELECT * FROM employees 
WHERE department_id = 50 OR department_id = 60;

-- 10. NOT Operator - Find employees NOT in department 90
SELECT * FROM employees 
WHERE NOT department_id = 90;

-- General Syntax for BETWEEN:
-- SELECT * FROM <table_name> WHERE <col_name> BETWEEN value1 AND value2;

-- 11. BETWEEN - Find employees with salary between 5000 and 10000
SELECT * FROM employees 
WHERE salary BETWEEN 5000 AND 10000;

-- 12. BETWEEN with dates - Find employees hired between 2005 and 2007
SELECT * FROM employees 
WHERE hire_date BETWEEN TO_DATE('01/01/2005', 'DD/MM/YYYY') 
                    AND TO_DATE('31/12/2007', 'DD/MM/YYYY');

-- 13. NOT BETWEEN - Find employees with salary NOT between 3000 and 7000
SELECT * FROM employees 
WHERE salary NOT BETWEEN 3000 AND 7000;

-- General Syntax for IN:
-- SELECT * FROM <table_name> WHERE <col_name> IN (list_of_values);

-- 14. IN Operator - Find employees in departments 30, 50, or 60
SELECT * FROM employees 
WHERE department_id IN (30, 50, 60);

-- 15. IN Operator with job titles
SELECT * FROM employees 
WHERE job_id IN ('IT_PROG', 'FI_ACCOUNT', 'SA_MAN');

-- 16. NOT IN - Find employees NOT in departments 50 or 90
SELECT * FROM employees 
WHERE department_id NOT IN (50, 90);

-- =====================================================
-- OBJECTIVE 4: AGGREGATION FUNCTIONS
-- =====================================================

-- General Syntax:
-- SELECT SUM(<col>) FROM <table_name>;
-- SELECT MIN(<col>) FROM <table_name>;
-- SELECT MAX(<col>) FROM <table_name>;
-- SELECT AVG(<col>) FROM <table_name>;
-- SELECT COUNT(*) FROM <table_name>;
-- SELECT STDDEV(<col>) FROM <table_name>;

-- 17. Find total number of employees
SELECT COUNT(*) AS "Total Employees" 
FROM employees;

-- 18. Find total salary (SUM)
SELECT SUM(salary) AS "Total Salary" 
FROM employees;

-- 19. Find minimum salary
SELECT MIN(salary) AS "Minimum Salary" 
FROM employees;

-- 20. Find maximum salary
SELECT MAX(salary) AS "Maximum Salary" 
FROM employees;

-- 21. Find average salary
SELECT AVG(salary) AS "Average Salary" 
FROM employees;

-- 22. Find standard deviation of salaries
SELECT STDDEV(salary) AS "Salary Std Deviation" 
FROM employees;

-- 23. Find total salary by department (GROUP BY)
SELECT 
    department_id,
    COUNT(*) AS "Employee Count",
    SUM(salary) AS "Total Salary",
    AVG(salary) AS "Average Salary"
FROM employees
GROUP BY department_id
ORDER BY department_id;

-- =====================================================
-- OBJECTIVE 5: JOINS (CROSS, INNER, OUTER)
-- =====================================================

-- CROSS JOIN - General Syntax:
-- SELECT * FROM table1, table2;

-- 24. Cross Join - Cartesian product
SELECT * FROM employees, departments;

-- CROSS JOIN with WHERE (Old Style Join):
-- SELECT * FROM table1, table2 WHERE <condition>;

-- 25. Cross Join with WHERE clause
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;

-- INNER JOIN - General Syntax:
-- SELECT * FROM table1 t1
-- INNER JOIN table2 t2
-- ON t1.column = t2.column;

-- 26. Inner Join - Employees with department names
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.salary,
    d.department_name
FROM employees e
INNER JOIN departments d 
ON e.department_id = d.department_id;

-- 27. Inner Join - Employees with job titles
SELECT 
    e.employee_id,
    e.first_name || ' ' || e.last_name AS "Full Name",
    j.job_title,
    e.salary
FROM employees e
INNER JOIN jobs j 
ON e.job_id = j.job_id;

-- 28. Multiple INNER JOINs - Employees with department and location
SELECT 
    e.employee_id,
    e.first_name || ' ' || e.last_name AS "Employee Name",
    d.department_name,
    l.city,
    c.country_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id
INNER JOIN countries c ON l.country_id = c.country_id;

-- LEFT OUTER JOIN - General Syntax:
-- SELECT * FROM table1 t1
-- LEFT OUTER JOIN table2 t2
-- ON t1.column = t2.column;

-- 29. Left Outer Join - All departments with employee count
SELECT 
    d.department_id,
    d.department_name,
    COUNT(e.employee_id) AS "Employee Count"
FROM departments d
LEFT OUTER JOIN employees e 
ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
ORDER BY d.department_id;

-- =====================================================
-- COMBINATION OF JOIN AND AGGREGATION
-- =====================================================

-- General Syntax:
-- SELECT t1.col, SUM(t2.col) FROM table1 t1
-- INNER JOIN table2 t2 ON t1.id = t2.id
-- GROUP BY t1.col;

-- 30. Total salary by department with department names
SELECT 
    d.department_id,
    d.department_name,
    COUNT(e.employee_id) AS "Employee Count",
    SUM(e.salary) AS "Total Salary"
FROM departments d
INNER JOIN employees e 
ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;

-- 31. Average salary by job title
SELECT 
    j.job_title,
    COUNT(e.employee_id) AS "Number of Employees",
    AVG(e.salary) AS "Average Salary"
FROM jobs j
INNER JOIN employees e 
ON j.job_id = e.job_id
GROUP BY j.job_title;x

-- =====================================================
-- OBJECTIVE 6: ORDER BY AND LIMIT (ROWNUM)
-- =====================================================

-- General Syntax for ORDER BY:
-- SELECT * FROM <table_name> ORDER BY <col> ASC;
-- SELECT * FROM <table_name> ORDER BY <col> DESC;

-- 32. Employees ordered by salary (ascending)
SELECT employee_id, first_name, last_name, salary
FROM employees
ORDER BY salary ASC;

-- 33. Employees ordered by salary (descending)
SELECT employee_id, first_name, last_name, salary
FROM employees
ORDER BY salary DESC;

-- 34. Employees ordered by hire date (newest first)
SELECT employee_id, first_name, last_name, hire_date
FROM employees
ORDER BY hire_date DESC;

-- General Syntax for ROWNUM (LIMIT):
-- WHERE ROWNUM <= n;

-- 35. Top 5 highest paid employees using ROWNUM
SELECT * FROM (
    SELECT employee_id, first_name, last_name, salary
    FROM employees
    ORDER BY salary DESC
)
WHERE ROWNUM <= 5;

-- 36. Top 3 most recent hires
SELECT * FROM (
    SELECT employee_id, first_name, last_name, hire_date
    FROM employees
    ORDER BY hire_date DESC
)
WHERE ROWNUM <= 3;

-- 37. Combine JOIN, Aggregation, ORDER BY, and ROWNUM
-- Top 5 departments by total salary
SELECT * FROM (
    SELECT 
        d.department_name,
        SUM(e.salary) AS "Total Salary"
    FROM departments d
    INNER JOIN employees e 
    ON d.department_id = e.department_id
    GROUP BY d.department_name
    ORDER BY SUM(e.salary) DESC
)
WHERE ROWNUM <= 5;

-- =====================================================
-- ADDITIONAL IMPORTANT QUERIES
-- =====================================================

-- 38. Self Join - Employees with their managers
SELECT 
    e.employee_id,
    e.first_name || ' ' || e.last_name AS "Employee",
    m.first_name || ' ' || m.last_name AS "Manager"
FROM employees e
LEFT OUTER JOIN employees m 
ON e.manager_id = m.employee_id;

-- 39. Subquery - Employees earning more than average salary
SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY salary DESC;

-- 40. HAVING Clause - Departments with more than 5 employees
SELECT 
    d.department_name,
    COUNT(e.employee_id) AS "Employee Count"
FROM departments d
INNER JOIN employees e 
ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING COUNT(e.employee_id) > 5
ORDER BY COUNT(e.employee_id) DESC;

-- =====================================================
-- END OF LAB #3
-- =====================================================
PROMPT '========================================='
PROMPT 'Lab #3 Complete!'
PROMPT 'Student: Sandesh Khatiwada (Sandeshcsit)'
PROMPT 'Date: 09/11/2025'
PROMPT 'Total Queries: 40'
PROMPT '========================================='