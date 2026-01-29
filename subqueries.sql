USE sakila;
-- Find actors whose last name length is greater than the average last name length.
/* here i need to find the avg last name length 
actors  whose salary is greater than avg 
actors
*/

SELECT first_name,last_name,actor_id FROM actor 
WHERE LENGTH(last_name)>(SELECT AVG(LENGTH(last_name)) FROM actor);

-- Find the film(s) with the maximum rental_rate
--  here i have to find MAX(rental_rate) for the film 

SELECT rental_rate,title FROM film
WHERE rental_rate =(SELECT MAX(rental_rate) FROM film);

-- Find customers who have made at least one payment.
-- here we have to find one payment for customers 

SELECT first_name,last_name,customer_id FROM customer 
WHERE customer_id IN (SELECT customer_id FROM payment);

SELECT customer_id, first_name, last_name
FROM customer c
WHERE EXISTS (
    SELECT 1
    FROM payment p
    WHERE p.customer_id = c.customer_id
);

-- Find customers who have never made a payment.
SELECT first_name,last_name,customer_id FROM customer 
WHERE customer_id NOT IN (SELECT customer_id FROM payment);

SELECT customer_id, first_name, last_name
FROM customer c
WHERE NOT EXISTS (
    SELECT 1
    FROM payment p
    WHERE p.customer_id = c.customer_id
);

-- Find customers who have rented at least one film.
SELECT first_name,last_name,customer_id FROM customer 
WHERE customer_id IN (SELECT customer_id FROM rental);

-- Find films whose total number of rentals is greater than the average rentals per film
/* here rentals and films dont have any common column 
so the only wany is film -inventory -rental
first i need to count rentals per film 
calculate avg ,retun only film whose count is greater than avg 
*/
SELECT f.film_id, f.title
FROM film f
WHERE f.film_id IN (
    SELECT i.film_id
    FROM inventory i
    JOIN rental r
        ON r.inventory_id = i.inventory_id
    GROUP BY i.film_id
    HAVING COUNT(r.rental_id) >
        (SELECT AVG(rental_count)
            FROM (
SELECT COUNT(r2.rental_id) AS rental_count-- one row per film
										-- Each row = total rentals for that film
                FROM inventory i2
                JOIN rental r2
                    ON r2.inventory_id = i2.inventory_id
                GROUP BY i2.film_id
            ) avg_table
        )
);
