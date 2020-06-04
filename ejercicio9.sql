-- Get the amount of cities per country in the database. Sort them by country, country_id.
SELECT co.country, co.country_id, count(*) AS ciudades
FROM country co, city ci
WHERE co.country_id = ci.country_id
GROUP BY co.country, co.country_id;

-- Get the amount of cities per country in the database. Show only the countries with more than 10 cities, order from the highest amount of cities to the lowest
SELECT co.country, count(*) AS ciudades
FROM country co, city ci
WHERE co.country_id = ci.country_id
GROUP BY co.country
HAVING ciudades > 10
ORDER BY ciudades DESC;

-- Generate a report with customer (first, last) name, address, total films rented and the total money spent renting films.
-- Show the ones who spent more money first.
SELECT c.first_name, c.last_name, a.address, 
(SELECT count(*) FROM rental r WHERE c.customer_id = r.customer_id) AS cantidad_de_peliculas,
(SELECT sum(amount) FROM payment p WHERE p.customer_id = c.customer_id) AS total
FROM customer c, address a
WHERE c.address_id = a.address_id
GROUP BY c.first_name, c.last_name, a.address
ORDER BY total DESC; 

-- Which film categories have the larger film duration (comparing average)?
-- Order by average in descending order
SELECT c.name, AVG(f.`length` ) AS promedio_de_duracion
FROM category c, film_category fc, film f
WHERE c.category_id = fc.category_id AND fc.film_id = f.film_id
GROUP BY c.name
HAVING promedio_de_duracion > (SELECT avg(`length`) FROM film)
ORDER BY promedio_de_duracion DESC;

-- Show sales per film rating
SELECT f.rating, COUNT(*) AS ventas
FROM film f, inventory i 
WHERE f.film_id = i.film_id
GROUP BY f.rating; 





