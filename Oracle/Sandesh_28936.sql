------------------------
--1 Range partitioning
------------------------
-- Create table with RANGE partitioning on sales_date
CREATE TABLE sales1
(
  customer_id  NUMBER,
  sales_date   DATE,
  order_amount NUMBER,
  region       NVARCHAR2(10)
)
PARTITION BY RANGE (sales_date)
(
  PARTITION p1 VALUES LESS THAN (TO_DATE('01-03-2015', 'DD-MM-YYYY')),
  PARTITION p2 VALUES LESS THAN (TO_DATE('01-05-2015', 'DD-MM-YYYY')),
  PARTITION p3 VALUES LESS THAN (TO_DATE('01-07-2015', 'DD-MM-YYYY')),
  PARTITION p4 VALUES LESS THAN (MAXVALUE)
);


-- Insert rows (
-- p1 (date < 01-03-2015) -> 1 row
INSERT INTO sales1 (customer_id, sales_date, order_amount, region)
VALUES (1, TO_DATE('01-01-2015', 'DD-MM-YYYY'), 600, N'SOUTH');

-- p2 (>=01-03-2015 and <01-05-2015) -> 2 rows
INSERT INTO sales1 (customer_id, sales_date, order_amount, region)
VALUES (2, TO_DATE('15-03-2015', 'DD-MM-YYYY'), 1200, N'NORTH');

INSERT INTO sales1 (customer_id, sales_date, order_amount, region)
VALUES (3, TO_DATE('30-04-2015', 'DD-MM-YYYY'),  750, N'EAST');

-- p3 (>=01-05-2015 and <01-07-2015) -> 3 rows
INSERT INTO sales1 (customer_id, sales_date, order_amount, region)
VALUES (4, TO_DATE('05-05-2015', 'DD-MM-YYYY'),  300, N'WEST');

INSERT INTO sales1 (customer_id, sales_date, order_amount, region)
VALUES (5, TO_DATE('20-05-2015', 'DD-MM-YYYY'),  450, N'SOUTH');

INSERT INTO sales1 (customer_id, sales_date, order_amount, region)
VALUES (6, TO_DATE('15-06-2015', 'DD-MM-YYYY'),  900, N'NORTH');

COMMIT;

-- Verify: view all rows
SELECT * FROM sales1 ORDER BY sales_date;

--view partitioned value
SELECT * FROM sales1 PARTITION (p3);




-------------------------------------
---2. List Partition
-------------------------------------
-- Create table partitioned by LIST on region (
CREATE TABLE sales2
(
  customer_id  NUMBER,
  sales_date   DATE,
  order_amount NUMBER,
  region       NVARCHAR2(10)
)
PARTITION BY LIST (region)
(
  PARTITION p1 VALUES ('East'),
  PARTITION p2 VALUES ('West'),
  PARTITION p3 VALUES ('North'),
  PARTITION p4 VALUES ('South')
);


--insert into list partitioning
INSERT INTO sales2 (customer_id, sales_date, order_amount, region)
VALUES (110, TO_DATE('01-FEB-2015','DD-MON-YYYY'), 200, N'East');

INSERT INTO sales2 (customer_id, sales_date, order_amount, region)
VALUES (111, TO_DATE('12-FEB-2015','DD-MON-YYYY'), 350, N'East');
INSERT INTO sales2 (customer_id, sales_date, order_amount, region)
VALUES (112, TO_DATE('25-FEB-2015','DD-MON-YYYY'), 150, N'East');

INSERT INTO sales2 (customer_id, sales_date, order_amount, region)
VALUES (120, TO_DATE('05-MAR-2015','DD-MON-YYYY'), 400, N'West');
INSERT INTO sales2 (customer_id, sales_date, order_amount, region)
VALUES (121, TO_DATE('20-MAR-2015','DD-MON-YYYY'), 250, N'West');

INSERT INTO sales2 (customer_id, sales_date, order_amount, region)
VALUES (130, TO_DATE('03-APR-2015','DD-MON-YYYY'), 500, N'North');
INSERT INTO sales2 (customer_id, sales_date, order_amount, region)
VALUES (131, TO_DATE('15-APR-2015','DD-MON-YYYY'), 275, N'North');
INSERT INTO sales2 (customer_id, sales_date, order_amount, region)
VALUES (132, TO_DATE('29-APR-2015','DD-MON-YYYY'), 325, N'North');

INSERT INTO sales2 (customer_id, sales_date, order_amount, region)
VALUES (140, TO_DATE('07-MAY-2015','DD-MON-YYYY'), 180, N'South');
INSERT INTO sales2 (customer_id, sales_date, order_amount, region)
VALUES (141, TO_DATE('21-MAY-2015','DD-MON-YYYY'), 420, N'South');
COMMIT;

-- Verify: view all rows ordered by region/date
SELECT * FROM sales2 ORDER BY region, sales_date;

--view partitioned value
SELECT * FROM sales2 PARTITION (p1);

























