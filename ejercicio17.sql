/*Create two or three queries using address table in sakila db:

include postal_code in where (try with in/not it operator)
eventually join the table with city/country tables.
measure execution time.
Then create an index for postal_code on address table.
measure execution time again and compare with the previous ones.
Explain the results*/

SELECT *
FROM address a 
JOIN city ci USING (city_id)
JOIN country co USING (country_id)
WHERE a.postal_code = 35200;

-- 6 ms

CREATE INDEX postal_code ON address(postal_code);

-- 3 ms
-- Esto se debe que ahora al buscar los resultados, al estar postal code indexeado, no recorre la lista uno a uno sino que por partes y esto permite mayor velocidad.

-- Run queries using actor table, searching for first and last name columns independently. Explain the differences and why is that happening?
/*SELECT first_name, last_name
FROM actor a
WHERE first_name NOT IN (SELECT first_name from actor a2 where a2.actor_id <> a.actor_id) 
AND last_name NOT IN (SELECT last_name from actor a2 where a2.actor_id <> a.actor_id) LIMIT 1;
Para no tener varios resultados*/


SELECT * 
FROM actor a 
WHERE first_name = 'BETTE';

SELECT * 
FROM actor a 
WHERE last_name = 'NICHOLSON';

/* Los dos tardaron lo mismo puesto que la query es muy pequeña y no se nota diferencia de tiempo. 
Pero si fuese una consulta mas grande, apellido tardara menos en mostrar por ser un indice*/

/*Compare results finding text in the description on table film with LIKE and in the film_text using MATCH ... AGAINST. 
Explain the results.*/

SELECT * 
FROM film_text ft 
WHERE description LIKE '%Epic Drama of a Feminist And a Mad%';

SELECT title, description 
FROM film_text ft 
WHERE MATCH(title,description) AGAINST('Epic Drama of a Feminist And a Mad');
-- No se explicarlo

