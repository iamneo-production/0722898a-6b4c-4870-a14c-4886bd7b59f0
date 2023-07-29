set timing on;
--The above command is used to measure run time--

---------------FINAL OPTIMIZED CODE-----------------

--QUERY1--
--SQL Query to how many products were sold in February 2019--
SELECT SUM(quantity) AS Products_Sold
FROM ecommerce
WHERE "PURCHASE_DATE" LIKE '2019-02%';


--Query-2--
--SQL Query to Total sales amount in each year--
SELECT SUBSTR("PURCHASE_DATE",1,4) AS "Year_Field", 
SUM(price * Quantity) AS Total_Sales_Amount
FROM ECOMMERCE
GROUP BY SUBSTR("PURCHASE_DATE",1,4);


--QUERY3--
--SQL Query to what was the total sales amount of each product on a month-wise basis in the year 2019--
SELECT 
SUBSTR("PURCHASE_DATE",6,2) AS "Month_Field",
productno as PRODUCT,
SUM(price * Quantity) AS Total_Sales_Amount
FROM ECOMMERCE
WHERE SUBSTR("PURCHASE_DATE",1,4)='2019'
GROUP BY productno, 
SUBSTR("PURCHASE_DATE",6,2);


--QUERY4--
--SQL Query to Count the customers from each country--
SELECT Country, COUNT(DISTINCT customerno) AS Count_of_Customer
FROM ecommerce
GROUP BY COUNTRY;

--CREATE BIPMAP INDEX--
--create bitmap index prname_date_idx on ecommerce(productname,extract(year from TO_DATE ("PURCHASE_DATE",'YYYY-MM-DD')),--
--extract(month from TO_DATE ("PURCHASE_DATE",'YYYY-MM-DD')));--

--QUERY5--
--SQL Query to list unique product names sold from each year--
 SELECT DISTINCT productname AS UNIQUEPRODUCTS, 
SUBSTR("PURCHASE_DATE",1,4) AS "Year_Field"
FROM ecommerce;