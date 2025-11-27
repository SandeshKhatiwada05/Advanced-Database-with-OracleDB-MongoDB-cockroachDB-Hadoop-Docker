-- LAB #4: VIEW
-- Student: Sandesh Khatiwada (Sandeshcsit)
-- Date: 17/11/2025

-- OBJECTIVES:
-- 1. Learn to create simple and materialized views
-- 2. Query data from views
-- 3. Use views with joins and aggregations

-- =====================================================
-- OBJECTIVE 1: CREATE SIMPLE VIEWS
-- =====================================================

-- General Syntax:
-- CREATE [MATERIALIZED] VIEW <view_name> AS <SELECT statement>;

-- 1. Simple view of all employees
CREATE VIEW vw_all_employees AS
SELECT employee_id, first_name, last_name, salary, department_id, job_id
FROM employees;

-- =====================================================
-- OBJECTIVE 2: QUERY DATA FROM VIEWS
-- =====================================================

-- 2. Fetch employees with salary > 10000 from the view
SELECT * FROM vw_all_employees
WHERE salary > 10000;

-- =====================================================
-- OBJECTIVE 3: JOIN VIEWS WITH OTHER TABLES
-- =====================================================

-- 3. Join view with jobs table to get job titles
SELECT v.employee_id, v.first_name || ' ' || v.last_name AS full_name, j.job_title, v.salary
FROM vw_all_employees v
INNER JOIN jobs j ON v.job_id = j.job_id;

-- =====================================================
-- OBJECTIVE 4: MATERIALIZED VIEW
-- =====================================================

-- 4. Create a materialized view for high salary employees
CREATE MATERIALIZED VIEW mv_high_salary_employees AS
SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE salary > 15000;

-- 5. Query materialized view
SELECT * FROM mv_high_salary_employees
ORDER BY salary DESC;

-- =====================================================
-- CONCLUSION
-- =====================================================
-- Views simplify repeated queries and joins
-- Materialized views store precomputed data for faster access
-- Always use views for abstraction and clarity in complex queries
