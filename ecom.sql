create index ecommerce_cno_con_indx on ecommerce(customerno,country);
//4//
select count(customerno) from ecommerce group by country;

//1//
select count(prouductno) from ecommerce
where year(date)=2019 and month(date)=2; 

//2//
select sum(price) from ecommerce group by year_field;
select *from ecommerce;

//5//
select distinct productname from ecommerce group by year_field;