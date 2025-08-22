-- SECTION 9 - AGGRATE FUNCTIONS
SELECT
  *
FROM
  books;
DESC books;
# how many rows?
SELECT
  COUNT(*)
FROM
  books;
SELECT
  COUNT(author_fname)
FROM
  books;
# unique values:
SELECT
  COUNT(DISTINCT author_fname)
FROM
  books;
SELECT
  COUNT(DISTINCT released_year)
FROM
  books;
SELECT
  COUNT(*)
FROM
  books
WHERE
  title LIKE '%THE%';
-- GROUP BY
SELECT
  author_lname
FROM
  books
GROUP BY
  author_lname;
-- -----------------------------------
SELECT
  author_lname,
  COUNT(*) AS books_written
FROM
  books
GROUP BY
  author_lname
ORDER BY
  books_written DESC;
-- -----------------------------------
SELECT
  released_year,
  COUNT(*) AS books_written
FROM
  books
GROUP BY
  released_year
ORDER BY
  released_year DESC;
-- -----------------------------------
SELECT
  author_lname
FROM
  books
GROUP BY
  author_lname;
-- MIN MAX
SELECT
  MIN(released_year)
FROM
  books;
SELECT
  MIN(author_fname),
  MAX(author_fname)
FROM
  books;
SELECT
  author_lname,
  MAX(stock_quantity)
FROM
  books
GROUP BY
  author_lname;
# find the title of the longest book:
SELECT
  title,
  pages
FROM
  books
ORDER BY
  pages DESC
LIMIT
  1;
# SUBQUERY method:
SELECT
  title,
  pages
FROM
  books
WHERE
  pages = (
    SELECT
      MAX(pages)
    FROM
      books
  );
# the second way is better because it show all maximum pages if there are more than one
SELECT
  title,
  released_year
FROM
  books
WHERE
  released_year = (
    SELECT
      MIN(released_year)
    FROM
      books
  );
  
-- MULTIPLE GROUP BY

SELECT
    author_lname,
    author_fname,
    COUNT(*)
FROM books
GROUP BY author_lname,author_fname;
# but better like that:
SELECT
    CONCAT(author_fname,' ',author_lname) AS author,
    COUNT(*)
FROM books
GROUP BY author;

-- -------------------------------------------------

-- GROUP BY MIN MAX:

# FIND THE YEAR OF FIRST BOOK OF EACH AUTHOR


SELECT
    author_fname,
    author_lname,
    MIN(released_year) AS earliest_release,
    MAX(released_year) AS latest_release,
    COUNT(*) AS books_written
FROM books
GROUP BY author_lname,author_fname
ORDER BY earliest_release;


-- ---------------------------------------------------

-- SUM:

SELECT
    author_fname,author_lname,
    SUM(pages)
FROM books
GROUP BY author_fname,author_lname;

-- AVG:


SELECT
    released_year,
    COUNT(*) AS books,
    AVG(stock_quantity)
FROM books
GROUP BY released_year
ORDER BY released_year;


-- ---------------------------------------------------------

-- EXERCISE:

#1. Print the total number of books in the database

SELECT COUNT(*) AS 'The number of books'
FROM books;

#2. Print out how many books were released in eahc year

SELECT 
    released_year,
    COUNT(*) AS 'Books Released'
FROM books
GROUP BY released_year
ORDER BY released_year;

#3. Print out the total number of books in stock

SELECT
    SUM(stock_quantity) AS 'Total books in stock'
FROM books;

#4. Find the avg released year for each author

SELECT
    CONCAT(author_fname,' ',author_lname) AS author,
    AVG(released_year) AS averaged_released_year
FROM books
GROUP BY author;

#5. Find the full name of the author who wrote the longest book

SELECT 
    CONCAT(author_fname,' ',author_lname) AS 'Author with Longest Book'
FROM books
WHERE pages = (SELECT MAX(pages) FROM books);
    
#6. each released year - how many book released and average pages

SELECT released_year,
       COUNT(*) AS "Total Books released",
       AVG(pages) AS "Avarged Book-Length by pages"
FROM books
GROUP BY released_year
ORDER BY released_year DESC;