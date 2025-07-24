-- JOINS:

## setting relationships (1:MANY)

CREATE TABLE customers (

    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
);
    
-- INSERT INTO customers (first_name, last_name, email) 
-- VALUES ('Boy', 'George', 'george@gmail.com'),
--       ('George', 'Michael', 'gm@gmail.com'),
--       ('David', 'Bowie', 'david@gmail.com'),
--       ('Blue', 'Steele', 'blue@gmail.com'),
--       ('Bette', 'Davis', 'bette@aol.com');  
       
       
       
 ## adding FOREIGN KEY  -- refrencing the particular table(column) - customer(id):
      
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(id) # ON DELETE CASCADE
);
        
-- INSERT INTO orders (order_date, amount, customer_id)
-- VALUES ('2016-02-10', 99.99, 1),
--       ('2017-11-11', 35.50, 1),
--       ('2014-12-12', 800.67, 2),
--       ('2015-01-03', 12.50, 2),
--       ('1999-04-11', 450.25, 5);


## Working with tHose tables and JOINS:

## STEP 1
SELECT id FROM customers
WHERE last_name='George';
#### get's 1 and:
SELECT * FROM orders 
WHERE customer_id=1;
       
## STEP 2
SELECT * FROM orders 
WHERE customer_id= (SELECT id FROM customers WHERE last_name='George');

## STEP 3 (bad join)

SELECT * FROM customers,orders;

## STEP 4 (INNER JOIN)
SELECT 
    first_name, last_name,
    order_date, amount
FROM customers
JOIN orders
    ON customers.id = orders.customer_id;


-- INVOLVING GROUP BY:

SELECT  first_name,
        last_name,
        SUM(amount) AS total_amount
FROM customers
JOIN orders ON customers.id = orders.customer_id
GROUP BY first_name,last_name
ORDER BY total_amount DESC;



-- LEFT JOIN :

SELECT first_name,
        last_name,
        SUM(amount) AS total_amount
FROM customers
LEFT JOIN orders 
    ON customers.id = orders.customer_id
GROUP BY first_name,last_name
ORDER BY total_amount DESC;

## IFNULL()
SELECT first_name,last_name, 
        IFNULL(SUM(amount),0) AS total_amount 
FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id
GROUP BY first_name,last_name
ORDER BY total_amount DESC;


-- RIGHT JOIN : 
SELECT first_name,last_name, 
        order_date
FROM customers
RIGHT JOIN orders ON customers.id = orders.customer_id
;


-- DELETION: WHAT SHOULD HAPPEND IF WE DELETE ROW DROM customers?

-- foreign key doesnt allow that to happen unless:
-- ACTIVE THIS "ON DELETE CASCADE" -- DELETING ALSO RECORDS FROM ORDERS




-- EXERCISE:

#1. create schema studens (id first_name) and papers (title grade studet_id) + inserting data from colt

CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50)
);

CREATE TABLE papers (
    title VARCHAR(100),
    grade INT CONSTRAINT real_range CHECK(grade<=100 AND grade>=0),
    student_id INT,
    FOREIGN KEY(student_id) REFERENCES students(id) ON DELETE CASCADE
);

INSERT INTO students (first_name) VALUES 
('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa');
 
INSERT INTO papers (student_id, title, grade ) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);

#2. print first_name - title - grade table

SELECT first_name, title, grade
FROM students
JOIN papers ON students.id = papers.student_id;


#3. print first_name - title - grade (including nulls) TABLE

SELECT first_name, title, grade
FROM students
LEFT JOIN papers ON students.id = papers.student_id;

#3. print first_name - title - grade (including zeros instead of null) TABLE

SELECT first_name, title,
    IFNULL(grade,0) AS final_grade
FROM students
LEFT JOIN papers ON students.id = papers.student_id
ORDER BY final_grade DESC;

#4. print first_name and avg grade (with 0 instead of nulls)

SELECT first_name,
        IFNULL(AVG(grade),0) AS average
FROM students
LEFT JOIN papers ON students.id = papers.student_id
GROUP BY first_name
ORDER BY average DESC;


#5. add to 4 one column for passed | failed for above or less than 70


SELECT first_name,
        IFNULL(AVG(grade),0) AS average,
        CASE 
            WHEN IFNULL(AVG(grade),0) >= 70 THEN 'PASSED'
            ELSE 'FAILED'
        END AS status
FROM students
LEFT JOIN papers ON students.id = papers.student_id
GROUP BY first_name
ORDER BY average DESC;


