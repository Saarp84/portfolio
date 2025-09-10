-- Practice Tasks — WITH CTE --


-- Task 1 — Find the top 5 users who received the most total likes on all their photos:

WITH photos_likes AS (## First CTE: calculate the number of likes for each photo.
    SELECT 
        p.user_id,
        p.image_url,
        COUNT(l.photo_id) AS likes_count
    FROM likes l
    JOIN photos p
        ON p.id = l.photo_id
    GROUP BY p.user_id, p.image_url
    ORDER BY p.user_id, likes_count 
    ), likes_per_user AS( ## Second CTE: sum likes per user and the avarage per photo
        SELECT 
            u.username,
            SUM(p.likes_count) AS total_likes,
            ROUND(SUM(p.likes_count) / COUNT(p.image_url), 1) AS avg_likes_per_photo,
            COUNT(p.image_url) AS photos_count
        FROM photos_likes p 
        JOIN users u 
            ON u.id = p.user_id
        GROUP BY u.username
        )
## Final step: sort and return the top 5.
SELECT * FROM likes_per_user
ORDER BY total_likes DESC
LIMIT 5;

 

-- Task 2 — Calculate the percentage of users who have uploaded at least one photo out of all users:

## First CTE: find all users with at least one uploaded photo.
## Second CTE: count them and compare with the total number of users.

WITH photo_count AS(# Common Table Expression for uploaders table
    SELECT 
        u.username,
        COUNT(p.image_url) AS photos_uplaoded
    FROM photos p
    JOIN users u 
        ON u.id = p.user_id
    GROUP BY u.username
    ), 
    uploader_count AS(# Common Table Expression for counting the uploaders
    SELECT 
        COUNT(DISTINCT(username)) AS uploaders
    FROM photo_count
    ),
    user_count AS (# Common Table Expression for counting the users
        SELECT COUNT(*) AS total_users
        FROM users
    )
SELECT 
    CAST(u.uploaders AS FLOAT) / uc.total_users AS "Percent of uploaders"
FROM uploader_count u, user_count uc;


WITH photo_count AS(# Common Table Expression for uploaders table if uploaded more than 10 photos
    SELECT 
        u.username,
        COUNT(p.image_url) AS photos_uplaoded
    FROM photos p
    JOIN users u 
        ON u.id = p.user_id
    GROUP BY u.username
    HAVING COUNT(p.image_url)>10
    )
    SELECT * FROM photo_count
    

-- Task 3 — Find all photos that received more likes than the global site average:


WITH likes_count AS(## First CTE: likes count
    SELECT 
        p.image_url,
        COUNT(*) AS likes
    FROM likes l 
    JOIN photos p ON l.photo_id=p.id
    GROUP BY p.image_url
    ), 
    avg_likes AS (## Second CTE: average
        SELECT AVG(likes) AS avg_likes
        FROM likes_count
    )
    SELECT 
        l.image_url,
        l.likes
    FROM likes_count l, avg_likes a
    WHERE likes > a.avg_likes
    ORDER BY likes DESC;





-- Task 4 — Find the top 15 users who liked the most photos belonging to other users (not their own):

## First CTE: counting likes given to others by each user
WITH counting_given_likes AS(
        SELECT l.user_id,
                COUNT(*) AS likes_given_to_other
        FROM likes l
        JOIN photos p ON p.id = l.photo_id
        WHERE l.user_id != p.user_id
        GROUP BY l.user_id
    )
    
    SELECT 
        u.username,
        c.likes_given_to_other 
    FROM counting_given_likes c
    JOIN users u ON u.id = c.user_id
    ORDER BY likes_given_to_other DESC
    LIMIT 15
;




-- Task 5 — Given a specific user_id (:user_id), find the tags they have used most often on their own photos:

## First CTE: all photos of the given user.
## Second CTE: join with photo_tags and tags to count tag frequency.
## Final step: sort by tag count descending.


# first CTE : users and photos
WITH users_photos_tags AS (
    SELECT 
        u.id AS user_id,
        u.username,
        t.tag_name
    FROM users u
    JOIN photos p 
        ON u.id = p.user_id
    JOIN photo_tags pt 
        ON p.id = pt.photo_id
    JOIN tags t 
        ON t.id = pt.tag_id
)
    SELECT username, tag_name, tag_count
    FROM (
        SELECT 
            u.username,
            u.tag_name,
            COUNT(*) AS tag_count,
            ROW_NUMBER() OVER (PARTITION BY u.username ORDER BY COUNT(*) DESC) AS rn
        FROM users_photos_tags u
        GROUP BY u.username, u.tag_name
    ) t
    WHERE rn = 1
    ORDER BY tag_count DESC;
        


-- Task 6 — Find the top 3 photos with the highest like rate compared to the total number of users:

## First CTE: total number of users.
## Second CTE: number of likes per photo.
## Final step: compute likes / total_users and sort.

WITH users_count AS(
    SELECT 
        COUNT(*) AS total_users
    FROM users
),
likes_per_photo AS(
    SELECT 
        photo_id,
        COUNT(*) AS total_likes
    FROM likes
    GROUP BY photo_id
)

SELECT 
    p.id AS photo_id,
    p.image_url,
    -- lpp.total_likes,
    -- uc.total_users,
    ROUND((CAST(lpp.total_likes AS FLOAT) / uc.total_users),2) AS like_rate
    -- CAST turnning type to be floated "caculated number" 
FROM likes_per_photo lpp
CROSS JOIN users_count uc
-- CROSS JOIN - "concating" columns - same value to each row
JOIN photos p 
    ON p.id = lpp.photo_id
ORDER BY like_rate DESC
LIMIT 3;


-- Task 7 — Find the pair of users who share the most tags in their photos:

## First CTE: list of (user_id, tag_id) for all photos, joined with tags.
## Second CTE: self-join on tag_id and count how many shared tags each pair has.


WITH users_tags AS(
    SELECT 
        p.user_id,
        pt.tag_id
    FROM photo_tags pt
    JOIN photos p
        ON p.id = pt.photo_id
),
paired_share AS(
    SELECT 
        ut1.user_id    AS user_a,
        ut2.user_id    AS user_b,
        ut1.tag_id     AS shared_tag
    FROM users_tags ut1
    JOIN users_tags ut2
        ON ut1.tag_id = ut2.tag_id
        AND ut1.user_id < ut2.user_id
)

SELECT 
    user_a,
    user_b,
    COUNT(*) AS total_shared_tags
FROM paired_share
GROUP BY user_a,user_b
ORDER BY total_shared_tags DESC
LIMIT 1;



-- Task 8 — Find all users who have at least one photo with zero likes:

## First CTE: all photos with their like counts.
## Second CTE: filter for photos with 0 likes and return distinct users.


SELECT p.image_url,
        COUNT(*) AS likes
FROM photos p
RIGHT JOIN likes l
    ON p.id = l.photo_id
GROUP BY photo_id
HAVING likes<30;









