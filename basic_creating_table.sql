
CREATE DATABASE IF NOT EXISTS practice_db;
USE practice_db;
CREATE TABLE persons (
    id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    age INT CHECK (age >= 18),
    city VARCHAR(50) DEFAULT 'india'
);
SHOW TABLES;
INSERT INTO persons (id, first_name, last_name, age, city)
VALUES (5, 'Krushi', 'N', 26, 'Kansas');
INSERT INTO persons (id, first_name, last_name, age)
VALUES (2, 'Varshini', 'gang', 28);

SELECT * FROM persons;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    person_id INT,
    FOREIGN KEY (person_id)
        REFERENCES persons(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);
INSERT INTO orders (order_id, order_date, person_id)
VALUES (101, '2025-01-22', 5);
SELECT * FROM orders;
INSERT INTO persons (id, first_name, last_name, age, city)
VALUES (10, 'Krushi', 'N', 26, 'Kansas');
SHOW TABLES;

