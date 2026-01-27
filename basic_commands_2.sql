USE sakila;
SELECT * FROM actor;
SELECT first_name, last_name FROM actor;
SELECT * FROM actor
WHERE first_name = 'PENELOPE';

SELECT * FROM actor
WHERE first_name LIKE 'A%';

SELECT * FROM actor
WHERE first_name LIKE '%A%';

SELECT COUNT(*) FROM actor;

/*
it gives number count of whole coloumn like how many rows are there in that column
*/

SELECT DISTINCT first_name FROM actor;
SELECT COUNT(DISTINCT first_name) FROM actor;

/*Shows me all the different first names, but don’t repeat any name.
Looks at first_name—Removes duplicates—Shows each name only once
How many different first names are there in total
*/

SELECT * FROM film;
SELECT film_id, title, rating, length FROM film
WHERE rating = 'PG';

SELECT * FROM film
WHERE rating = 'PG'
AND length > 100;

SELECT title, length
FROM film
ORDER BY length DESC
LIMIT 5;
/*
Order by is like putting things in order like tallest to shortest ,smallest to bigrest A-Zorz-a
for this order we can  use ASC or DESC for the order
Limit is like how many it shoyuld show like in this case it should show 5 we can decide how many rows it should show 
first order by comes then comes the limit 
ORDER BY = Line up properly
LIMIT = Stop after some
*/
SELECT * FROM film
WHERE rating = 'PG'
OR rating = 'G'
OR rating <> 'PG';

SELECT customer_id, COUNT(*)
FROM rental
GROUP BY customer_id
HAVING COUNT(*) > 30;

/*
AND = both must be true
OR = only one must be true
GROUP BY = put same things together
HAVING = keep only big groups
FROM rental
→ Reads all rental records.
GROUP BY customer_id
→ Groups all rentals for each customer.
COUNT(*)
→ Counts how many rentals each customer made.
HAVING COUNT(*) > 30
→ Filters the grouped data and keeps only customers
who made more than 30 rentals.
Use WHERE to filter records first, and HAVING to filter aggregated results.





