USE sakila;

-- 1
SELECT * FROM customer
WHERE customer_id IN (SELECT customer_id FROM payment
    GROUP BY customer_id
    HAVING COUNT(payment_id) > 5);

-- 2
SELECT first_name, last_name FROM actor
WHERE actor_id IN (
    select actor_id
    FROM film_actor
    GROUP BY actor_id
    HAVING COUNT(film_id) > 10
);

-- 3
SELECT first_name, last_name FROM customer c
WHERE NOT EXISTS (
    SELECT * FROM payment p
    WHERE p.customer_id = c.customer_id
);
-- 4
SELECT title, rental_rate
FROM film
WHERE rental_rate > (
    SELECT AVG(rental_rate)
    FROM film
);
-- 5
SELECT title
FROM film
WHERE film_id NOT IN (
    SELECT DISTINCT i.film_id
    FROM inventory i, rental r
    WHERE i.inventory_id = r.inventory_id
);

-- 8 
SELECT title, rental_duration
FROM film
WHERE rental_duration > (
    SELECT AVG(rental_duration)
    FROM film
);
-- 9
SELECT first_name, last_name
FROM customer
WHERE address_id = (
    SELECT c1.address_id
    FROM customer c1
    WHERE customer_id = 1
);
-- 10
SELECT *
FROM payment
WHERE amount > (
    SELECT AVG(amount)
    FROM payment
);
-- 6
select c.first_name,c.last_name 
from customer c
WHERE c.customer_id IN (SELECT r.customer_id 
                        from rental r
						WHERE (year(r.rental_date),month(r.rental_date) )
												IN 
                        (select year(r5.rental_date),month(r5.rental_date)
                        from rental r5));

-- 7 

SELECT DISTINCT first_name, last_name, staff_id
FROM staff
WHERE staff_id IN (SELECT staff_id FROM payment
                   WHERE amount > (SELECT AVG(amount)FROM payment));
