1)

--creation of month_field and its index = Elapsed:  Elapsed:  00:00:00:04
ALTER TABLE ecommerce ADD mon_field AS (EXTRACT(MONTH FROM TO_DATE("Date",'YYYY-MM-DD')));
create index index_on_month on ecommerce(mon_field);
set timing on;
select count(productno) as products_sold from ecommerce where year_field=2019 and mon_field=2 ;


-- --3)

-- SELECT  TO_CHAR(TO_DATE("Date", 'YYYY-MM-DD'), 'Month') AS month_name
-- FROM ecommerce;
-- create index index_on_product on ecommerce(productno);
-- select productno as product,sum(quantity*price) as sale,TO_CHAR(TO_DATE("Date", 'YYYY-MM-DD'), 'Month') AS month_name from ecommerce where year_field=2019 
-- group by mon_field,productno;

-- select * from mon_field;
-- SELECT year_field, productno AS product, SUM(quantity * price) AS sale
-- FROM ecommerce
-- WHERE year_field = 2019
-- GROUP BY  productno;