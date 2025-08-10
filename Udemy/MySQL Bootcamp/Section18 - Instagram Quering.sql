
# CHALLENGE 1 #
# Q: reward the users who have been around the longest: find oldest 5:
SELECT * FROM users
ORDER BY created_at
LIMIT 5;

# CHALLENGE 2 #
# Q: What day of the week do most users rgisters on?
SELECT 
    DAYNAME(created_at) AS reg_day,
    COUNT(*) AS total_registers
FROM users
GROUP BY reg_day
ORDER BY total_registers DESC
LIMIT 2;

# CHALLENGE 3 #
# Q: Find the users who have never post a photo:
SELECT 
    #u.id,
    u.username,
    u.created_at
FROM users AS u 
LEFT JOIN photos AS p ON u.id=p.user_id
WHERE p.image_url is NULL;

# CHALLENGE 4 #
# Q: Who can gey the most likes on a single photo?
SELECT 
    users.id,
    users.username,
    photos.id AS photo_id,
    photos.image_url,
    COUNT(*) AS total_likes
FROM likes
INNER JOIN photos ON likes.photo_id=photos.id
INNER JOIN users ON photos.user_id=users.id
GROUP BY likes.photo_id
ORDER BY total_likes DESC
LIMIT 1;

# CHALLENGE 5 #
# Q: How many times does average user post?
SELECT 
    ROUND(AVG(total_photos),2) AS 'Average Number of Posts' 
FROM(SELECT 
        username,
        COUNT(image_url) AS total_photos
    FROM users
    LEFT JOIN photos ON users.id=photos.user_id
    GROUP BY users.id) AS sub;

## OR
SELECT (
    SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AS 'Average Number of Posts';

# CHALLENGE 6 #
# Q: What are the top 5 most commonly used hashtags?
SELECT tag_name, COUNT(*) AS tags_count
FROM photo_tags
LEFT JOIN tags ON tags.id = photo_tags.tag_id
GROUP BY tag_id
ORDER BY tags_count DESC
limit 5;


# CHALLENGE 7 #
# Q: Find users have liked every single photo on the site
SELECT 
    username AS 'Those who liked all the photos' 
FROM(SELECT 
        username, 
        COUNT(*) * 1.0 / (SELECT COUNT(*) FROM photos) AS likes_rate
    FROM likes
    JOIN users ON users.id = likes.user_id
    GROUP BY user_id) AS sub
WHERE likes_rate=1;

## OR
SELECT username,
       Count(*) AS num_likes 
FROM   users 
       INNER JOIN likes 
               ON users.id = likes.user_id 
GROUP  BY likes.user_id 
HAVING num_likes = (SELECT Count(*) FROM   photos); 