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

/*
Create a view called actor_information where it should return, 
actor id, 
first name, 
last name and 
the amount of films he/she acted on.
*/
CREATE OR REPLACE VIEW actor_information AS
SELECT actor_id, first_name, last_name, COUNT(film_id) AS 'films_acted'
FROM actor
JOIN film_actor USING (actor_id)
GROUP BY 1;


/*
Analyze view actor_info, explain the entire query and specially how the sub query works. 
Be very specific, take some time and decompose each part and give an explanation for each.
*/

/*CREATE OR REPLACE crea la view
ALGORITHM = UNDEFINED VIEW `actor_info` AS la llama actor_film
select
    `a`.`actor_id` AS `actor_id`, muestra el id del actor
    `a`.`first_name` AS `first_name`, muestra el nombre del actor
    `a`.`last_name` AS `last_name`, muestra el apellido del actor
    group_concat(distinct concat(`c`.`name`, ': ',(select group_concat(`f`.`title` order by `f`.`title` ASC separator ', ') 
    												from ((`film` `f` join `film_category` `fc` on((`f`.`film_id` = `fc`.`film_id`))) 
    												join `film_actor` `fa` on((`f`.`film_id` = `fa`.`film_id`))) 
    												where ((`fc`.`category_id` = `c`.`category_id`) and (`fa`.`actor_id` = `a`.`actor_id`))))
order by
    `c`.`name` ASC separator '; ') AS `film_info`  Muestra las peliculas en las que trabajo el actor con su correspondiente categoria
from
    (((`actor` `a`
left join `film_actor` `fa` on
    ((`a`.`actor_id` = `fa`.`actor_id`)))
left join `film_category` `fc` on
    ((`fa`.`film_id` = `fc`.`film_id`)))
left join `category` `c` on
    ((`fc`.`category_id` = `c`.`category_id`))) Une al actor con su correspondiente pelicula y categoria
group by
    `a`.`actor_id`,
    `a`.`first_name`,
    `a`.`last_name`;*/

-- Materialized views, write a description, why they are used, alternatives, DBMS were they exist, etc
-- No entendi

