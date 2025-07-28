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




