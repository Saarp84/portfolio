-- Practice Tasks — Window Functions & Dates

-- Task 1 — Find the total number of users created each month, and show the cumulative number of users up to that month.

WITH users_y_m AS(
    SELECT 
        username,
        YEAR(created_at) AS created_year,
        MONTH(created_at) AS created_month
    FROM users
    ORDER BY created_year,created_month
)

SELECT 
    CONCAT(created_year,"-",created_month) AS "year_month",
    COUNT(*) AS users_created,
    SUM(COUNT(*)) OVER(ORDER BY created_year,created_month) AS cumulative_users_created
    -- counting cumulative
FROM users_y_m
GROUP BY created_year,created_month;



-- Task 2 — For each user, find their signup date and how many days passed since the previous signup.

WITH users_dates AS(
SELECT 
    username,
    created_at,
    LAG(created_at) OVER (ORDER BY created_at) AS prev_created_at
FROM users
ORDER BY created_at)

SELECT 
    -- *
    username,
    DATE_FORMAT(created_at, '%d/%m/%Y') AS signup_date,
    DATEDIFF(created_at,prev_created_at) AS days_since_prev_signup
FROM users_dates;



-- Task 3 — Find the top 5 days with the highest number of new user signups.

SELECT 
    DATE_FORMAT(created_at, '%W') AS day_of_signup,
    COUNT(*) AS signups
FROM users
GROUP BY day_of_signup
ORDER BY signups DESC
LIMIT 5;


-- Task 4 — For each user, show their signup date and their rank compared to all users created on the same day.

SELECT 
    username,
    created_at,
    DATE_FORMAT(created_at, '%a') AS signup_day_of_week,
    RANK() OVER(PARTITION BY DATE_FORMAT(created_at, '%w') ORDER BY created_at) AS signup_rank
FROM users;


-- Task 5 — Show the average number of daily signups per month, and rank the months by this average.




-- Task 6 — For each user, show how many users signed up before them and how many after them.




-- Task 7 — Find, for each month, the user who signed up first and the user who signed up last.




-- Task 8 — Create quartiles of users by signup date, and return how many users fall into each quartile.




-- Task 9 — For each user, show their signup date and the percentage rank of that date relative to all users.



-- Task 10 — Find the day-over-day change in new user signups and list all days where signups grew by more than 50% compared to the previous day.