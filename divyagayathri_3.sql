
create index index_on_date on ecommerce(PURCHASE_DATE);

create index index_on_country on ecommerce(country);

create index index_on_product on ecommerce(productno);

create index index_on_year_and_mon on ecommerce((extract (year from to_date(PURCHASE_DATE,'YYYY-MM-DD'))),
(extract (month from to_date(PURCHASE_DATE,'YYYY-MM-DD'))));

select * from ecommerce;


--Question 1) Elapsed:  00:00:00:03 (index_on_year_and_mon)
set timing on;

explain plan set statement_id='1' for
select sum(quantity) as products_sold from ecommerce 
where (extract (year from to_date(PURCHASE_DATE,'YYYY-MM-DD')))=2019 and 
(extract (month from to_date(PURCHASE_DATE,'YYYY-MM-DD')))=2 ;
select * from table(DBMS_XPLAN.DISPLAY(null,'1','BASIC'));


--Question 2)Elapsed:  00:00:00:22(no index)
explain plan set statement_id='2' for
select sum(price*quantity) as total_sale,
extract (year from to_date(PURCHASE_DATE,'YYYY-MM-DD')) as year_of_sale from ecommerce 
group by
extract (year from to_date(PURCHASE_DATE,'YYYY-MM-DD')); 
select * from table(DBMS_XPLAN.DISPLAY(null,'2','BASIC'));

-- Question 3)

--Elapsed:  00:00:00:55(!no index)
explain plan set  statement_id='3_1' for select extract(month from TO_DATE(PURCHASE_DATE,'YYYY-MM-DD')) as mon,
productno,sum(PRICE * QUANTITY) as sale_amount from ecommerce 
where PURCHASE_DATE like '2019%' 
group by 
productno, extract(month from TO_DATE(PURCHASE_DATE,'YYYY-MM-DD')); 
select * from table(DBMS_XPLAN.DISPLAY(null,'3_1','BASIC'));

-- or

-- Elapsed:  00:00:00:82 
explain plan set statement_id='3_2' for
 SELECT EXTRACT(MONTH FROM TO_DATE(PURCHASE_DATE,'YYYY-MM-DD')) AS mon,
       PRODUCTNO,
       SUM(PRICE * QUANTITY) AS TOTAL_SALE_AMOUNT
FROM ecommerce
WHERE EXTRACT(YEAR FROM TO_DATE(PURCHASE_DATE,'YYYY-MM-DD')) = 2019
GROUP BY EXTRACT(MONTH FROM TO_DATE(PURCHASE_DATE,'YYYY-MM-DD')), PRODUCTNO
ORDER BY EXTRACT(MONTH FROM TO_DATE(PURCHASE_DATE,'YYYY-MM-DD')), PRODUCTNO;
select * from table(DBMS_XPLAN.DISPLAY(null,'3_2','BASIC'));


--Question 4)

--  Elapsed:  00:00:00:13 (no index)
explain plan set statement_id='4' for
select country,count(distinct customerno) as count from ecommerce
group by 
country;
select * from table(DBMS_XPLAN.DISPLAY(null,'4','BASIC'))


--Question 5)

--  Elapsed:  00:00:00:10 (prname_date_idx)
set timing on;
explain plan set statement_id='5' for
SELECT DISTINCT PRODUCTNAME AS UNIQUE_PRODUCTS,
EXTRACT(year FROM TO_DATE(PURCHASE_DATE,'YYYY-MM-DD')) as YEAR_FIELD 
FROM ecommerce;
select * from table(DBMS_XPLAN.DISPLAY(null,'5','BASIC'))

----------------------------------------------------------------------------------------------------------------------------

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
explain plan set  statement_id='20' for select sum(quantity) as products_sold 
from ecommerce where (extract (year from to_date(Purchase_Date,'YYYY-MM-DD')))=2019 
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
explain plan set  statement_id='24' for SELECT DISTINCT PRODUCTNAME AS UNIQUE_PRODUCTS,
EXTRACT(year FROM TO_DATE(Purchase_Date,'YYYY-MM-DD')) as YEAR_FIELD 
FROM ecommerce; 
select * from table(DBMS_XPLAN.DISPLAY(null,'24','BASIC'));--10ms