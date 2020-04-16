-- Show title and special_features of films that are PG-13
SELECT title, special_features
 FROM film
WHERE rating = 'PG-13';

-- Get a list of all the different films duration.
SELECT DISTINCT `length` 
FROM film
order by 1;

-- Show title, rental_rate and replacement_cost of films that have replacement_cost from 20.00 up to 24.00
SELECT title, rental_rate, replacement_cost
FROM film
where replacement_cost >= 20.00 and replacement_cost <= 24.00;

-- Show title, category and rating of films that have 'Behind the Scenes' as special_features
select f.title, f.rating, f.special_features, c.name 
from film f, category c, film_category fc 
where special_features LIKE '%Behind the Scenes%' and f.film_id = fc.film_id  and c.category_id = fc.category_id;

-- Show first name and last name of actors that acted in 'ZOOLANDER FICTION'
select a.first_name, a.last_name
from actor a, film f, film_actor fa 
where f.title = 'ZOOLANDER FICTION' and f.film_id = fa.film_id and a.actor_id = fa.actor_id 

-- Show the address, city and country of the store with id 1
SELECT s.store_id, a.address ,ci.city, co.country 
FROM store s, address a, city ci, country co
where s.store_id = 1 and s.address_id = a.address_id and a.city_id = ci.city_id and ci.country_id = co.country_id; 

-- Show pair of film titles and rating of films that have the same rating.
/*SELECT f.title, f1.title, f.rating
FROM film f, film f1
where f.rating = f1.rating and f.film_id <> f1.film_id
No supe hacerla*/

-- Get all the films that are available in store id 2 and the manager first/last name of this store (the manager will appear in all the rows).
SELECT DISTINCT f.title, s.store_id, m.first_name, m.last_name 
FROM store s, film f, inventory i, staff m 
where s.store_id = 2 and s.store_id = i.store_id and f.film_id = i.film_id; 

