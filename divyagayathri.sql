-- set timing on;
-- alter table ecommerce add column year_field number as extract( YEAR from TO_DATE("Date",'YYYY-MM-DD'));
-- create index index_on_year on ecommerce(year_field);


--2)
--creation of index on  entire Date column
create index index_on_year on ecommerce(year_field);

ALTER TABLE ecommerce ADD year_field number AS (SUBSTR("Date", 1, 4) );



select * from ecommerce;
alter table ecommerce drop column year_field;
-- create index index_on_year on ecommerce(year_field);

select year_field from ecommerce;
--without index on  entire Date column = Elapsed:  00:00:00:42
select sum(price*quantity) as total_sale,extract(YEAR from TO_DATE("Date",'YYYY-MM-DD')) as year from ecommerce group by extract(YEAR from TO_DATE("Date",'YYYY-MM-DD'));

--with index on column year_field = Elapsed:  00:00:00:14
select sum(price*quantity) as total_sale,year_field as year from ecommerce group by year_field; 

-- 1)
-- --creation of month_field and its index
-- alter table ecommerce add month_field number;
-- update ecommerce set month_field=EXTRACT(MONTH FROM TO_DATE("Date",'YYYY-MM-DD'));
-- set timing on;

-- select * from ecommerce;


