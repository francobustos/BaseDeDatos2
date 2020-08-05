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



