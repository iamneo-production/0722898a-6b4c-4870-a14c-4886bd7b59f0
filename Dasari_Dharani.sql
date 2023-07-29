select * from ecommerce;
-- desc ecommerce;
set timing on;


--Final Optimized Code--

-- Question 1

SELECT SUM(quantity) AS Total_Products_Sold
FROM ecommerce
WHERE "PURCHASE_DATE" LIKE '2019-02%';


-- Question 2

SELECT SUBSTR("PURCHASE_DATE",1,4) AS "Year", 
SUM(price * Quantity) AS Total_Sales_Amount
FROM ECOMMERCE
GROUP BY SUBSTR("PURCHASE_DATE",1,4);

-- Question 3

SELECT 
SUBSTR("PURCHASE_DATE",6,2) AS "Month",
productno,
SUM(price * Quantity) AS Total_Sales_Amount
FROM ECOMMERCE
WHERE "PURCHASE_DATE" LIKE '2019%'
GROUP BY productno, 
SUBSTR("PURCHASE_DATE",6,2);

--or--

SELECT 
SUBSTR("PURCHASE_DATE",6,2) AS "Month",
productno,
SUM(price * Quantity) AS Total_Sales_Amount
FROM ECOMMERCE
WHERE SUBSTR("PURCHASE_DATE",1,4)='2019'
GROUP BY productno, 
SUBSTR("PURCHASE_DATE",6,2);

-- Question 4

SELECT Country, COUNT(DISTINCT customerno) AS customer_count
FROM ecommerce
GROUP BY COUNTRY;

-- Question 5

SELECT DISTINCT productname AS UNIQUE_PRODUCTS, 
SUBSTR("PURCHASE_DATE",1,4) AS Year
FROM ecommerce;

-- Creating Index

-- CREATE INDEX month_in_date_idx ON ecommerce(EXTRACT(MONTH FROM TO_DATE("Date",'YYYY-MM-DD')));
-- CREATE INDEX year_in_date_idx ON ecommerce(EXTRACT(YEAR FROM TO_DATE("Date",'YYYY-MM-DD')));