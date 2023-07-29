
<<<<<<< HEAD
----QUERY 1
SELECT SUM(quantity) AS TotalProducts_Sold
FROM ecommerce
WHERE "PURCHASE_DATE" LIKE '2019-02%';

----QUERY 2
SELECT SUBSTR("PURCHASE_DATE",1,4) AS "Year", 
SUM(price * Quantity) AS TotalSalesAmount
FROM ECOMMERCE
GROUP BY SUBSTR("PURCHASE_DATE",1,4);

----QUERY 3
SELECT 
SUBSTR("PURCHASE_DATE",6,2) AS "Month",
productno,
SUM(price * Quantity) AS TotalSalesAmount
=======
---QUERY 1
SELECT SUM(quantity) AS Total_Products_Sold
FROM ecommerce
WHERE "PURCHASE_DATE" LIKE '2019-02%';

---QUERY 2
SELECT SUBSTR("PURCHASE_DATE",1,4) AS "Year", 
SUM(price * Quantity) AS Total_Sales_Amount
FROM ECOMMERCE
GROUP BY SUBSTR("PURCHASE_DATE",1,4);

---QUERY 3
SELECT 
SUBSTR("PURCHASE_DATE",6,2) AS "Month",
productno,
SUM(price * Quantity) AS Total_SalesAmount
>>>>>>> Oracle-Workspace-Dismi24-mb
FROM ECOMMERCE
WHERE SUBSTR("PURCHASE_DATE",1,4)='2019'
GROUP BY productno, 
SUBSTR("PURCHASE_DATE",6,2);

<<<<<<< HEAD
----QUERY 4
SELECT Country, COUNT(DISTINCT customerno) AS customer_count
FROM ecommerce
GROUP BY COUNTRY;

----QUERY 5
SELECT DISTINCT productname AS UNIQUE_PRODUCTS, 
SUBSTR("PURCHASE_DATE",1,4) AS "Year"
FROM ECOMMERCE;
=======
---QUERY 4
SELECT Country, COUNT(DISTINCT customerno) AS customers_count
FROM ecommerce
GROUP BY COUNTRY;

---QUERY 5
SELECT DISTINCT productname AS ALL_UNIQUE_PRODUCTS, 
SUBSTR("PURCHASE_DATE",1,4) AS "Year"
from ECOMMERCE;
>>>>>>> Oracle-Workspace-Dismi24-mb
