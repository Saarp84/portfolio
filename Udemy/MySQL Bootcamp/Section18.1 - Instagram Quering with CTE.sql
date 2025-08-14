-- Practice Tasks — WITH CTE --


-- Task 1 — Find the top 5 users who received the most total likes on all their photos:

WITH photos_likes AS (
## First CTE: calculate the number of likes for each photo.
    SELECT 
        p.user_id,
        p.image_url,
        COUNT(l.photo_id) AS likes_count
    FROM likes l
    JOIN photos p
        ON p.id = l.photo_id
    GROUP BY p.user_id, p.image_url
    ORDER BY p.user_id, likes_count 
), likes_per_user AS(
## Second CTE: sum likes per user.
SELECT 
    u.username,
    COUNT(p.image_url) AS photos_count,
    SUM(p.likes_count) AS total_likes
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




-- Task 3 — Find all photos that received more likes than the global site average:

## First CTE: calculate the average likes per photo (site-wide).
## Second CTE: calculate the number of likes for each photo.
## Final step: filter only those above the average.





-- Task 4 — Find the top 5 users who liked the most photos belonging to other users (not their own):

## First CTE: all likes given, after filtering out self-likes.
## Second CTE: sum likes per “liker” user.



-- Task 5 — Given a specific user_id (:user_id), find the tags they have used most often on their own photos:

## First CTE: all photos of the given user.
## Second CTE: join with photo_tags and tags to count tag frequency.
## Final step: sort by tag count descending.



-- Task 6 — Find the top 3 photos with the highest like rate compared to the total number of users:

## First CTE: total number of users.
## Second CTE: number of likes per photo.
## Final step: compute likes / total_users and sort.


-- Task 7 — Find the pair of users who share the most tags in their photos:

## First CTE: list of (user_id, tag_id) for all photos, joined with tags.
## Second CTE: self-join on tag_id and count how many shared tags each pair has.


-- Task 8 — Find all users who have at least one photo with zero likes:

## First CTE: all photos with their like counts.
## Second CTE: filter for photos with 0 likes and return distinct users.

