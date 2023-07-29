set timing on;
/*The above command is used to measure run time*/

select *from ecommerce; /*For datainfo*/


--QUERY1--
/*SQL Query to how many products were sold in February 2019*/
select sum(quantity) as total from ecommerce where PURCHASE_DATE like '2019-02%'; /* Time Elapsed:  00:00:00:05*/

--explain command--
explain plan set statement_id='10' for select sum(quantity) as total from ecommerce where PURCHASE_DATE like '2019-02%'; ---Explained
select *from table(DBMS_XPLAN.DISPLAY(null,'10','BASIC'));  /* Time Elapsed:  00:00:00:05*/


--Query-2--
/*SQL Query to Total sales amount in each year*/
select sum(PRICE*QUANTITY) as total_sale_amount, PURCHASE_DATE as "YEAR" from ecommerce
group by PURCHASE_DATE;  /* Time Elapsed:  00:00:00:17*/

--explain command--
explain plan set statement_id='11' for select sum(PRICE*QUANTITY) as total_sale_amount, PURCHASE_DATE as "YEAR"
from ecommerce group by PURCHASE_DATE; --Explained--
select *from table(DBMS_XPLAN.DISPLAY(null,'11','BASIC'));  /* Time Elapsed:  00:00:00:05*/


--QUERY3--
/*SQL Query to what was the total sales amount of each product on a month-wise basis in the year 2019*/
select productno, PURCHASE_DATE as "MONTH", sum(quantity*price) as sale from ecommerce
where PURCHASE_DATE LIKE '2019%' group by productno,PURCHASE_DATE; /* Time Elapsed:  00:00:00:36*/

--explain command--
explain plan set statement_id='12' for select productno, PURCHASE_DATE as "MONTH", sum(quantity*price) as sale from ecommerce
where PURCHASE_DATE LIKE '2019%' group by productno,PURCHASE_DATE;  --Explained--
select *from table(DBMS_XPLAN.DISPLAY(null,'12','BASIC'));   /* Time Elapsed:  00:00:00:04*/


--QUERY4--
/*SQL Query to Count the customers from each country*/
select count(unique(customerno)) as count,country from ECOMMERCE group by country;  /* Time Elapsed:  00:00:00:13*/

--explain command--
explain plan set statement_id='13' for select count(Unique(customerno)) as count,country from ECOMMERCE group by country;   --Explained--
select *from table(DBMS_XPLAN.DISPLAY(null,'13','BASIC'));   /* Time Elapsed:  00:00:00:04*/


--QUERY5--
/*SQL Query to list unique product names sold from each year*/

--CREATE BIPMAP INDEX--
create bitmap index prname_date_idx on ecommerce(productname,extract(year from TO_DATE ("PURCHASE_DATE",'YYYY-MM-DD')),
extract(month from TO_DATE ("PURCHASE_DATE",'YYYY-MM-DD')));

SELECT UNIQUE PRODUCTNAME AS PRODUCTS,EXTRACT(year FROM TO_DATE("PURCHASE_DATE",'YYYY-MM-DD')) as YEAR
FROM ecommerce;  /* Time Elapsed:  00:00:00:10*/

--explain command--
explain plan set statement_id='14' for SELECT UNIQUE PRODUCTNAME AS PRODUCTS,
EXTRACT(year FROM TO_DATE("PURCHASE_DATE",'YYYY-MM-DD')) as YEAR
FROM ecommerce;    --Explained--
select *from table(DBMS_XPLAN.DISPLAY(null,'14','BASIC'));   /* Time Elapsed:  00:00:00:04*/


--- FINAL OPTIMIZED CODE---
---WITHOUT EXPLAIN COMMAND---

--QUERY1--
select sum(quantity) as products_sold from ecommerce where (extract (year from to_date(Purchase_Date,'YYYY-MM-DD')))=2019 
and (extract (month from to_date(Purchase_Date,'YYYY-MM-DD')))=2 ;

--QUERY2--
select SUBSTR(Purchase_Date, 1, 4) as "Year",sum(PRICE*QUANTITY) 
as total_sales_amount from ecommerce group by SUBSTR(Purchase_Date, 1, 4); 

--QUERY3--
select SUBSTR(Purchase_Date, 6, 2) as "Month",PRODUCTNO,sum(PRICE*QUANTITY) as
 total_sales_amount from ECOMMERCE where SUBSTR(Purchase_Date, 1, 4)='2019' group by SUBSTR(Purchase_Date, 6, 2),PRODUCTNO;

 --QUERY4--
 select COUNTRY,count( DISTINCT CUSTOMERNO) as count from ECOMMERCE group by COUNTRY; 

 --QUERY5--
 SELECT DISTINCT PRODUCTNAME AS UNIQUE_PRODUCTS,EXTRACT(year FROM TO_DATE(Purchase_Date,'YYYY-MM-DD')) as YEAR_FIELD 
FROM ecommerce; 

----WITH EXPLAIN COMMAND----

--QUERY1--
explain plan set  statement_id='20' for select sum(quantity) as products_sold from ecommerce where (extract (year from to_date(Purchase_Date,'YYYY-MM-DD')))=2019 
and (extract (month from to_date(Purchase_Date,'YYYY-MM-DD')))=2 ;
select * from table(DBMS_XPLAN.DISPLAY(null,'20','BASIC')); 

--QUERY2--
explain plan set  statement_id='21' for select SUBSTR(Purchase_Date, 1, 4) as "Year",sum(PRICE*QUANTITY) 
as total_sales_amount from ecommerce group by SUBSTR(Purchase_Date, 1, 4); 
select * from table(DBMS_XPLAN.DISPLAY(null,'21','BASIC'));

--QUERY3--
explain plan set  statement_id='22' for select SUBSTR(Purchase_Date, 6, 2) as "Month",PRODUCTNO,sum(PRICE*QUANTITY) as
 total_sales_amount from ECOMMERCE where SUBSTR(Purchase_Date, 1, 4)='2019' group by SUBSTR(Purchase_Date, 6, 2),PRODUCTNO;
 select * from table(DBMS_XPLAN.DISPLAY(null,'22','BASIC')); 

--QUERY4--
explain plan set  statement_id='23' for select COUNTRY,count( DISTINCT CUSTOMERNO) as count from ECOMMERCE group by COUNTRY; 
select * from table(DBMS_XPLAN.DISPLAY(null,'23','BASIC'));

--QUERY5--
explain plan set  statement_id='24' for SELECT DISTINCT PRODUCTNAME AS UNIQUE_PRODUCTS,EXTRACT(year FROM TO_DATE(Purchase_Date,'YYYY-MM-DD')) as YEAR_FIELD 
FROM ecommerce; 
select * from table(DBMS_XPLAN.DISPLAY(null,'24','BASIC'));