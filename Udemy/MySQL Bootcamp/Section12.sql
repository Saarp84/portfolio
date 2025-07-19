-- CONSTRAINTS:

-- UNIQUE:

-- CREATE TABLE companies (
--     supplier_id INT AUTO_INCREMENT,
--     name VARCHAR(255) NOT NULL,
--     phone VARCHAR(15) NOT NULL UNIQUE,
--     address VARCHAR(255) NOT NULL,
--     PRIMARY KEY (supplier_id)
--     );
    
CREATE TABLE contacts (
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE
);

INSERT INTO contacts (name, phone)
VALUES ('billybob', '8781213455');

INSERT INTO contacts (name, phone)
VALUES ('billybee', '8781213455'); # gets error!

INSERT INTO contacts (name, phone)
VALUES ('billybob', '8781213456'); # works


-- CHECK:

-- CREATE TABLE users (
--     username VARCHAR(20) NOT NULL,
--     age INT CHECK (age>0)
--     );
    
-- INSERT INTO users (username, age)  
-- VALUES ('bluecat', 50);

-- INSERT INTO users (username, age)  
-- VALUES ('colt', -3); # gets error


-- Constraint 'name' help me understant what is violated given several constraints
CREATE TABLE palindromes (
        word VARCHAR(100),
        CONSTRAINT polcheck CHECK(REVERSE(word)=word)
        );
        
INSERT INTO palindromes
VALUES ('mom')

INSERT INTO palindromes
VALUES ('dad'),('SaaS');

INSERT INTO palindromes
VALUES ('okey') # gets error


-- Multi-Column Checks:

#for example name and adress both need to be unique

        
CREATE TABLE contacts (
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    CONSTRAINT unique_name_phone UNIQUE (name, phone)
);
    

        
CREATE TABLE houses (
    purchase_price DECIMAL(12,2) NOT NULL,
    sale_price DECIMAL(12,2) NOT NULL,
    CONSTRAINT profit_is_a_must CHECK (sale_prcie >= purchase_price);
);    

-- ALTER TABLE
