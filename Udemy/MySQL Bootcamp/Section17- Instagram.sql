-- Tables creations:


# users:
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT NOW()
)

-- INSERT INTO users(username) VALUES
-- ('BlueTheCat'),
-- ('CharlieBrown'),
-- ('ColtSteele')

#photos:
CREATE TABLE photos(
    id INT PRIMARY KEY AUTO_INCREMENT,
    image_url VARCHAR(255) NOT NULL,
    user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id)
)

-- INSERT INTO photos(image_url,user_id) VALUES
-- ('/alskjd76',1)

-- INSERT INTO photos(image_url,user_id) VALUES
-- ('/alsksd98',2)

-- INSERT INTO photos(image_url,user_id) VALUES
-- ('/90jddlkj',2)


-- SELECT photos.image_url, users.username 
-- FROM photos
-- JOIN users
--     ON photos.user_id=users.id;
    
    
#comments:
CREATE TABLE comments(
    id INT PRIMARY KEY AUTO_INCREMENT,
    comment_text VARCHAR(255) NOT NULL,
    user_id INT NOT NULL,
    photo_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(photo_id) REFERENCES photos(id)
);

-- INSERT INTO comments(comment_text,user_id, photo_id) VALUES
-- ('Meow!', 1, 2)

-- INSERT INTO comments(comment_text,user_id, photo_id) VALUES
-- ('Amazing Shot!', 3, 2)

-- INSERT INTO comments(comment_text,user_id, photo_id) VALUES
-- ('I <3 This', 2, 1)


#likes:
CREATE TABLE likes(
    user_id INT NOT NULL,
    photo_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    PRIMARY KEY(user_id, photo_id) # just one like from each user to each photo available
);

-- INSERT INTO likes(user_id, photo_id) VALUES
-- (1,1),
-- (2,1),
-- (1,2),
-- (1,3),
-- (3,3)


# relationships between users:
CREATE TABLE follows(
    follower_id INT NOT NULL,
    followee_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(follower_id) REFERENCES users(id),
    FOREIGN KEY(followee_id) REFERENCES users(id),
    PRIMARY KEY(follower_id, followee_id),
    CONSTRAINT self_following_forbidden CHECK(followee_id!=follower_id)
    );
    
-- INSERT INTO follows (follower_id,followee_id) VALUE (1,2)

# Hashtags
CREATE TABLE tags(
    id INT PRIMARY KEY AUTO_INCREMENT,
    tag_name VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photo_tags(
    photo_id INT NOT NULL,
    tag_id INT NOT NULL,
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    FOREIGN KEY(tag_id) REFERENCES tags(id),
    PRIMARY KEY(photo_id, tag_id)
);


