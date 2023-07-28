set timing on;

-- QUESTION 1
select sum(QUANTITY) as total_quantity FROM ECOMMERCE where PURCHASE_DATE like '2019-02%'; -- 3ms

explain plan set  statement_id='5'for select sum(QUANTITY) as total_quantity from ecommerce 
where Purchase_Date>='2019-02-01' and Purchase_Date<'2019-03-01'; 
select * from table(DBMS_XPLAN.DISPLAY(null,'5','BASIC'));-- before 7ms, after 3,4ms

select sum(QUANTITY) as total_quantity FROM ECOMMERCE where extract(year from TO_DATE(PURCHASE_DATE,'YYYY-MM-DD'))=2019 
and extract(month from TO_DATE(PURCHASE_DATE,'YYYY-MM-DD'))=02;     -- 00:00:00:06
select PURCHASE_DATE, YEAR_FIELD from ECOMMERCE;

create index index_on_date on ECOMMERCE(PURCHASE_DATE);
-- select * from ECOMMERCE where COUNTRY= 'USA';
drop index index_on_date;

-- QUESTION 2
explain plan set  statement_id='7' for select sum(PRICE * QUANTITY) as sale_amount,
extract(year from TO_DATE(PURCHASE_DATE,'YYYY-MM-DD')) AS "year"
from ECOMMERCE group by extract(year from TO_DATE(PURCHASE_DATE,'YYYY-MM-DD')); -- 30ms
select * from table(DBMS_XPLAN.DISPLAY(null,'7','BASIC'));

--QUESTION 3
explain plan set  statement_id='8' for select PRODUCTNO,extract(month from TO_DATE(PURCHASE_DATE,'YYYY-MM-DD')) as Sale_month,
sum(PRICE * QUANTITY) as sale_amount from ecommerce 
where PURCHASE_DATE like '2019%' group by productno, extract(month from TO_DATE(PURCHASE_DATE,'YYYY-MM-DD')); 
select * from table(DBMS_XPLAN.DISPLAY(null,'8','BASIC'));-- 40ms

select PRODUCTNO,mon_field,sum(price*QUANTITY) from ECOMMERCE where year_field='2019' group by productno,mon_feild;
select PRODUCTNO,extract(month from TO_DATE(PURCHASE_DATE,'YYYY-MM-DD')),sum(PRICE * QUANTITY) as sale_amount from ecommerce 
where extract(year from TO_DATE(PURCHASE_DATE,'YYYY-MM-DD'))='2019' group by productno, extract(month from TO_DATE(PURCHASE_DATE,'YYYY-MM-DD'));--75ms

select PRODUCTNO,extract(month from TO_DATE(PURCHASE_DATE,'YYYY-MM-DD')),sum(PRICE * QUANTITY) as sale_amount from ecommerce 
where PURCHASE_DATE>='2019-01-01' and PURCHASE_DATE<'2020-01-01' group by productno, extract(month from TO_DATE(PURCHASE_DATE,'YYYY-MM-DD'));--38ms - 42ms

--QUESTION 4
explain plan set  statement_id='10' for select COUNTRY,count( DISTINCT CUSTOMERNO) as count from ECOMMERCE group by COUNTRY; 
select * from table(DBMS_XPLAN.DISPLAY(null,'10','BASIC'));-- 13ms

-- create index index_on_cou_cus on ECOMMERCE(COUNTRY,CUSTOMERNO);
-- drop index index_on_cou_cus;

--QUESTION 5
select  Distinct PRODUCTNAME, extract(year from TO_DATE(Purchase_Date,'YYYY-MM-DD')) as year from ECOMMERCE ; -- 10ms

select  PRODUCTNAME, extract(year from TO_DATE(Purchase_Date,'YYYY-MM-DD')) from ECOMMERCE 
group by extract(year from TO_DATE(Purchase_Date,'YYYY-MM-DD')),productname ; --38ms
 

-- FINAL OPTIMIZED CODE--

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
