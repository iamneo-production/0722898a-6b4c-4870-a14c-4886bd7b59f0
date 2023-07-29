
--creation of indexes
create index index_on_date on ecommerce(PURCHASE_DATE);
create index index_on_country on ecommerce(country);
create index index_on_product on ecommerce(productno);

set timing on;
-- FINAL OPTIMIZED CODES--

--question 1)
select sum(QUANTITY) as total_quantity_purchased FROM ECOMMERCE where PURCHASE_DATE like '2019-02%'; 

--question 2)
select SUBSTR(Purchase_Date, 1, 4) as Year_of_Purchase,sum(PRICE*QUANTITY) 
as sales_amount from ecommerce group by SUBSTR(Purchase_Date, 1, 4); 

--question 3)
select SUBSTR(Purchase_Date, 6, 2) as Month_of_purchase,PRODUCTNO,sum(PRICE*QUANTITY) as
 sales_amount from ECOMMERCE where SUBSTR(Purchase_Date, 1, 4)='2019' group by SUBSTR(Purchase_Date, 6, 2),PRODUCTNO;

 --question 4)
 select COUNTRY,count( DISTINCT CUSTOMERNO) as Customer_Count from ECOMMERCE group by COUNTRY; 

 --question 5)
SELECT DISTINCT PRODUCTNAME AS unique_products_sold,SUBSTR(Purchase_Date, 1, 4) as YEAR
FROM ecommerce; 