set timing on;
-1.

select  SUM(Quantity) as soldproducts  
from ecommerce where "PURCHASE_DATE" >='2019-02-01' 
AND "PURCHASE_DATE" <'2019-03-01';



-- --------------------------------------------------------


--2

select EXTRACT(year from To_Date("PURCHASE_DATE",'YYYY-MM-DD'))
as Sale_Year,sum(Quantity*Price) as Total_saleamount
from ECOMMERCE group by EXTRACT(year from To_Date("PURCHASE_DATE",'YYYY-MM-DD'));


-- --------------------------------------------------------------------------

-- 3

select EXTRACT(month from To_Date("PURCHASE_DATE",'YYYY-MM-DD'))as month_sales,
sum(Quantity*price)as total_sales,productno  from Ecommerce where 
extract(year from To_Date("PURCHASE_DATE",'YYYY-MM-DD'))='2019'
 group by PRODUCTNO,extract(month from To_Date("PURCHASE_DATE",'YYYY-MM-DD'));
 



 select SUBSTR("PURCHASE_DATE", 6, 2) as "Month",PRODUCTNO,sum(PRICE*QUANTITY) as
 total_sales_amount from ECOMMERCE where SUBSTR("PURCHASE_DATE", 1, 4)='2019' group by SUBSTR("PURCHASE_DATE", 6, 2),PRODUCTNO;




SELECT
    SUBSTR(e."PURCHASE_DATE", 6, 2) AS "Month",
    e.PRODUCTNO,
    SUM(e.PRICE * e.QUANTITY) AS total_sales_amount
FROM
    ECOMMERCE e
WHERE
    SUBSTR(e."PURCHASE_DATE", 1, 4) = '2019'
GROUP BY
     SUBSTR(e."PURCHASE_DATE", 6, 2),
    e.PRODUCTNO;



-- -------------------------------------------------------------------------------

-- 4
select count(DISTINCT CUSTOMERNO) as customer_count,country
 from ecommerce group by country;


-- -------------------------------------------------------------------------------

--5

select distinct(PRODUCTNAME),EXTRACT(year from To_Date
("PURCHASE_DATE",'YYYY-MM-DD'))
as Sale_Year from ECOMMERCE;




-- ----------------------------------------------------------------------
-- OPTIMIZED CODES

--1)
select sum(quantity) as products_sold from ecommerce where (extract (year from to_date(Purchase_Date,'YYYY-MM-DD')))=2019 
and (extract (month from to_date(Purchase_Date,'YYYY-MM-DD')))=2 ;





-- 2)
select SUBSTR(Purchase_Date, 1, 4) as "Year",sum(PRICE*QUANTITY) 
as total_sales_amount from ecommerce group by SUBSTR(Purchase_Date, 1, 4); 




-- 3)

select SUBSTR(Purchase_Date, 6, 2) as "Month",PRODUCTNO,sum(PRICE*QUANTITY) as
 total_sales_amount from ECOMMERCE where SUBSTR(Purchase_Date, 1, 4)='2019' group by SUBSTR(Purchase_Date, 6, 2),PRODUCTNO;




--  4)
select COUNTRY,count( DISTINCT CUSTOMERNO) as count from ECOMMERCE group by COUNTRY; 




-- 5)
SELECT DISTINCT PRODUCTNAME AS UNIQUE_PRODUCTS,EXTRACT(year FROM TO_DATE(Purchase_Date,'YYYY-MM-DD')) as YEAR_FIELD 
FROM ecommerce; 





-- WITH EXPLAIN COMMAND


--1)

explain plan set  statement_id='5'for select sum(quantity) as products_sold from ecommerce where (extract (year from to_date("PURCHASE_DATE",'YYYY-MM-DD')))=2019 
and (extract (month from to_date("PURCHASE_DATE",'YYYY-MM-DD')))=2 ;
select * from table(DBMS_XPLAN.DISPLAY(null,'5','BASIC'));



-- 2)

explain plan set  statement_id='6'for select SUBSTR("PURCHASE_DATE", 1, 4) as "Year",sum(PRICE*QUANTITY) 
as total_sales_amount from ecommerce group by SUBSTR("PURCHASE_DATE", 1, 4); 
select * from table(DBMS_XPLAN.DISPLAY(null,'6','BASIC'));




-- 3)

explain plan set  statement_id='7'for select SUBSTR("PURCHASE_DATE", 6, 2) as "Month",PRODUCTNO,sum(PRICE*QUANTITY) as
 total_sales_amount from ECOMMERCE where SUBSTR("PURCHASE_DATE", 1, 4)='2019' group by SUBSTR("PURCHASE_DATE", 6, 2),PRODUCTNO;
 select * from table(DBMS_XPLAN.DISPLAY(null,'7','BASIC'));


--  4)
explain plan set  statement_id='8'for select COUNTRY,count( DISTINCT CUSTOMERNO) as count from ECOMMERCE group by COUNTRY;
select * from table(DBMS_XPLAN.DISPLAY(null,'8','BASIC'));


-- 5)
explain plan set  statement_id='9'for SELECT DISTINCT PRODUCTNAME AS UNIQUE_PRODUCTS,EXTRACT(year FROM TO_DATE("PURCHASE_DATE",'YYYY-MM-DD')) as YEAR_FIELD 
FROM ecommerce; 
select * from table(DBMS_XPLAN.DISPLAY(null,'9','BASIC'));

