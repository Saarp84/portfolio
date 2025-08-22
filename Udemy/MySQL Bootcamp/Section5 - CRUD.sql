-- *********** SECTION 5 ********** --
-- Create Read Update Delete (CRUD) --


DROP TABLE cats;

CREATE TABLE cats(
    cat_id INT AUTO_INCREMENT,
    name VARCHAR(100),
    breed VARCHAR(100),
    age INT,
    PRIMARY KEY (cat_id)
    );
    
INSERT INTO cats(name, breed, age) 
VALUES ('Ringo', 'Tabby', 4),
       ('Cindy', 'Maine Coon', 10),
       ('Dumbledore', 'Maine Coon', 11),
       ('Egg', 'Persian', 4),
       ('Misty', 'Tabby', 13),
       ('George Michael', 'Ragdoll', 9),
       ('Jackson', 'Sphynx', 7);
    
    

SELECT name,age FROM cats;


SELECT name FROM cats 
WHERE age=4 ;


-- Exercise: --------------

SELECT cat_id FROM cats;

SELECT name,breed FROM cats ;

SELECT name,age FROM cats
WHERE breed='Tabby';

SELECT cat_id,age FROM cats 
WHERE cat_id=age;

-- ------------------------

-- Aliases:

SELECT cat_id AS id, name FROM cats 


-- Update: change data in a row

-- UPDATE cats SET breed='Shorthair'
-- WHERE breed='Tabby';


-- UPDATE employees SET current_status='laid-off' , last_name = 'Unknown'

SELECT * FROM cats 
WHERE name='Misty'

UPDATE cats SET age=14
WHERE name='Misty'

-- ---------------------------------
# RULE OF THUMB !
# before updating or deleting try selecting first for avoiding mistakes...
-- ----------------------------------


-- Update Exercise:

# change Jacksons's name to Jack
SELECT * FROM cats
-- UPDATE cats SET name='Jack'
WHERE name='Jack';


# change ringo's breed to be british shorthair
SELECT * FROM cats
-- UPDATE cats SET breed='British Shorthair'
WHERE name='Ringo';


# change the Maine Coons cats to be aged 12
SELECT * FROM cats
-- UPDATE cats SET age=12
WHERE breed='Maine Coon';

-- ----------------------------------

-- Delete:

-- deleting all table : DELETE FROM cats;

-- DELETE FROM cats WHERE name='Egg';


-- delete all 4 years old cats

-- SELECT * FROM cats WHERE age=4;
DELETE FROM cats WHERE age=4;

-- delete age=cat_id

-- SELECT * FROM cats WHERE age=cat_id;
DELETE FROM cats WHERE age=cat_id;

-- delete all cats

-- SELECT * FROM cats;
DELETE FROM cats;
