-- List all the actors that share the last name. Show them in order
SELECT first_name, last_name 
FROM actor a
where EXISTS (SELECT last_name 
				FROM actor a1 
				where a.last_name = a1.last_name
				and a.actor_id <> a1.actor_id)
ORDER BY 2;

-- Find actors that don't work in any film
SELECT first_name, last_name
FROM actor a
where not EXISTS (select fa.actor_id
					from film_actor fa
					where fa.actor_id = a.actor_id);
					
-- Find customers that rented only one film
SELECT first_name, last_name
FROM customer c
where (SELECT count(*)  
		from rental r
		where r.customer_id = c.customer_id)=1;

-- Find customers that rented more than one film
SELECT first_name, last_name  
FROM customer c
where (SELECT count(*)  
		from rental r
		where r.customer_id = c.customer_id)>1;

-- List the actors that acted in 'BETRAYED REAR' or in 'CATCH AMISTAD'
SELECT DISTINCT a.first_name, a.last_name
FROM actor a, film f, film_actor fa 
where a.actor_id = fa.actor_id and f.film_id = fa.film_id and f.title in ('BETRAYED REAR','CATCH AMISTAD');

-- List the actors that acted in 'BETRAYED REAR' but not in 'CATCH AMISTAD'
SELECT DISTINCT a.first_name, a.last_name
FROM actor a, film f, film_actor fa 
where a.actor_id = fa.actor_id and f.film_id = fa.film_id and f.title in ('BETRAYED REAR') and
a.actor_id not in (select a2.actor_id 
					FROM actor a2, film f2, film_actor fa2 
					where a2.actor_id = fa2.actor_id and f2.film_id = fa2.film_id and f2.title = 'CATCH AMISTAD');

-- List the actors that acted in both 'BETRAYED REAR' and 'CATCH AMISTAD'
SELECT DISTINCT a.first_name, a.last_name
FROM actor a
where a.actor_id in (SELECT a2.actor_id
						FROM actor a2, film f2, film_actor fa2
						where a2.actor_id = fa2.actor_id and f2.film_id = fa2.film_id and f2.title = 'BETRAYED REAR')
and a.actor_id  in (SELECT a2.actor_id
						FROM actor a2, film f2, film_actor fa2
						where a2.actor_id = fa2.actor_id and f2.film_id = fa2.film_id and f2.title = 'CATCH AMISTAD'); 
					

-- List all the actors that didn't work in 'BETRAYED REAR' or 'CATCH AMISTAD'
SELECT DISTINCT a.first_name, a.last_name
FROM actor a
where a.actor_id not in (SELECT a2.actor_id
						FROM actor a2, film f2, film_actor fa2
						where a2.actor_id = fa2.actor_id and f2.film_id = fa2.film_id and f2.title = 'BETRAYED REAR')
and a.actor_id  not in (SELECT a2.actor_id
						FROM actor a2, film f2, film_actor fa2
						where a2.actor_id = fa2.actor_id and f2.film_id = fa2.film_id and f2.title = 'CATCH AMISTAD'); 






