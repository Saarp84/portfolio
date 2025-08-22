-- Syntax:

-- trigger time
# BEFORE
# AFTER 
-- trigger event
# INSERT
# DELETE
# UPDATE
-- ON table_name


-- CREATE TRIGGER must_be_adault
-- BEFORE INSERT 


-- CREATE TABLE users(
--     username VARCHAR(100),
--     age INT
-- )

-- INSERT INTO users(username,age)
-- VALUES ('bobby', 23),('sandy', 32)


DELIMITER $$

CREATE TRIGGER must_be_adult
     BEFORE INSERT ON users FOR EACH ROW
     BEGIN
          IF NEW.age < 18
          THEN
              SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Must be an adult!';
          END IF;
     END;
$$
DELIMITER ;

INSERT INTO users(username,age)
VALUES ('sam', 15)
# error - Must be an adult!


## instegram database:

## Trigger - prevent users from folowing themselves:

DELIMITER $$

CREATE TRIGGER prevent_self_follows
     BEFORE INSERT ON follows FOR EACH ROW
     BEGIN
          IF NEW.follower_id = NEW.followee_id
          THEN
              SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'You cannot follow yourself';
          END IF;
     END;
$$
DELIMITER ;

## Trigger - unfollowing someone:
-- CREATE TABLE unfollows(
--     follower_id INT NOT NULL,
--     followee_id INT NOT NULL,
--     FOREIGN KEY(follower_id) REFERENCES users(id),
--     FOREIGN KEY(followee_id) REFERENCES users(id)
-- )


-- DELIMITER $$

-- CREATE TRIGGER capture_unfollow
--      AFTER DELETE ON follows FOR EACH ROW
--      BEGIN
--         INSERT INTO unfollows
--         SET 
--             follower_id = OLD.follower_id,
--             followee_id = OLD.followee_id;
--     END;
-- $$

-- DELIMITER ;


SHOW TRIGGERS;
-- DROP TRIGGERS must_be_adult;   

