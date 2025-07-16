-- CRUD challenge ------------

CREATE TABLE shirts (
    shirt_id INT AUTO_INCREMENT PRIMARY KEY,
    article VARCHAR(50) NOT NULL,
    color VARCHAR(50) NOT NULL,
    shirt_size VARCHAR(50) NOT NULL,
    last_worn INT NOT NULL DEFAULT 0
);



INSERT INTO shirts (article, color, shirt_size, last_worn)
VALUES 
	('t-shirt', 'white', 'S', 10),
	('t-shirt', 'green', 'S', 200),
	('polo shirt', 'black', 'M', 10),
	('tank top', 'blue', 'S', 50),
	('t-shirt', 'pink', 'S', 0),
	('polo shirt', 'red', 'M', 5),
	('tank top', 'white', 'S', 200),
	('tank top', 'blue', 'M', 15);



-- add in new shirt puprle polo M 50 
INSERT INTO shirts (article, color, shirt_size, last_worn)
VALUES
    ('polo shirt', 'purple', 'M', 50);
    
-- select all but print article and size

SELECT article, shirt_size FROM shirts;

-- update all polo shirts to size large

-- SELECT shirt_size FROM shirts
UPDATE shirts SET shirt_size="L"
WHERE article='polo shirt';

-- update last worn 15 to 0

-- SELECT last_worn FROM shirts
UPDATE shirts SET last_worn=0
WHERE last_worn=15;

-- all white shirts to change to XS and off white color

-- SELECT color, shirt_size FROM shirts
UPDATE shirts SET shirt_size="XS", color="off-white"
WHERE color='white';

-- delete all tank top shirts

DELETE FROM shirts
WHERE article='tank top';

-- empty the table out
DELETE FROM shirts;

-- drop the table
DROP TABLE shirts;