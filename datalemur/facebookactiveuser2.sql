//completed solution but I like the other one more
WITH june_users
AS (SELECT
*
FROM
user_actions
WHERE
EXTRACT(MONTH from event_date) = 6),

july_users AS 
(SELECT
*
FROM
user_actions
WHERE
EXTRACT(MONTH from event_date) = 7)

SELECT
EXTRACT(MONTH from july_users.event_date) AS month,
COUNT (DISTINCT(july_users.user_id)) AS monthly_active_users
FROM july_users
INNER JOIN june_users ON
july_users.user_id = june_users.user_id
GROUP BY month
