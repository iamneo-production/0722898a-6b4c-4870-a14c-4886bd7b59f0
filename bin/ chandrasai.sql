
set timing on;

--1
SELECT SUM(quantity) AS TotalProducts_Sold
FROM ecommerce
WHERE "PURCHASE_DATE" LIKE '2019-02%';
--2

select  SUBSTR(purchase_date,1,4),sum(price*QUANTITY) as total_sale_amount 
from ecommerce group by substr(purchase_date,1,4);
--3
select substr(purchase_date,6,2) as "month_field",PRODUCTNO
,sum(price*QUANTITY)as amount  from ECOMMERCE where substr(purchase_date,1,4)= '2019'
 group by substr(purchase_date,6,2),productno ;
--4
select  COUNTRY, COUNT(DISTINCT customerno) as coustomer_count  from ECOMMERCE group by COUNTRY;
--5
select DISTINCT PRODUCTNAME AS unique_products,
EXTRACT(year FROM TO_DATE(purchase_date,'YYYY-MM-DD'))as year_field from ECOMMERCE;


-- FINAL OPTIMIZED CODE--

--1
select sum(quantity) as products_sold from ecommerce where (extract (year from to_date(Purchase_Date,'YYYY-MM-DD')))=2019 
and (extract (month from to_date(Purchase_Date,'YYYY-MM-DD')))=2 ;

--2
select SUBSTR(Purchase_Date, 1, 4) as "Year",sum(PRICE*QUANTITY) 
as total_sales_amount from ecommerce group by SUBSTR(Purchase_Date, 1, 4); 

--3
select SUBSTR(Purchase_Date, 6, 2) as "Month",PRODUCTNO,sum(PRICE*QUANTITY) as
 total_sales_amount from ECOMMERCE where SUBSTR(Purchase_Date, 1, 4)='2019' group by SUBSTR(Purchase_Date, 6, 2),PRODUCTNO;

 --4
 select COUNTRY,count( DISTINCT CUSTOMERNO) as count from ECOMMERCE group by COUNTRY; 

 --5
 SELECT DISTINCT PRODUCTNAME AS UNIQUE_PRODUCTS,EXTRACT(year FROM TO_DATE(Purchase_Date,'YYYY-MM-DD')) as YEAR_FIELD 
FROM ecommerce; 

-- WITH EXPLAIN COMMAND--

--1
explain plan set  statement_id='20' for select sum(quantity) as products_sold from ecommerce where (extract (year from to_date(Purchase_Date,'YYYY-MM-DD')))=2019 
and (extract (month from to_date(Purchase_Date,'YYYY-MM-DD')))=2 ;
select * from table(DBMS_XPLAN.DISPLAY(null,'20','BASIC')); --3ms

--2
explain plan set  statement_id='21' for select SUBSTR(Purchase_Date, 1, 4) as "Year",sum(PRICE*QUANTITY) 
as total_sales_amount from ecommerce group by SUBSTR(Purchase_Date, 1, 4); 
select * from table(DBMS_XPLAN.DISPLAY(null,'21','BASIC'));--16ms

--3
explain plan set  statement_id='22' for select SUBSTR(Purchase_Date, 6, 2) as "Month",PRODUCTNO,sum(PRICE*QUANTITY) as
 total_sales_amount from ECOMMERCE where SUBSTR(Purchase_Date, 1, 4)='2019' group by SUBSTR(Purchase_Date, 6, 2),PRODUCTNO;
 select * from table(DBMS_XPLAN.DISPLAY(null,'22','BASIC')); --31ms

--4
explain plan set  statement_id='23' for select COUNTRY,count( DISTINCT CUSTOMERNO) as count from ECOMMERCE group by COUNTRY; 
select * from table(DBMS_XPLAN.DISPLAY(null,'23','BASIC'));--13ms

--5
explain plan set  statement_id='24' for SELECT DISTINCT PRODUCTNAME AS UNIQUE_PRODUCTS,EXTRACT(year FROM TO_DATE(Purchase_Date,'YYYY-MM-DD')) as YEAR_FIELD 
FROM ecommerce; 
select * from table(DBMS_XPLAN.DISPLAY(null,'24','BASIC'));--10ms
