-- 1. 
SELECT SUM(quantity) AS Total_Sold
FROM ecommerce
WHERE "PURCHASE_DATE" LIKE '2019-02%';

-- --------------------------------------------------------------------------------------
-- 2.

 SELECT SUBSTR("PURCHASE_DATE",1,4) AS "Year", 
SUM(price * Quantity) AS Total_Sales_Amount
FROM ECOMMERCE
GROUP BY SUBSTR("PURCHASE_DATE",1,4);

-- --------------------------------------------------------------------------------------
-- 3.
 SELECT 
SUBSTR("PURCHASE_DATE",6,2) AS "Month",
productno,
SUM(price * Quantity) AS Total_Sales_Amount
FROM ECOMMERCE
WHERE SUBSTR("PURCHASE_DATE",1,4)='2019'
GROUP BY productno, 
SUBSTR("PURCHASE_DATE",6,2);

-- ---------------------------------------------------------------------------------------
-- 4.
 SELECT Country, COUNT(DISTINCT customerno) AS customer_count
FROM ECOMMERCE
GROUP BY COUNTRY;

-- -----------------------------------------------------------------------------------
-- 5. 


Select distinct PRODUCTNAME AS unique_products,SUBSTR(Purchase_Date,1,4)as "Years" from ECOMMERCE;



