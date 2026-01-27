/* STRING FUNCTIONS*/

-- View movie titles
SELECT title
FROM sakila.film;

-- Fixed-width title (centered look using padding)
SELECT 
  title,
  LPAD(RPAD(title, 20, '*'), 25, '*') AS centered_title
FROM sakila.film
LIMIT 5;

-- Substring: first 9 characters
SELECT 
  title,
  SUBSTRING(title, 1, 9) AS short_title
FROM sakila.film;

-- Concatenate first name and last name
SELECT 
  CONCAT(first_name, '.', last_name) AS full_name
FROM sakila.customer;

-- Reverse string
SELECT 
  title,
  REVERSE(title) AS reversed_title
FROM sakila.film
LIMIT 5;

-- Length of title (exactly 8 characters)
SELECT 
  title,
  LENGTH(title) AS title_length
FROM sakila.film
WHERE LENGTH(title) = 8;


/* EMAIL → DOMAIN*/

-- Extract domain from email
SELECT 
  email,
  SUBSTRING(email, LOCATE('@', email) + 1) AS domain
FROM sakila.customer;

-- Extract domain ending (com, org, etc.)
SELECT 
  email,
  SUBSTRING_INDEX(
    SUBSTRING(email, LOCATE('@', email) + 1),
    '.',
    -1
  ) AS domain_end
FROM sakila.customer;


/* UPPER / LOWER / LIKE*/

-- Titles containing LOVE or ending with MAN
SELECT title
FROM sakila.film
WHERE 
  (UPPER(title) LIKE '%LOVE%' OR UPPER(title) LIKE '%MAN');


/*LEFT / RIGHT + GROUP BY*/

-- Group movies by first 2 letters and last 3 letters
SELECT 
  LEFT(title, 2) AS start_letters,
  RIGHT(title, 3) AS end_letters,
  COUNT(*) AS film_count
FROM sakila.film
GROUP BY LEFT(title, 2), RIGHT(title, 3)
ORDER BY film_count DESC;


/* CASE (IF–ELSE)*/

-- Group customers by last name alphabet range
SELECT 
  last_name,
  CASE
    WHEN LEFT(last_name, 1) BETWEEN 'A' AND 'M' THEN 'Group A-M'
    WHEN LEFT(last_name, 1) BETWEEN 'N' AND 'Z' THEN 'Group N-Z'
    ELSE 'Other'
  END AS group_label
FROM sakila.customer;


/* REPLACE*/

-- Replace A with x in titles that contain a space
SELECT 
  title,
  REPLACE(title, 'A', 'x') AS cleaned_title
FROM sakila.film
WHERE title LIKE '% %';


/*REGEX*/

-- Titles ending with a vowel
SELECT title
FROM sakila.film
WHERE title REGEXP '[aeiouAEIOU]$';

-- Count titles ending with each vowel
SELECT 
  RIGHT(title, 1) AS ending_letter,
  COUNT(*) AS count_titles
FROM sakila.film
WHERE title REGEXP '[aeiouAEIOU]$'
GROUP BY RIGHT(title, 1);


/* MATH FUNCTIONS*/

-- Power
SELECT 
  title,
  rental_rate,
  POWER(rental_rate, 2) AS squared_rate
FROM sakila.film;

-- Modulus
SELECT 
  film_id,
  length,
  MOD(length, 60) AS remainder_minutes
FROM sakila.film;

-- Ceil / Floor
SELECT 
  rental_rate,
  CEIL(rental_rate) AS ceil_value,
  FLOOR(rental_rate) AS floor_value
FROM sakila.film;

-- Random numbers
SELECT 
  customer_id,
  FLOOR(RAND() * 100) AS random_score
FROM sakila.customer
LIMIT 5;


/*AGGREGATION*/
-- Total and average payment per customer
SELECT 
  customer_id,
  COUNT(payment_id) AS total_payments,
  SUM(amount) AS total_paid,
  AVG(amount) AS avg_payment
FROM sakila.payment
GROUP BY customer_id;


/* ALTER & UPDATE (SAFE) */

-- Add new column
ALTER TABLE sakila.film
ADD COLUMN cost_efficiency DECIMAL(6,2);

-- Populate new column
UPDATE sakila.film
SET cost_efficiency = rental_duration * 2;


/* DATE FUNCTIONS*/

-- Date difference
SELECT 
  rental_id,
  rental_date,
  return_date,
  DATEDIFF(return_date, rental_date) AS days_rented
FROM sakila.rental
WHERE return_date IS NOT NULL;

-- Day and month name
SELECT 
  last_update,
  DAYNAME(last_update) AS day_name,
  MONTHNAME(last_update) AS month_name
FROM sakila.film;

-- Payments by date
SELECT 
  DATE(payment_date) AS pay_date,
  SUM(amount) AS total_paid
FROM sakila.payment
GROUP BY DATE(payment_date)
ORDER BY pay_date DESC;


/*LAST N DAYS*/

-- Payments in last 7 days
SELECT *
FROM sakila.payment
WHERE payment_date >= NOW() - INTERVAL 7 DAY;

-- Payments relative to latest date in table
SELECT *
FROM sakila.payment
WHERE payment_date >= (
  SELECT MAX(payment_date) - INTERVAL 10 DAY
  FROM sakila.payment
);
/*CASTING*/

-- Cast number to string
SELECT 
  amount,
  CAST(amount AS CHAR) AS amount_str
FROM sakila.payment;

/*SUBQUERY*/

-- Movies with rental rate above average
SELECT title, rental_rate
FROM sakila.film
WHERE rental_rate > (
  SELECT AVG(rental_rate)
  FROM sakila.film
);


/* JOINS (MULTI-TABLE)*/

-- Movie titles with category names
SELECT 
  f.title,
  c.name AS category_name
FROM sakila.film f
JOIN sakila.film_category fc
  ON f.film_id = fc.film_id
JOIN sakila.category c
  ON fc.category_id = c.category_id;


/* LEFT JOIN*/

-- All customers, even if they have no payments
SELECT 
  c.customer_id,
  c.first_name,
  p.amount
FROM sakila.customer c
LEFT JOIN sakila.payment p
  ON c.customer_id = p.customer_id;


/* CTE (WITH)*/

-- Customers who paid more than 100 total
WITH total_payments AS (
  SELECT 
    customer_id,
    SUM(amount) AS total_paid
  FROM sakila.payment
  GROUP BY customer_id
)
SELECT *
FROM total_payments
WHERE total_paid > 100;

