# Classes
Assignment 1
USE sakila;

SELECT*FROM customer
WHERE first_name LIKE 'J%' AND active = 1;

SELECT*FROM film
WHERE description LIKE '%WAR%' OR title LIKE '%ACTION%';

SELECT*FROM customer
WHERE last_name LIKE '%a' AND last_name <> 'SMITH';

SELECT*FROM film
WHERE rental_rate > '3' AND replacement_cost IS NOT NULL;

SELECT store_id, COUNT(*) FROM customer
WHERE active = 1
GROUP BY store_id;

SELECT DISTINCT rating FROM film;

SELECT rental_duration, COUNT(*) FROM film
GROUP BY rental_duration
HAVING AVG(length) > 100;

SELECT DATE(payment_date),SUM(amount) FROM payment
GROUP BY DATE(payment_date)
HAVING COUNT(*) > 100;

SELECT*FROM customer
WHERE email LIKE '%.org' or email IS NULL;

SELECT*FROM film
WHERE rating LIKE 'PG' or rating LIKE 'G'
ORDER BY rental_rate DESC;

SELECT length, COUNT(*)FROM film
WHERE title LIKE 'T%'
GROUP BY length
HAVING COUNT(*) > 5;
/* SELECT length, COUNT(*)FROM film
GROUP BY length;*/

SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS film_count
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
HAVING COUNT(fa.film_id) > 10;

SELECT * FROM film
ORDER BY rental_rate DESC, length DESC
LIMIT 5;

SELECT c.customer_id,
       c.first_name,
       c.last_name,
       COUNT(r.rental_id) AS total_rentals
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_rentals DESC;

SELECT f.title
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.rental_id IS NULL;
