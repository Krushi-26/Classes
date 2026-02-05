USE sakila;
-- 1. Identify if there are duplicates in Customer table. Don't use customer id to check the duplicates
SELECT SUM(REGEXP_COUNT(LOWER(description), 'a')) AS total_a_count
FROM film;
-- 
SELECT SUM(LENGTH(description) - LENGTH(REPLACE(LOWER(description), 'a', '')))
AS total_a_count FROM film;
-- find length,then i removed all thhe letters a ,measure again then -
-- length is to find string lenth
-- replace is toremove char
-- lower is used for case sensitive counting where it converts the whole description to lower case
-- '' replace with nothing
SELECT
    SUM(LENGTH(description) - LENGTH(REPLACE(LOWER(description), 'a', ''))) AS a_count,
    SUM(LENGTH(description) - LENGTH(REPLACE(LOWER(description), 'e', ''))) AS e_count,
    SUM(LENGTH(description) - LENGTH(REPLACE(LOWER(description), 'i', ''))) AS i_count,
    SUM(LENGTH(description) - LENGTH(REPLACE(LOWER(description), 'o', ''))) AS o_count,
    SUM(LENGTH(description) - LENGTH(REPLACE(LOWER(description), 'u', ''))) AS u_count
FROM film;
-- 4. Display the payments made by each customer
       --  1. Month wise
        -- 2. Year wise
        -- 3. Week wise
SELECT customer_id,
    MONTH(payment_date) AS month,
    YEAR(payment_date) AS year,
    SUM(amount) AS total_amount
FROM payment
GROUP BY customer_id, YEAR(payment_date), MONTH(payment_date);
/* seperate the payment by year where same months can be in diff year 
groups payments inside each year by mnth 
then add all 
then group by */

SELECT 
    customer_id,
    YEAR(payment_date) AS year,
    SUM(amount) AS total_amount
FROM payment
GROUP BY customer_id, YEAR(payment_date);

SELECT 
    customer_id,
    YEAR(payment_date) AS year,
    WEEK(payment_date) AS week,
    SUM(amount) AS total_amount
FROM payment
GROUP BY customer_id, YEAR(payment_date), WEEK(payment_date);

-- Display number of days remaining in the current year from today.
SELECT 
    DATEDIFF(CONCAT('2026-12-31'),CURDATE());

SELECT 
    payment_id,
    payment_date,
    CONCAT('Q', QUARTER(payment_date)) AS quarter
FROM payment;
-- Display quarter number(Q1,Q2,Q3,Q4) for the payment dates from payment table.
SELECT payment_date,
  CONCAT('Q', QUARTER(payment_date)) AS quarter
FROM payment;



