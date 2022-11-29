create table laptops
(year varchar(50),
 brand varchar(50),
 price int
)

insert into laptops values ('2018', 'HP',  53000);
insert into laptops values ('2018', 'Samsung',  50000);
insert into laptops values ('2018', 'Lenovo',  30000);
insert into laptops values ('2018', 'Acer',  50000);
insert into laptops values ('2019', 'HP',  56000);
insert into laptops values ('2019', 'Samsung',  45000);
insert into laptops values ('2019', 'Lenovo',  37000);
insert into laptops values ('2019', 'Acer',  47000);
insert into laptops values ('2020', 'HP',  63000);
insert into laptops values ('2020', 'Samsung',  49000);
insert into laptops values ('2020', 'Lenovo',  42000);
insert into laptops values ('2020', 'Acer',  53000);
insert into laptops values ('2021', 'HP',  69000);
insert into laptops values ('2021', 'Samsung',  55000);
insert into laptops values ('2021', 'Lenovo',  45000);
insert into laptops values ('2021', 'Acer',  56000);

--select * query
select * from laptops order by year

--creating next_price
select *,
lead(price) over(partition by brand order by year asc) as next_price
from laptops

--creating next_price
select *,
lEAD(price,1,price+1) over(partition by brand order by year asc) as next_price
from laptops


--difference beteen prices from two years
with price_data AS (
select *,
lEAD(price,1,price+1) over(partition by brand order by year asc) as next_price
from laptops )

select *,next_price-price as price_increase from price_data


--creating flag 
with price_data AS (
select *,
lEAD(price,1,price+1) over(partition by brand order by year asc) as next_price
from laptops )

select *,next_price-price as price_increase,
case when next_price-price > 0 THEN 1 else 0 END as price_increase_flag
from price_data

--fetching only relevant brands
with price_data AS (
select *,
lEAD(price,1,price+1) over(partition by brand order by year asc) as next_price
from laptops )
select *,next_price-price as price_increase,
case when next_price-price > 0 THEN 1 else 0 END as price_increase_flag
from price_data 
where brand not in (select brand from price_data where next_price-price<0)


--selecting distinct brands
with price_data AS (
select *,
lEAD(price,1,price+1) over(partition by brand order by year asc) as next_price
from laptops )

select distinct brand
from price_data 
where brand not in (select brand from price_data where next_price-price<0)

