-- VIEWS:

SELECT 
    title, released_year, genre, rating, first_name, last_name
FROM
    reviews
        JOIN
    series ON series.id = reviews.series_id
        JOIN
    reviewers ON reviewers.id = reviews.reviewer_id;
 
-- WE CAN CREATE A VIEW:
CREATE VIEW full_reviews AS
SELECT title, released_year, genre, rating, first_name, last_name FROM reviews
JOIN series ON series.id = reviews.series_id
JOIN reviewers ON reviewers.id = reviews.reviewer_id;
 
-- NOW WE CAN TREAT THAT VIEW AS A VIRTUAL TABLE 
-- (AT LEAST WHEN IT COMES TO SELECTING)
SELECT * FROM full_reviews;

-- IN A REGULAR TABLE : DELETE FROM full_reviews WHERE ....
-- HERE WE CANNOT BECAUSE OF THE JOINS OR OTHER SUBQUERINGS

-- HOW ACTUALLY TO ALTER:
CREATE OR REPLACE full_reviews AS
SELECT title, released_year, genre, rating, first_name #, last_name
FROM reviews
JOIN series ON series.id = reviews.series_id
JOIN reviewers ON reviewers.id = reviews.reviewer_id;

-- ALTER VIEW full_reviews...
-- DROP VIEW full_revies....


-- HAVING = FILTERING THE GROUP BY

SELECT title,
    AVG(rating),
    COUNT(rating)
FROM full_reviews
GROUP BY title HAVING COUNT(rating)>2;


-- WITH ROLLUP = NEW LINE WITH summary stats for ENTIRE HIERARCHY

SELECT title,
    AVG(rating), 
    COUNT(rating)
FROM full_reviews
GROUP BY title WITH ROLLUP;

SELECT genre,released_year,
    AVG(rating) 
FROM full_reviews
GROUP BY genre,released_year WITH ROLLUP;


-- MODES

SELECT @@GLOBAL.sql_mode;
SELECT @@SESSION.sql_mode;
# SET SESSION sql_mode = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,
#                       ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION'
                        
# the mosr important mode:
# STRICT_TRANS_TABLES - if i turn it off i can insert 'hi' as rate
#SET SESSION sql_mode = '';
