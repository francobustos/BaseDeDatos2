-- Write a query that gets all the customers that live in Argentina. Show the first and last name in one column, the address and the city.
SELECT CONCAT(first_name, ' ', last_name), address, city
FROM customer 
JOIN address USING (address_id)
JOIN city USING (city_id)
JOIN country USING (country_id)
WHERE country LIKE 'Argentina';

-- Write a query that shows the film title, language and rating. Rating shall be shown as the full text described here.
SELECT title, name as 'language',
CASE 
WHEN rating = 'G' THEN 'All ages admitted'
WHEN rating = 'PG' THEN 'Some material may not be suitable for children'
WHEN rating = 'PG-13' THEN 'Some material may be inappropriate for children under 13'
WHEN rating = 'NC-17' THEN 'No one 17 and under admitted'
ELSE 'N/A' END AS 'rating_describe'
FROM film
JOIN `language` USING (language_id);

-- Write a search query that shows all the films (title and release year) an actor was part of. 
SELECT title, release_year, first_name, last_name FROM film
JOIN film_actor USING (film_id)
JOIN actor USING (actor_id)
WHERE UPPER(CONCAT(first_name, ' ', last_name)) LIKE UPPER('%PENELOPE GUINESS%')

-- Find all the rentals done in the months of May and June. Show the film title, customer name and if it was returned or not. There should be returned column with two possible values 'Yes' and 'No'.
SELECT f.title, CONCAT(first_name, ' ', last_name) as 'name',CASE
WHEN r.return_date IS NOT NULL THEN 'YES'
ELSE 'NO' END AS 'returned'
FROM rental r
JOIN inventory USING (inventory_id)
JOIN film f USING (film_id)
JOIN customer c USING (customer_id)
WHERE MONTHNAME(r.rental_date) IN ('May','June')

-- Investigate CAST and CONVERT functions. Explain the differences if any, write examples based on sakila DB. 
-- Son muy parecidos uno de otro, lo que cambia es la sintaxis y que convert puede cambiar un valor a un character_set.
SELECT CONVERT(CONCAT(first_name, ' ', last_name) using utf8)
FROM actor;

-- Investigate NVL, ISNULL, IFNULL, COALESCE, etc type of function. Explain what they do. Which ones are not in MySql and write usage examples.

-- The MySQL IFNULL() function lets you return an alternative value if an expression is NULL.
SELECT CONCAT(first_name, ' ', last_name) as name, rental_date, return_date, DATEDIFF(IFNULL(r.return_date, NOW()), r.rental_date) as 'dias_rentados'
FROM rental r
JOIN customer USING (customer_id)

-- The COALESCE() function returns the first non-null value in a list.
SELECT CONCAT(first_name, ' ', last_name) as name, COALESCE(email, phone, CONCAT_WS(", ", address, city, country), 'NO TIENE') as 'contacto'
FROM customer c
JOIN address USING (address_id)
JOIN city USING (city_id)
JOIN country USING (country_id)

-- The ISNULL() function returns a specified value if the expression is NULL. Funciona igual que IFNULL(). 
-- No es compatible con MySQL, esta mas pensado para SQL Server y MS Access

-- NVL() tiene la misma función, no es compatible con MySQL y esta pensado para Oracle



