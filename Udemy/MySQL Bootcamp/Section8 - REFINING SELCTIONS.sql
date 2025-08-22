-- Section 8 - book_shop manipulationg work ----

-- INSERT INTO
--   books (
--     title,
--     author_fname,
--     author_lname,
--     released_year,
--     stock_quantity,
--     pages
--   )
-- VALUES
--   ('10% Happier', 'Dan', 'Harris', 2014, 29, 256),
--   ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
--   (
--     'Lincoln In The Bardo',
--     'George',
--     'Saunders',
--     2017,
--     1000,
--     367
--   );
  
  -- ----------------------------------------
 -- DISTINCT: uniques
 
 SELECT DISTINCT author_lname FROM books;
 
 -- longer:
 SELECT DISTINCT
    CONCAT(author_fname, ' ', author_lname) AS author
 FROM
    books;
-- ------------------------------------------
-- shorter:
 SELECT DISTINCT
    author_fname,author_lname
 FROM
    books;
-- ------------------------------------------

-- ORDER BY:

SELECT DISTINCT
    author_fname, author_lname
FROM
    books
ORDER BY 
    author_lname # DESC;
    ;
-- -----------------------
SELECT
    title, pages
FROM
    books
ORDER BY 
    pages DESC;
    
-- -----------------------------------------
-- ORDER BY COLUMN

SELECT
    title, pages
FROM
    books
ORDER BY 2 DESC;
-- second columns is pages in this case

-- ------------------------------------------

-- OREDER BY MULTIPLE 

SELECT DISTINCT
    author_lname, author_fname, released_year
FROM
    books
ORDER BY 
    author_lname, released_year DESC;
  
-- ORDER BY NON-COLUMN  
SELECT DISTINCT 
    CONCAT(author_fname, ' ',author_lname) AS author
FROM books
ORDER BY author;
    
-- ----------------------------------------------   

-- LIMIT:

SELECT DISTINCT 
    title,
    pages AS top5_longest_books
FROM books
ORDER BY pages DESC
LIMIT 5;

# start from second row and look for "top" 5
SELECT DISTINCT 
    title,
    pages AS top5_longest_books
FROM books
ORDER BY pages DESC
LIMIT 1,5;

-- -----------------------------------------------

-- LIKE:

SELECT
    title, author_fname,author_lname
FROM books
WHERE author_fname='David'
;

SELECT
    title, author_fname,author_lname
FROM books
WHERE author_fname LIKE '%dav%'
;

SELECT * FROM books
WHERE title LIKE '%:%';

SELECT DISTINCT author_fname FROM books
WHERE author_fname LIKE  '____'; # four cells fnames

SELECT * FROM books
WHERE title LIKE '%\%%'; # looking for actual percent sign


-- Excersise:
 
-- 1. write a paragraph that contains all the titles with  'story'

SELECT title FROM books
WHERE title LIKE '%stor%';
 
-- 2. print longest title and the longest books

SELECT title AS 'The Book with the Longest Title' FROM books
ORDER BY CHAR_LENGTH(title) DESC
LIMIT 1;
 
-- 3. print summary: the 3 most recent books (title - year)

SELECT CONCAT (title, ' - ', released_year) AS 'Summary' 
FROM books
ORDER BY released_year DESC
LIMIT 3;
 
-- 4. find lauthor contains space 

SELECT DISTINCT author_lname FROM books
WHERE author_lname LIKE '% %';

-- 5. 3 book with lowest stock quant

SELECT title AS 'Books with lowest quantity available in stock',
      stock_quantity AS 'Quantity' FROM books
ORDER BY stock_quantity
LIMIT 2;

-- 6. print title and author_lname, sorted first by lname and then by title

SELECT title, author_lname FROM books
ORDER BY author_lname,title ;

-- 7. print MY FAVORITE AUTHOR IS ... (upper) sorted from a to z

SELECT DISTINCT 
CONCAT_WS(' ', 'MY FAVORITE AUTHOR IS', UPPER(author_fname), UPPER(author_lname)) AS 'Yell'
FROM books
ORDER BY Yell;



 