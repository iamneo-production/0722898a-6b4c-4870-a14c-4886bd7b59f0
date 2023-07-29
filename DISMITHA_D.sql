
---------------BEFORE OPTIMIZATION/INDIVIDUAL CODES-----------------

--- QUESTION 1
select sum(quantity) as PRODUCTS_SOLD_IN_FEB
from ecommerce
where(extract(year from to_date(PURCHASE_DATE,'YYYY-MM-DD')))=2019 AND
(extract(month from to_date(purchase_date,'yyyy-mm-dd')))=2;

---QUESTION 2
select SUBSTR("PURCHASE_DATE",1,4) as "Year",sum(PRICE*QUANTITY) as total_sales_amount_eachyear
from ecommerce
group by SUBSTR("PURCHASE_DATE",1,4);

---QUESTION 3
select SUBSTR("PURCHASE_DATE",6,2) as "Month",PRODUCTNO,sum(Price*quantity) as total_sales_amount_eachproduct
from ECOMMERCE
WHERE SUBSTR("PURCHASE_DATE",1,4)='2019'
group by SUBSTR("PURCHASE_DATE",6,2),PRODUCTNO;

---QUESTION 4
SELECT COUNTRY,COUNT(DISTINCT CUSTOMERNO) as count
FROM ECOMMERCE
GROUP BY COUNTRY;

---QUESTION 5
SELECT DISTINCT PRODUCTNAME AS ALL_UNIQUE_PRODUCTS,
EXTRACT(YEAR FROM TO_DATE("PURCHASE_DATE",'YYYY-MM-DD')) as YEAR_FIELD
FROM ECOMMERCE;

----------------INDIVIDUAL CODES WITH EXPLAIN PLAN-------------

---QUESTION 1
explain plan set statement_id='10' for
SELECT SUM(QUANTITY) AS PRODUCTS_SOLD_IN_FEB
FROM ECOMMERCE
WHERE(EXTRACT(YEAR FROM TO_DATE("PURCHASE_DATE",'YYYY-MM-DD')))=2019 AND
(EXTRACT(MONTH FROM TO_DATE("PURCHASE_DATE",'YYYY-MM-DD')))=2;
select * from table(DBMS_XPLAN.DISPLAY(null,'10','basic'));

---QUESTION 2
explain plan set statement_id='11' for
select SUBSTR("PURCHASE_DATE",1,4) as "Year",sum(PRICE*QUANTITY) as total_sales_amount_eachyear
from ecommerce
group by SUBSTR("PURCHASE_DATE",1,4);
select * from table(DBMS_XPLAN.DISPLAY(null,'11','basic'));

---QUESTION 3
explain plan set statement_id='12' for
select SUBSTR("PURCHASE_DATE",6,2) as "Month",PRODUCTNO,sum(Price*quantity) as total_sales_amount_eachproduct
from ECOMMERCE
WHERE SUBSTR("PURCHASE_DATE",1,4)='2019'
group by SUBSTR("PURCHASE_DATE",6,2),PRODUCTNO;
select * from table(DBMS_XPLAN.DISPLAY(null,'12','basic'));

---QUESTION 4
explain plan set statement_id='13' for
SELECT COUNTRY,COUNT(DISTINCT CUSTOMERNO) as count
FROM ECOMMERCE
GROUP BY COUNTRY;
select * from table(DBMS_XPLAN.DISPLAY(null,'13','basic'));

---QUESTION 5
explain plan set statement_id='14' for
SELECT DISTINCT PRODUCTNAME AS ALL_UNIQUE_PRODUCTS,
EXTRACT(YEAR FROM TO_DATE("PURCHASE_DATE",'YYYY-MM-DD')) as YEAR_FIELD
FROM ECOMMERCE;
select * from table(DBMS_XPLAN.DISPLAY(null,'14','basic'));

-----------------------FINAL OPTIMIZED CODES-----------------

---QUESTION 1
SELECT SUM(QUANTITY) AS PRODUCTS_SOLD
FROM ECOMMERCE
WHERE(EXTRACT(YEAR FROM TO_DATE(PURCHASE_DATE,'YYYY-MM-DD')))=2019 AND
(EXTRACT(MONTH FROM TO_DATE(PURCHASE_DATE,'YYYY-MM-DD')))=2;

---QUESTION 2
select SUBSTR(PURCHASE_DATE,1,4) as "Year",sum(PRICE*QUANTITY) as total_sales_amount
from ecommerce
group by SUBSTR(PURCHASE_DATE,1,4);

---QUESTION 3
select SUBSTR(PURCHASE_DATE,6,2) as "Month",PRODUCTNO,sum(Price*quantity) as total_sales_amount
from ECOMMERCE
WHERE SUBSTR(PURCHASE_DATE,1,4)='2019'
group by SUBSTR(PURCHASE_DATE,6,2),PRODUCTNO;

---QUESTION 4
SELECT COUNTRY,COUNT(DISTINCT CUSTOMERNO) as count
FROM ECOMMERCE
GROUP BY COUNTRY;

---QUESTION 5
SELECT DISTINCT PRODUCTNAME AS UNIQUE_PRODUCTS,
EXTRACT(YEAR FROM TO_DATE(PURCHASE_DATE,'YYYY-MM-DD')) as YEAR_FIELD
FROM ECOMMERCE;

---------------OPTIMIZED CODES WITH EXPLAIN PLAN-----------

---QUESTION 1
explain plan set statement_id='20' for
SELECT SUM(QUANTITY) AS PRODUCTS_SOLD
FROM ECOMMERCE
WHERE(EXTRACT(YEAR FROM TO_DATE(PURCHASE_DATE,'YYYY-MM-DD')))=2019 AND
(EXTRACT(MONTH FROM TO_DATE(PURCHASE_DATE,'YYYY-MM-DD')))=2;
select * from table(DBMS_XPLAN.DISPLAY(null,'20','basic'));

---QUESTION 2
explain plan set statement_id='21' for
select SUBSTR(PURCHASE_DATE,1,4) as "Year",sum(PRICE*QUANTITY) as total_sales_amount
from ecommerce
group by SUBSTR(PURCHASE_DATE,1,4);
select * from table(DBMS_XPLAN.DISPLAY(null,'21','basic'));

---QUESTION 3
explain plan set statement_id='22' for
select SUBSTR(PURCHASE_DATE,6,2) as "Month",PRODUCTNO,sum(Price*quantity) as total_sales_amount
from ECOMMERCE
WHERE SUBSTR(PURCHASE_DATE,1,4)='2019'
group by SUBSTR(PURCHASE_DATE,6,2),PRODUCTNO;
select * from table(DBMS_XPLAN.DISPLAY(null,'22','basic'));

---QUESTION 4
explain plan set statement_id='23' for
SELECT COUNTRY,COUNT(DISTINCT CUSTOMERNO) as count
FROM ECOMMERCE
GROUP BY COUNTRY;
select * from table(DBMS_XPLAN.DISPLAY(null,'23','basic'));

---QUESTION 5
explain plan set statement_id='24' for
SELECT DISTINCT PRODUCTNAME AS UNIQUE_PRODUCTS,
EXTRACT(YEAR FROM TO_DATE(PURCHASE_DATE,'YYYY-MM-DD')) as YEAR_FIELD
FROM ECOMMERCE;
select * from table(DBMS_XPLAN.DISPLAY(null,'24','basic'));