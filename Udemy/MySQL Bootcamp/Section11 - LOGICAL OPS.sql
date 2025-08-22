-- LOGICAL OPERATORS:

SELECT *
FROM books
WHERE released_year !=2017;


-- NOT LIKE:

SELECT DISTINCT author_fname
FROM books
WHERE author_fname NOT LIKE 'Da%';

SELECT title
FROM books
WHERE title NOT LIKE '%The%';

-- GREATER THAN | LESS THAN

SELECT TITLE, released_year FROM books
WHERE released_year >= 2005
ORDER BY released_year DESC;

-- && AND:

SELECT TITLE, released_year FROM books
WHERE released_year >= 2005 && released_year <=2012
ORDER BY released_year DESC;


SELECT title, released_year FROM books
WHERE CHAR_LENGTH(title) < 25 AND released_year >= 2000;

-- OR


SELECT TITLE, released_year FROM books
WHERE released_year <= 2005 OR released_year >=2012
ORDER BY released_year DESC;

-- BETWEEN: (INCLUSIVE)

SELECT title, released_year FROM books
WHERE released_year BETWEEN 2004 AND 2015;

SELECT title, released_year FROM books
WHERE released_year NOT BETWEEN 2004 AND 2015;


-- COMPARING DATES:

SELECT name, birthdt FROM people
WHERE birthdt < '2005-01-01' AND birthtime > '10:00:00';

# this is the right way to use time as logical condition
SELECT CAST('09:00:00' AS TIME);



-- IN OPERATOR:

SELECT title, author_lname FROM books
WHERE author_lname IN ('Lahiri', 'Smith', 'Eggers');

SELECT title, author_lname FROM books
WHERE author_lname NOT IN ('Lahiri', 'Smith', 'Eggers');

SELECT title, released_year FROM books
WHERE released_year > 2000 AND released_year % 2 != 0;

-- CASE WHEN :

SELECT title, released_year,
CASE
    WHEN released_year >= 2000 THEN 'modern lit'
    ELSE '20th century lit'
END AS genre
FROM books;

SELECT title, stock_quantity,
CASE
    WHEN stock_quantity BETWEEN 0 AND 40 THEN '*'
    WHEN stock_quantity BETWEEN 41 AND 80 THEN '**'
    WHEN stock_quantity BETWEEN 81 AND 120 THEN '***'
    ELSE '****'
END AS stock
FROM books;


-- NULL values targeting:

SELECT title, author_fname FROM books
WHERE author_fname IS NOT NULL;

DELETE FROM books
WHERE title IS NULL;


-- Exercise:

#1. select all the book written before 1980 not included

SELECT *
FROM books
WHERE released_year < 1980;

#2. select all books written by egger or chabon

SELECT *
FROM books
WHERE author_lname != 'Eggers' && author_lname != 'Chabon';

#3. select all books written by lahiri that published after 2000

SELECT *
FROM books
WHERE author_lname = 'Lahiri' AND released_year > 2000;

#4. books with pages between 100 to 200

SELECT title,pages
FROM books
WHERE pages BETWEEN 100 AND 200;


#5. all books whhere author last name start with c ro s

SELECT title,author_lname
FROM books
WHERE author_lname LIKE 's%' 
    OR author_lname LIKE 'c%';
    
SELECT title, author_lname
FROM books WHERE SUBSTR(author_lname, 1, 1) in ('C', 'S');

#6. if title contains stories -> short stories , just kids + herat breaking -> memory , else novel

SELECT title,
CASE 
    WHEN title LIKE '%stor%' THEN 'short stories'
    WHEN title LIKE '%just ki%' OR title LIKE '%heartbre%' THEN 'memories'
    ELSE 'novel'
END AS genre
FROM books;

#7. select author fname , lname and count x 'books'  

SELECT author_fname, author_lname,
CASE
    WHEN COUNT(*) = 1 THEN '1 Book' 
    ELSE CONCAT(COUNT(*),' Books') 
END AS 'Books published'
FROM books
GROUP BY author_fname,author_lname;

