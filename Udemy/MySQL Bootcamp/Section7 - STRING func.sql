-- Section 7 - book_shop string work ----
CREATE TABLE books (
  book_id INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(100),
  author_fname VARCHAR(100),
  author_lname VARCHAR(100),
  released_year INT,
  stock_quantity INT,
  pages INT,
  PRIMARY KEY(book_id)
);
INSERT INTO
  books (
    title,
    author_fname,
    author_lname,
    released_year,
    stock_quantity,
    pages
  )
VALUES
  (
    'The Namesake',
    'Jhumpa',
    'Lahiri',
    2003,
    32,
    291
  ),
  (
    'Norse Mythology',
    'Neil',
    'Gaiman',
    2016,
    43,
    304
  ),
  ('American Gods', 'Neil', 'Gaiman', 2001, 12, 465),
  (
    'Interpreter of Maladies',
    'Jhumpa',
    'Lahiri',
    1996,
    97,
    198
  ),
  (
    'A Hologram for the King: A Novel',
    'Dave',
    'Eggers',
    2012,
    154,
    352
  ),
  ('The Circle', 'Dave', 'Eggers', 2013, 26, 504),
  (
    'The Amazing Adventures of Kavalier & Clay',
    'Michael',
    'Chabon',
    2000,
    68,
    634
  ),
  ('Just Kids', 'Patti', 'Smith', 2010, 55, 304),
  (
    'A Heartbreaking Work of Staggering Genius',
    'Dave',
    'Eggers',
    2001,
    104,
    437
  ),
  ('Coraline', 'Neil', 'Gaiman', 2003, 100, 208),
  (
    'What We Talk About When We Talk About Love: Stories',
    'Raymond',
    'Carver',
    1981,
    23,
    176
  ),
  (
    "Where I'm Calling From: Selected Stories",
    'Raymond',
    'Carver',
    1989,
    12,
    526
  ),
  ('White Noise', 'Don', 'DeLillo', 1985, 49, 320),
  (
    'Cannery Row',
    'John',
    'Steinbeck',
    1945,
    95,
    181
  ),
  (
    'Oblivion: Stories',
    'David',
    'Foster Wallace',
    2004,
    172,
    329
  ),
  (
    'Consider the Lobster',
    'David',
    'Foster Wallace',
    2005,
    92,
    343
  );
-- -------------------------------------------------------------------------------
-- CONCAT:

SELECT
  CONCAT('Saar ', 'P');
-- ---------------------  
SELECT
  CONCAT(author_fname, ' ', author_lname) AS author_name
FROM
  books;
-- ---------------------  
SELECT
  CONCAT_WS('!', 'hi', 'by', 'lol');
-- gives seperat ! 
-- ---------------------
SELECT
  CONCAT_WS(
    ': ',
    title,
    CONCAT(author_fname, ' ', author_lname)
  ) AS title_author
FROM
  books;
  
-- SUBSTRING | SUBSTR :

SELECT
  CONCAT_WS(" ", SUBSTR(author_fname, 1, 1), author_lname) AS 'author shortcut'
FROM
  books;
  
-- ------------
SELECT
  SUBSTRING(title, 1, 10) AS 'short title'
FROM
  books;
-- ------------
  
SELECT
  CONCAT_WS(
    ".",
    SUBSTR(author_fname, 1, 1),
    SUBSTR(author_lname, 1, 1)
  ) AS 'author initials'
FROM
  books;
-- ------------
-- REPLACE(str,from_str,to_str) : לא מעדכן את הטבלה רק מראה לי תוצאה שביקשתי

SELECT 
    REPLACE(title," ","-") 
FROM
    books;
-- ------------

-- REVERSE(str)

SELECT 
    REVERSE(title) 
FROM
    books;
    
-- SELECT REVERSE(NULL) gives NULL

-- --------------

-- CHAR_LENGTH : like len()

SELECT
    CHAR_LENGTH(title) AS "len(title)",
    title
FROM
    books;
    
-- UPPER & LOWER :

SELECT
    CONCAT_WS(" ", "I","LOVE", UPPER(title), "!"),
    title
FROM
    books;

-- INSERT(str,pos,len,newstr)
SELECT 
    INSERT('Hello Saar',6,0,' There');
    
-- LEFT OR RIGHT
SELECT 
    LEFT('Hello',1);
    
-- REPEAT:
SELECT 
    REPEAT('Hello',4); -- HelloHelloHelloHello 

-- TRIM (LEADING|TRAILING|BOTH):

SELECT
    TRIM(TRAILING '.' FROM(
        TRIM(LEADING '.' FROM '...STOP...')
        )
    );

SELECT
    TRIM(BOTH '.' FROM('...STOP...'));
    
-- ----------------------------------

-- EXERCISE: 
-- 1. REVERSE THIS: 'Why does my cat look like that?'

SELECT 
    REVERSE('Why does my cat look like that?');

-- 2. what is printed out?
-- 'I-like-cats'

-- 3. replace in titles all spaces with arrows ->

SELECT
    REPLACE(title," ", "-->") AS 'arrow titling'
FROM
    books;

-- 4. print las names from froward and then from backward

SELECT
    author_lname AS Forward,
    REVERSE(author_lname) AS Backward
FROM
    books;

-- 5. full name of an author in capital letters

SELECT
    UPPER(CONCAT_WS(" ",author_fname,author_lname)) AS "Author FULL NAME"
FROM
    books;

-- 6. the ---- was released in ----- (title and year)

SELECT 
    CONCAT_WS(' ',
        'The',
        title,
        'was released in',
        released_year) As 'Released Year'
FROM
    books;

-- 7. print sort title first 10 chars of titles +... 
--    last name comma first name 
--    ----- (quantity) in stock

SELECT 
    CONCAT(SUBSTR(title,1,10),'...') AS 'Title',
    CONCAT_WS(',',author_lname,author_fname) AS 'Author',
    CONCAT_WS(' ',stock_quantity, 'in stock') AS 'Stock' 
FROM
    books;