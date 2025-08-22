-- DATA TYPES:


-- VARCHR - UNEQUAL LENGTH
-- CHAR - EQUAL LENGTH (ISR | ITA | USA | MEX):

-- EXAMPLE FOR CHAR : STATES , ZIPCODES , Y OR N OTHERWISE VARCHAR

CREATE TABLE states (ticker CHAR(3));

INSERT INTO states (ticker) 
VALUES 
    ('USA'), ('ITA'), ('GER'), ('ISR'), ('BRA'), ('GBR'),
    ('MEX'), ('FRA'), ('NED'), ('BEL'), ('ESP'), ('CAN'),
    ('CA'), ('IND')
    ;
-- 'CA' is aqctually stored as 'CA ' for 3 bytes instead of 2

DESC states;

-- ---------------------------------------

-- INT TYPES: 
--   how large my integer can be? INT MAX IS 2,147,483,647. BIGINT takes mor
-- TINYINT can take up to 127 - better for counting children for example or age


CREATE TABLE household (children TINYINT UNSIGNED);
# UNSIGNED means no negative values
INSERT INTO household (children)
VALUES 
    (1),(3),(0),(5);
    
    
-- DECIMAL : allow to store real percise numbers (prices, height, weight)

-- DECIMAL(5,2) = up to 5 digits with 2 after decimal - maxed: 999.99


CREATE TABLE products (price DECIMAL(6,2));

INSERT INTO products
VALUES (459.99),
        (112.11),
        (299.99),
        (4.99),
        (5000.01);
        
INSERT INTO products
VALUES (414.9778);
-- this value will be added as leas accurate value 414.98

-- FLOAT & DOUBLE : storing large numbers with less space at some point we will lose percition after decimal point

-- DATES & TIMES:
-- DATE gives 'YYYY-MM-DD'
-- TIME gives 'HH:MM:SS'
-- DTAETIME gives 'YYYY-MM-DD HH:MM:SS'


CREATE TABLE people (
    name VARCHAR(100),
    birthdate DATE,
    birthtime TIME,
    birthdt DATETIME);
    
INSERT INTO people (name, birthdate, birthtime , birthdt)
VALUES
    ('Elton', '2000-12-25', '11:00:00', '2000-12-25 11:00:00'),
    ('Lulu', '1985-04-11', '9:45:10', '1985-04-11 9:45:10'),
    ('Juan', '2020-08-15', '23:59:00', '2020-08-15 23:59:00');
    
    

-- ----------------------------------------


-- CURDATE | CURTIME | NOW


INSERT INTO people (name, birthdate, birthtime , birthdt)
VALUES
    ('Hazel', CURDATE(), CURTIME(), NOW());
    
SELECT * FROM people;

-- ----------------------------------------


SELECT 
    birthdate,
    DAY(birthdate),
    DAYOFWEEK(birthdate),
    DAYOFYEAR(birthdate)
FROM people;

SELECT 
    birthdt,
    MONTH(birthdt),
    MONTHNAME(birthdt)
FROM people;

SELECT 
    birthdt,
    HOUR(birthdt),
    MONTHNAME(birthdt)
FROM people;


-- Formating DATE

# 'April 11 1985' as format

SELECT 
    birthdt,
    DATE_FORMAT(birthdt, '%W: %b %D'),
    DATE_FORMAT(birthdt, '%r')
FROM people;


-- Date Math ---

-- DATEDIFF(DATE1,DATE2)

SELECT 
    birthdt,
    DATEDIFF(CURDATE(),birthdt)
FROM people;


-- DATE_ADD(DATE1, INTERVAL X)

SELECT 
    birthdt,
    DATE_ADD(birthdate,INTERVAL 10 YEAR) AS '10 YEARS OLD AT:'
FROM people;

SELECT 
    birthdate,
    DATE_SUB(birthdate,INTERVAL 6 MONTH) 
FROM people;


-- simple math date:

SELECT NOW() - INTERVAL 18 YEAR;

SELECT 
    name,
    birthdate + INTERVAL 21 YEAR AS '21ST BIRTHDAY'
FROM people;


-- TIMESTAMPS: 'YYYY-MM-DD hh:mm:ss' 
-- takes less memory but narrow range of times (from 1970 to 2038)


SELECT NOW(); # THIS IS A TIMESTAMP 
# TIMESTAMPDIFF | TIMESTAMP_ADD | SUB all the same


-- ----------------------------------

CREATE TABLE captions2 (
    text VARCHAR(150),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);
    
INSERT INTO captions2(text)
VALUES ('Just me chilin with my family');

INSERT INTO captions2(text)
VALUES ('I rock SQL!!');

INSERT INTO captions2(text)
VALUES ('easy AF');


UPDATE captions2 SET text = 'very easy (Language!)'
WHERE text = 'easy AF';

SELECT * FROM captions2;

-- --------------------------------------------------


-- Exercise :

#1. what is a good use for char or varchar

-- CHAR good for tickers of countries and stocks where there's a few charecters, saving memory
-- VARCHAR good for text that varies by length like names, adress etc

#2. fiil the blanks types ( item_name__________, price___<1000000_____, quantity_______)

-- item_name VARCHAR(100), price DECIMAL(7,2), quantity INT 

#3. whats the diff between datetime and timestamp

-- timestamp more efficient in terms of memory but has narrow range of time stamps.
-- both look the same in terms of format

#4. print out current time

SELECT CURTIME();

#5. print out current date

SELECT CURDATE();

#6. print out the current day of the week (name)

SELECT DATE_FORMAT(CURDATE(), '%W');

#7. print current day and time using those formats: 
    # mm/dd/yyyy
    
# https://www.w3schools.com/mysql/func_mysql_date_format.asp
    
SELECT DATE_FORMAT(CURDATE(), '%d/%m/%Y');

    # January 2nd at 3:15 (24 hours time)
    
SELECT DATE_FORMAT(NOW(), '%M %D at %k:%i');

#8. create table tweets (180char), user_name, created_time

CREATE TABLE tweets (
    text VARCHAR(180),
    user_name VARCHAR(30),
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
    
INSERT INTO tweets (text, user_name) VALUES('this is my first tweet', 'coltscat');
SELECT * FROM tweets;
 
INSERT INTO tweets (text, user_name) VALUES('this is my second tweet', 'coltscat');
SELECT * FROM tweets;
