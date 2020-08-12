/*
Create a view named list_of_customers, it should contain the following columns:
customer id
customer full name,
address
zip code
phone
city
country
status (when active column is 1 show it as 'active', otherwise is 'inactive')
store id
*/
CREATE OR REPLACE VIEW list_of_customers AS
SELECT c.customer_id, CONCAT(first_name, ' ', last_name) as 'full_name', a.address, a.postal_code, a.phone, city, country, c.active, c.store_id
FROM customer c 
JOIN address a USING (address_id)
JOIN city USING (city_id)
JOIN country USING (country_id);

/*Create a view named film_details, it should contain the following columns: 
film id, title, description, category, price, length, rating, actors - as a string of all the actors separated by comma. 
Hint use GROUP_CONCAT*/
CREATE OR REPLACE VIEW film_details AS
SELECT f.film_id, f.title, f.description, c.name, f.replacement_cost, f.`length`, f.rating, 
GROUP_CONCAT(CONCAT(a.first_name, ' ', a.last_name)) AS 'actors'
FROM film f
JOIN film_category USING (film_id)
JOIN category c USING (category_id)
JOIN film_actor USING (film_id)
JOIN actor a USING (actor_id)
GROUP BY film_id, c.name;

-- Create view sales_by_film_category, it should return 'category' and 'total_rental' columns.
CREATE OR REPLACE VIEW sales_by_film_category AS
SELECT c.name as 'category', COUNT(r.rental_id) as 'total_rental'
FROM category c 
JOIN film_category USING (category_id)
JOIN inventory USING (film_id)
JOIN rental r USING (inventory_id)
GROUP BY 1;



