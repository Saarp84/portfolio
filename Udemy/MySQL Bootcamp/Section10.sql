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






