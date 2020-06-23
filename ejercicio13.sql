-- Add a new customer, To store 1, For address use an existing address. The one that has the biggest address_id in 'United States'
INSERT INTO customer (store_id, first_name, last_name, address_id, create_date)
SELECT 1 as 'store_id','New' as 'first_name','Customer' as 'last_name',MAX(a.address_id) as 'addres_id', CURRENT_TIMESTAMP as 'create_date' 
FROM customer
JOIN address a USING (address_id)
JOIN city USING (city_id)
JOIN country c USING (country_id)
WHERE c.country = 'United States';

-- Add a rental
INSERT INTO sakila.rental
(rental_date, inventory_id, customer_id, staff_id)
SELECT CURRENT_TIMESTAMP as 'rental_date', max(inventory_id), max(customer_id), staff_id 
FROM rental r
JOIN inventory USING(inventory_id)
JOIN film f USING(film_id)
JOIN staff s USING(staff_id)
WHERE f.title = 'ACADEMY DINOSAUR'
AND s.store_id = 2
GROUP BY 1,4;

-- Update film year based on the rating
UPDATE film
SET release_year = 2015
WHERE rating = 'PG';

UPDATE film
SET release_year = 2016
WHERE rating = 'G';

UPDATE film
SET release_year = 2017
WHERE rating = 'NC-17';

UPDATE film
SET release_year = 2018
WHERE rating = 'PG-13';

UPDATE film
SET release_year = 2020
WHERE rating = 'R';

-- Return a film
UPDATE rental
SET return_date = CURRENT_TIMESTAMP
WHERE rental_id IN
(SELECT MAX(rental_id) 
FROM (SELECT * FROM rental) as a
WHERE return_date IS NULL);

-- Try to delete a film
-- No se podra eliminar hasta que id no este relacionado a ningun otra tabla
-- Pide eliminarlo de film_actor y film_category
DELETE film_actor, film_category
FROM film
INNER JOIN film_actor USING (film_id)
INNER JOIN film_category USING (film_id)
WHERE film_id = 1;
-- Y de inventario, aca es mas complejo porque inventario a su vez tiene relacion con rentas, se tendra que eliminar esta relacion
DELETE FROM rental
WHERE inventory_id IN (SELECT inventory_id FROM inventory WHERE film_id = 1)

DELETE FROM inventory 
WHERE film_id = 1;
-- Una vez hecho, se podrá eliminar
DELETE FROM film
WHERE film_id = 1;

-- Rent a film
-- Find an inventory id that is available for rent (available in store) pick any movie. Save this id somewhere. inventory id = 4581
SELECT MAX(i.inventory_id)
FROM inventory i
INNER JOIN rental USING (inventory_id)
WHERE inventory_id NOT IN (SELECT inventory_id FROM rental WHERE return_date IS NULL);

-- Add a rental entry
INSERT INTO rental
(inventory_id, customer_id, staff_id, rental_date)
SELECT 4581 as inventory_id, MAX(customer_id), MIN(staff_id), 
(SELECT rental_date FROM rental WHERE rental_id = (SELECT MAX(rental_id) FROM rental)) as rental_date
FROM rental;

-- Add a payment entry
INSERT INTO payment
(customer_id, staff_id, rental_id, amount, payment_date)
SELECT (SELECT MIN(customer_id) FROM customer WHERE first_name LIKE 'FRANK%') as customer_id,
(SELECT MAX(staff_id) FROM staff) as staff_id,
rental_id,
(SELECT AVG(amount) FROM payment) as amount,
(SELECT rental_date FROM rental WHERE rental_id = 4581) as payment_date
FROM rental
WHERE rental_id = 4581;









