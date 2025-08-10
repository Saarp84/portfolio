
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
# Q:

# CHALLENGE 6 #
# Q:

# CHALLENGE 7 #
# Q: