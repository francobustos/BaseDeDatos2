-- Find the films with less duration, show the title and rating.
SELECT title, rating
FROM film 
WHERE `length` <= ALL (SELECT `length` FROM film);

-- Write a query that returns the tiltle of the film which duration is the lowest. If there are more than one film with the lowest durtation, the query returns an empty resultset.
SELECT f.title, f.rating
FROM film f 
WHERE f.`length` < ALL (SELECT `length` FROM film f1 WHERE f.film_id <> f1.film_id );

-- Generate a report with list of customers showing the lowest payments done by each of them. Show customer information, the address and the lowest amount, provide both solution using ALL and/or ANY and MIN.
SELECT c.first_name, c.last_name, a.address, 
(SELECT DISTINCT p.amount FROM payment p WHERE p.customer_id = c.customer_id 
AND p.amount <= ALL (SELECT amount FROM payment p2 WHERE p2.customer_id = c.customer_id )) AS min_amount 
 FROM customer c, address a WHERE c.address_id = a.address_id ORDER BY 1,2;

SELECT c.first_name, c.last_name, a.address, 
(SELECT MIN(p.amount) FROM payment p WHERE p.customer_id = c.customer_id) AS min_amount 
 FROM customer c, address a WHERE c.address_id = a.address_id ORDER BY 1,2;

-- Generate a report that shows the customer's information with the highest payment and the lowest payment in the same row.
SELECT c.first_name, c.last_name, a.address, 
(SELECT MIN(p.amount) FROM payment p WHERE p.customer_id = c.customer_id) AS min_amount,
(SELECT MAX(p.amount) FROM payment p WHERE p.customer_id = c.customer_id) AS max_amount
 FROM customer c, address a WHERE c.address_id = a.address_id ORDER BY 1,2;








 
