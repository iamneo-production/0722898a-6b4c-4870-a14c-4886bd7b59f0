 set timing on;
 --1.

  SELECT SUM(quantity) AS TotProd_Sold FROM ecommerce WHERE "PURCHASE_DATE" LIKE '2019-02%';
--2.

 SELECT SUBSTR("PURCHASE_DATE",1,4) AS "field_Year", SUM(price * Quantity) AS Totl_Sal_Amnt FROM ECOMMERCE
 GROUP BY SUBSTR("PURCHASE_DATE",1,4);

--3.

 SELECT  SUBSTR("PURCHASE_DATE",6,2) AS "field_Month",productno,SUM(price * Quantity) AS TotlSal_Amnt FROM ECOMMERCE
 WHERE SUBSTR("PURCHASE_DATE",1,4)='2019'GROUP BY productno, SUBSTR("PURCHASE_DATE",6,2);
--4. 

SELECT Country, COUNT(DISTINCT customerno) AS cus_coun FROM ecommerce GROUP BY COUNTRY;
--5.
 
 SELECT DISTINCT productname AS UNQ_PRODcT, SUBSTR("PURCHASE_DATE",1,4) AS "field_Year" FROM ecommerce;



