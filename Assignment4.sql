USE sakila;
-- 1
SELECT c.first_name,c.last_name,f.title FROM customer c
JOIN rental r
  ON c.customer_id = r.customer_id
JOIN inventory i
  ON r.inventory_id = i.inventory_id
JOIN film f
  ON i.film_id = f.film_id
ORDER BY c.customer_id, f.title;
-- 2 
SELECT c.customer_id,c.first_name,c.last_name,
       COUNT(r.rental_id) AS rental_count
FROM customer c
LEFT JOIN rental r
  ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY c.customer_id;
-- 3
SELECT f.title,
       c.name AS category
FROM film f
LEFT JOIN film_category fc
  ON f.film_id = fc.film_id
LEFT JOIN category c
  ON fc.category_id = c.category_id
ORDER BY f.title;
-- 4 
SELECT c.first_name,c.last_name,c.email
FROM customer c
LEFT JOIN staff s
  ON c.email = s.email
UNION
SELECT s.first_name,s.last_name,s.email
FROM customer c
RIGHT JOIN staff s
  ON c.email = s.email;
-- 5   
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa
  ON a.actor_id = fa.actor_id
JOIN film f
  ON fa.film_id = f.film_id
WHERE f.title = 'ACADEMY DINOSAUR';
-- 6 
SELECT st.store_id,
       COUNT(sf.staff_id) AS total_staff
FROM store st
LEFT JOIN staff sf
  ON st.store_id = sf.store_id
GROUP BY st.store_id
ORDER BY st.store_id;
-- 7
SELECT c.first_name,c.last_name,
       COUNT(r.rental_id) AS total_rentals
FROM customer c
JOIN rental r
  ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(r.rental_id) > 5;




