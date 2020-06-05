
-- Find all the film titles that are not in the inventory.
 SELECT
	f.title,
	i.*
FROM
	film f
LEFT JOIN inventory i
	inventory_id IS NULL;
-- Find all the films that are in the inventory but were never rented.

-- Show title and inventory_id.
 SELECT
	f.title,
	i.inventory_id
FROM
	film f
INNER JOIN inventory i
		USING (film_id)
LEFT JOIN rental r
		USING (inventory_id)
WHERE
	r.inventory_id IS NULL;
-- Generate a report with: customer (first, last) name, store id, film title, 

-- when the film was rented and returned for each of these customers. Order by store_id, customer last_name
 SELECT
	CONCAT(c.last_name, ' ', c.first_name) as name,
	i.store_id,
	f.title,
	r.rental_date,
	r.return_date
FROM
	customer c
INNER JOIN rental r
		USING (customer_id)
INNER JOIN inventory i
		USING (inventory_id)
INNER JOIN film f
		USING (film_id)
ORDER BY
	i.store_id,
	c.last_name
	-- Show sales per store (money of rented films)
	-- show store's city, country, manager info and total sales (money)

-- (optional) Use concat to show city and country and manager first and last name
 SELECT
	s.store_id,
	CONCAT(ci.city, ", ", co.country) as location,
	CONCAT(m.first_name, " ", m.last_name) as manager,
	sum(amount) as sales
FROM
	store s
INNER JOIN address
		USING (address_id)
INNER JOIN city ci
		USING (city_id)
INNER JOIN country co
		USING (country_id)
INNER JOIN staff m ON
	s.manager_staff_id = m.staff_id
INNER JOIN payment
		USING (staff_id)
GROUP BY
	s.store_id;
-- Which actor has appeared in the most films?
 SELECT
	a.actor_id,
	a.first_name,
	a.last_name,
	COUNT(fa.film_id) AS peliculas_actuadas
FROM
	actor a
INNER JOIN film_actor fa
		USING (actor_id)
GROUP BY
	a.actor_id
HAVING
	peliculas_actuadas >= ALL(
	SELECT
		COUNT(film_id)
	FROM
		film_actor
	GROUP BY
		actor_id);
