set timing on;

--FINAL OPTIMIZED CODES
-- QUESTION 1
--total products sold in feb 2019


SELECT SUM(quantity) AS Total_products
FROM ecommerce
WHERE "PURCHASE_DATE" LIKE '2019-02%';

--QUESTION 2
--total sale amount in each year

SELECT SUBSTR("PURCHASE_DATE",1,4) AS "Year", 
SUM(price * Quantity) AS Total_sales
FROM ECOMMERCE
GROUP BY SUBSTR("PURCHASE_DATE",1,4);

--QUESTION 3
--total sale amount of each product on a month wise basis in the year 2019

SELECT 
SUBSTR("PURCHASE_DATE",6,2) AS "Month",
productno,
SUM(price * Quantity) AS Total_Sales
FROM ECOMMERCE
WHERE SUBSTR("PURCHASE_DATE",1,4)='2019'
GROUP BY productno, 
SUBSTR("PURCHASE_DATE",6,2);

--QUESTION 4
--count customers in each country

SELECT Country, COUNT(DISTINCT customerno) AS Customer_count
FROM ecommerce
GROUP BY COUNTRY;

--QUESTION 5
--list all unique product names sold from each year

SELECT DISTINCT productname AS Unique_products, 
SUBSTR("PURCHASE_DATE",1,4) AS "Year"
FROM ECOMMERCE;