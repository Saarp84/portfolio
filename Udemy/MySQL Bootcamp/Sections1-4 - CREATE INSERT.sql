SHOW DATABASES;
-- CREATE DATABASE workshop;
-- DROP DATABASE workshop;

DROP TABLE cats;


-- יצירת טבלאות בתוך דאטה בייס
CREATE TABLE cats 
(
    name VARCHAR(50),
    age INT

);

CREATE TABLE dogs 
(
    name VARCHAR(50),
    age INT,
    type VARCHAR(50),
    owner VARCHAR(100)
);
-- SHOW TABLES;

-- מראה את העמודות וסוג הערכים לכל עמודה 
-- DESC dogs;
-- SHOW COLUMNS FROM cats;


-- מחיקת טבלה
-- צריך להיזהר כדי לא לאבד מידע !
-- DROP TABLE cats;

-- CREATE TABLE pastries 
-- (   
--     name VARCHAR(50),
--     quantity INT
-- );

-- DROP TABLE pastries;



-- insert data (section 4):

-- INSERT INTO cats (name, age) 
-- VALUES ('Blue Steele', 5);   

-- INSERT INTO cats (name, age) 
-- VALUES ('Jenkins', 7);

INSERT INTO cats (name, age) 
VALUES 
  ('Meatball', 5), 
  ('Turkey', 1), 
  ('Potato Face', 15);
        
SELECT * FROM cats;


-- Insert Excercise:

-- CREATE TABLE people 
-- (   
--     first_name VARCHAR(20),
--     last_name VARCHAR(20),
--     age INT
-- );

-- INSERT INTO people (first_name, last_name, age)
-- VALUES
--     ('Tina','Belcher',13);
    
-- INSERT INTO people (first_name, last_name, age)
-- VALUES
--     ('Bob','Belcher',42);
    
-- INSERT INTO people (first_name, last_name, age)
-- VALUES
--     ('Linda','Belcher',45),
--     ('Phillip','Frond',38),
--     ('Clavin','Fischoeder',70);
    
-- DROP TABLE people;

    
-- NULLing
INSERT INTO cats() VALUES();

CREATE TABLE cats2 
(
    name VARCHAR(50) NOT NULL,
    age INT NOT NULL

);
# ERROR with inserting NULLs
INSERT INTO cats2() VALUES();

INSERT INTO cats2(name,age) 
VALUES('Bilbo',19);


DESC cats2;





-- \'
-- VALUES  ('shoe emporium'),
--         ('mario\'s pizza');


-- SET DEFAULT VALUES (opposite of null?)
CREATE TABLE cats3 (
    name VARCHAR(50) DEFAULT 'unnamed',
    age INT DEFAULT 99)
    
INSERT INTO cats3(age) 
VALUES(50)

# using both not null and default value not allowing me to use NULL manually only by inserting empty values

CREATE TABLE cats4  (    
    name VARCHAR(20) NOT NULL DEFAULT 'unnamed',    
    age INT NOT NULL DEFAULT 99 
);


-- KEY? adding uinque value to each row:


CREATE TABLE unique_cats  ( 
    cat_id INT NOT NULL PRIMARY KEY,
    name VARCHAR(20) NOT NULL DEFAULT 'unnamed',    
    age INT NOT NULL DEFAULT 99 
);
-- OR:

-- CREATE TABLE unique_cats  ( 
--     cat_id INT NOT NULL ,
--     name VARCHAR(20) NOT NULL DEFAULT 'unnamed',    
--     age INT NOT NULL DEFAULT 99 ,
--     PRIMARY KEY(cats_id)
-- );

INSERT INTO unique_cats (cat_id, name, age)
VALUE (1,"Bilbo",3),(2,"Bongo",5);



        