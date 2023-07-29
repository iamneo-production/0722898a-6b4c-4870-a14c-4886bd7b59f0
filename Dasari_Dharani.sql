select * from ecommerce;
-- desc ecommerce;
set timing on;

--Question-1

select sum(QUANTITY) as quantity FROM ECOMMERCE where extract(year from TO_DATE(PURCHASE_DATE,'YYYY-MM-DD'))=2019 
and extract(month from TO_DATE(PURCHASE_DATE,'YYYY-MM-DD'))=02; 

--Question-2

select sum(PRICE * QUANTITY) as total_sale_amount,
extract(year from TO_DATE(PURCHASE_DATE,'YYYY-MM-DD')) AS "Year_Field"
from ECOMMERCE group by extract(year from TO_DATE(PURCHASE_DATE,'YYYY-MM-DD'));

--Question-3

select PRODUCTNO,extract(month from TO_DATE(PURCHASE_DATE,'YYYY-MM-DD')) as "Month_Field",sum(PRICE * QUANTITY) 
as sale_amount from ecommerce 
where extract(year from TO_DATE(PURCHASE_DATE,'YYYY-MM-DD'))='2019' group by productno, extract(month from TO_DATE(PURCHASE_DATE,'YYYY-MM-DD'));

--Question-4

select COUNTRY,count( DISTINCT CUSTOMERNO) as count from ECOMMERCE group by COUNTRY; 

--Question-5

select  Distinct PRODUCTNAME, extract(year from TO_DATE(Purchase_Date,'YYYY-MM-DD')) as year from ECOMMERCE ;

--Final Optimized Code--

-- Question 1

SELECT SUM(quantity) AS TotalProducts_Sold
FROM ecommerce
WHERE EXTRACT(YEAR FROM TO_DATE("PURCHASE_DATE",'YYYY-MM-DD'))=2019 AND 
EXTRACT(MONTH FROM TO_DATE("PURCHASE_DATE",'YYYY-MM-DD'))=02;

--or--

SELECT SUM(quantity) AS TotalProducts_Sold
FROM ecommerce
WHERE "PURCHASE_DATE" LIKE '2019-02%';
--second time it takes only 03 ms.

-- Question 2

SELECT SUBSTR("PURCHASE_DATE",1,4) AS "Year", 
SUM(price * Quantity) AS TotalSalesAmount
FROM ECOMMERCE
GROUP BY SUBSTR("PURCHASE_DATE",1,4);

-- Question 3

SELECT 
SUBSTR("PURCHASE_DATE",6,2) AS "Month",
productno,
SUM(price * Quantity) AS TotalSalesAmount
FROM ECOMMERCE
WHERE "PURCHASE_DATE" LIKE '2019%'
GROUP BY productno, 
SUBSTR("PURCHASE_DATE",6,2);

--or--

SELECT 
SUBSTR("PURCHASE_DATE",6,2) AS "Month",
productno,
SUM(price * Quantity) AS TotalSalesAmount
FROM ECOMMERCE
WHERE SUBSTR("PURCHASE_DATE",1,4)='2019'
GROUP BY productno, 
SUBSTR("PURCHASE_DATE",6,2);

-- Question 4

SELECT Country, COUNT(DISTINCT customerno) AS customer_count
FROM ecommerce
GROUP BY COUNTRY;

-- Question 5

SELECT DISTINCT productname AS UNIQUE_PRODUCTS, 
EXTRACT(YEAR FROM TO_DATE("PURCHASE_DATE",'YYYY-MM-DD')) AS Year
FROM ecommerce;

-- Creating Index

-- CREATE INDEX month_in_date_idx ON ecommerce(EXTRACT(MONTH FROM TO_DATE("Date",'YYYY-MM-DD')));
-- CREATE INDEX year_in_date_idx ON ecommerce(EXTRACT(YEAR FROM TO_DATE("Date",'YYYY-MM-DD')));

--Explain plan

-- Question 1 

EXPLAIN PLAN SET STATEMENT_ID='1' FOR SELECT SUM(quantity) AS TotalProducts_Sold
FROM ecommerce
WHERE EXTRACT(YEAR FROM TO_DATE("PURCHASE_DATE",'YYYY-MM-DD'))=2019 AND 
EXTRACT(MONTH FROM TO_DATE("PURCHASE_DATE",'YYYY-MM-DD'))=02;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY(null,'1','BASIC'));

--or--

EXPLAIN PLAN SET STATEMENT_ID='1_1' FOR SELECT SUM(quantity) AS TotalProducts_Sold
FROM ecommerce
WHERE "PURCHASE_DATE" LIKE '2019-02%';
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY(null,'1_1','BASIC'));

-- Question 2

EXPLAIN PLAN SET STATEMENT_ID='2' FOR SELECT SUBSTR("PURCHASE_DATE",1,4) AS "Year", 
SUM(price * Quantity) AS TotalSalesAmount
FROM ECOMMERCE
GROUP BY SUBSTR("PURCHASE_DATE",1,4);
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY(null,'2','BASIC'));

-- Question 3

EXPLAIN PLAN SET STATEMENT_ID='3' FOR SELECT 
SUBSTR("PURCHASE_DATE",6,2) AS "Month",
productno,
SUM(price * Quantity) AS TotalSalesAmount
FROM ECOMMERCE
WHERE "PURCHASE_DATE" LIKE '2019%'
GROUP BY productno, 
SUBSTR("PURCHASE_DATE",6,2);
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY(null,'3','BASIC'));

--or--

EXPLAIN PLAN SET STATEMENT_ID='3_1' FOR SELECT 
SUBSTR("PURCHASE_DATE",6,2) AS "Month",
productno,
SUM(price * Quantity) AS TotalSalesAmount
FROM ECOMMERCE
WHERE SUBSTR("PURCHASE_DATE",1,4)='2019'
GROUP BY productno, 
SUBSTR("PURCHASE_DATE",6,2);
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY(null,'3_1','BASIC'));

-- Question 4

EXPLAIN PLAN SET STATEMENT_ID='4' FOR SELECT Country, COUNT(DISTINCT customerno) AS customer_count
FROM ecommerce
GROUP BY COUNTRY;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY(null,'4','BASIC'));

--Question 5

EXPLAIN PLAN SET STATEMENT_ID='5' FOR SELECT DISTINCT productname AS UNIQUE_PRODUCTS, 
EXTRACT(YEAR FROM TO_DATE("PURCHASE_DATE",'YYYY-MM-DD')) AS Year
FROM ecommerce;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY(null,'5','BASIC'));
