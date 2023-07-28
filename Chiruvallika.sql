set timing on;

select * from ECOMMERCE;

--QUESTION 1

--total products sold in feb 2019

explain plan set  statement_id='4' for select sum(QUANTITY) as "total" from ECOMMERCE 
where "PURCHASE_DATE" > '2019-01-31' and "PURCHASE_DATE" < '2019-03-01';
select * from table(DBMS_XPLAN.DISPLAY(null,'4','BASIC'));   --Elapsed time:  00:00:00:03

explain plan set  statement_id='5' for select sum(quantity) as products_sold from ecommerce where (extract (year from to_date(Purchase_Date,'YYYY-MM-DD')))=2019 
and (extract (month from to_date(Purchase_Date,'YYYY-MM-DD')))=2 ;
select * from table(DBMS_XPLAN.DISPLAY(null,'5','BASIC'));   --Elapsed time:  00:00:00:03

explain plan set  statement_id='6' for select sum(QUANTITY) from ECOMMERCE where PURCHASE_DATE like '2019-02%';
select * from table(DBMS_XPLAN.DISPLAY(null,'6','BASIC'));   --Elapsed time:  00:00:00:04

--QUESTION 2

--total sale amount in each year

explain plan set  statement_id='7' for select SUBSTR("PURCHASE_DATE", 1, 4) as "Year",sum(PRICE*QUANTITY) as total_sales_amount from ecommerce group by SUBSTR("PURCHASE_DATE", 1, 4);
select * from table(DBMS_XPLAN.DISPLAY(null,'7','BASIC'));  --Elapsed time:  00:00:00:13

--QUESTION 3

--total sale amount of each product on a month wise basis in the year 2019

explain plan set  statement_id='8' for select SUBSTR("PURCHASE_DATE", 6, 2) as "Month",PRODUCTNO,sum(PRICE*QUANTITY) as total_sales_amount from ECOMMERCE where SUBSTR("PURCHASE_DATE", 1, 4)='2019' group by SUBSTR("PURCHASE_DATE", 6, 2),PRODUCTNO;
select * from table(DBMS_XPLAN.DISPLAY(null,'8','BASIC')); --Elapsed time:  00:00:00:30

explain plan set  statement_id='9' for select SUBSTR("PURCHASE_DATE", 6, 2) as "Month",PRODUCTNO,PRODUCTNAME,sum(PRICE*QUANTITY) as total_sales_amount from ECOMMERCE where SUBSTR("PURCHASE_DATE", 1, 4)='2019' group by SUBSTR("PURCHASE_DATE", 6, 2),PRODUCTNO,PRODUCTNAME;
select * from table(DBMS_XPLAN.DISPLAY(null,'9','BASIC')); --Elapsed time:  00:00:00:30


--QUESTION 4

--count customer in each country

explain plan set  statement_id='11' for select country,count(distinct customerno) as "total_customers" from ECOMMERCE group by country;
select * from table(DBMS_XPLAN.DISPLAY(null,'11','BASIC'));  --Elapsed time:  00:00:00:13

--QUESTION 5

--list all unique product names sold from each year

explain plan set  statement_id='12' for SELECT DISTINCT SUBSTR("PURCHASE_DATE", 1, 4) AS "Year", PRODUCTNAME FROM ECOMMERCE; 
select * from table(DBMS_XPLAN.DISPLAY(null,'12','BASIC'));  --Elapsed:  00:00:00:21

explain plan set  statement_id='13' for SELECT DISTINCT PRODUCTNAME,EXTRACT(year FROM TO_DATE(Purchase_Date,'YYYY-MM-DD')) as "Year" FROM ecommerce; 
select * from table(DBMS_XPLAN.DISPLAY(null,'13','BASIC'));  --Elapsed:  00:00:00:10

explain plan set  statement_id='14' for SELECT SUBSTR("PURCHASE_DATE", 1, 4) AS "Year", PRODUCTNAME FROM ECOMMERCE group by SUBSTR("PURCHASE_DATE", 1, 4),PRODUCTNAME;
select * from table(DBMS_XPLAN.DISPLAY(null,'14','BASIC'));  --Elapsed:  00:00:00:19



-- FINAL OPTIMIZED CODE--

--QUESTION 1

--total products sold in feb 2019

explain plan set  statement_id='20' for select sum(quantity) as products_sold from ecommerce where (extract (year from to_date(Purchase_Date,'YYYY-MM-DD')))=2019 
and (extract (month from to_date(Purchase_Date,'YYYY-MM-DD')))=2 ;
select * from table(DBMS_XPLAN.DISPLAY(null,'20','BASIC')); --3ms

--QUESTION 2

--total sale amount in each year

explain plan set  statement_id='21' for select SUBSTR(Purchase_Date, 1, 4) as "Year",sum(PRICE*QUANTITY) 
as total_sales_amount from ecommerce group by SUBSTR(Purchase_Date, 1, 4); 
select * from table(DBMS_XPLAN.DISPLAY(null,'21','BASIC'));--16ms

--QUESTION 3

--total sale amount of each product on a month wise basis in the year 2019

explain plan set  statement_id='22' for select SUBSTR(Purchase_Date, 6, 2) as "Month",PRODUCTNO,sum(PRICE*QUANTITY) as
 total_sales_amount from ECOMMERCE where SUBSTR(Purchase_Date, 1, 4)='2019' group by SUBSTR(Purchase_Date, 6, 2),PRODUCTNO;
 select * from table(DBMS_XPLAN.DISPLAY(null,'22','BASIC')); --31ms

--QUESTION 4

--count customer in each country

explain plan set  statement_id='23' for select COUNTRY,count( DISTINCT CUSTOMERNO) as count from ECOMMERCE group by COUNTRY; 
select * from table(DBMS_XPLAN.DISPLAY(null,'23','BASIC'));--13ms

--QUESTION 5

--list all unique product names sold from each year

explain plan set  statement_id='24' for SELECT DISTINCT PRODUCTNAME AS UNIQUE_PRODUCTS,EXTRACT(year FROM TO_DATE(Purchase_Date,'YYYY-MM-DD')) as YEAR_FIELD 
FROM ecommerce; 
select * from table(DBMS_XPLAN.DISPLAY(null,'24','BASIC'));--10ms