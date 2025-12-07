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


