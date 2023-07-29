set timing on;
-- FINAL OPTIMIZED CODE--

--1
select sum(QUANTITY) as total_quantity FROM ECOMMERCE where PURCHASE_DATE like '2019-02%'; 

--2
select SUBSTR(Purchase_Date, 1, 4) as Purchased_Year,sum(PRICE*QUANTITY) 
as sales_amount from ecommerce group by SUBSTR(Purchase_Date, 1, 4); 

--3
select SUBSTR(Purchase_Date, 6, 2) as Purchased_Month,PRODUCTNO,sum(PRICE*QUANTITY) as
 sales_amount from ECOMMERCE where SUBSTR(Purchase_Date, 1, 4)='2019' group by SUBSTR(Purchase_Date, 6, 2),PRODUCTNO;

 --4
 select COUNTRY,count( DISTINCT CUSTOMERNO) as Customer_Count from ECOMMERCE group by COUNTRY; 

 --5
SELECT DISTINCT PRODUCTNAME AS unique_products,SUBSTR(Purchase_Date, 1, 4) as YEAR
FROM ecommerce; 
