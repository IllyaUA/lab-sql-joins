use sakila;
show tables;
-- lab1
SELECT * from actor;
SELECT * from film;
SELECT * from customer;

select title from film;

select name as language from language;

select first_name as names from staff;

SELECT DISTINCT release_year AS unique_release_years
FROM film;

select count(store_id) as number_of_stores from store;

select count(staff_id) as number_of_employees from staff;

select
	sum(case when return_date is null then 1 else 0 end) as films_available,
    (select count(*) from rental where return_date is not null) as films_rented
from rental;

select count(distinct Last_name) as unique_actors from actor;

-- #6
select title, length from film
	order by length desc
    limit 10;

-- #7
select * from actor where first_name= "SCARLETT";

select * from film where (title like "%ARMAGEDDON%") and (length > 100);

select count(*) as films_with_behind_the_scenes from film where special_features like "%behind%scene%";

-- #End of Lab1
-- lab2: sql-aggregation-and-transformation

select title, length from film
 where (length= (select max(length) from film)) or (length=(select min(length) from film))
 order by length desc;

select concat(floor(avg(length) / 60), "hours ", round(avg(length) % 60,1), "min") as avg_duration from film;

-- #2
use sakila;
select datediff(max(rental_date), min(rental_date)) as days_operating from rental;

select *, month(rental_date) as rental_month, dayname(rental_date) as rental_weekday from rental limit 20;

select *, 
	case when dayofweek(rental_date) in (6,7) then "weekend" else "workday" end
    as DAY_TYPE from rental;
    
-- #3

select title, coalesce(rental_duration, "not available") as rental_duration from film order by title asc;

-- #4
select concat(first_name, " ", last_name) as full_name, left(email,3) as email_prefix from customer order by last_name asc;

-- Challenge 2
#1.1
select count(DISTINCT title) as total_films_released from film; # count total nr of ffilms released

#1.2 number of films in each rating category
select rating, count(distinct title) as number_of_films from film group by rating;

#1.3number of films in each rating group sorted by number of films
SELECT rating, count(*) as number_of_films from film group by rating order by number_of_films desc;

#2
select staff_id, count(*) as rental_processed from rental GROUP BY staff_id;

#3.1
select rating, round(avg(length),2)as mean_duration from film GROUP BY rating ORDER BY mean_duration;

#3.2
select rating from film group BY rating having avg(length)>120;

#4.
select last_name from actor group by last_name having count(distinct last_name)=1;






