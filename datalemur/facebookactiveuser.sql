//partial solution still need to figureo out how to display month
WITH t1 
AS 
(SELECT 
  DISTINCT (CONCAT(EXTRACT(MONTH from event_date), user_id)) AS combo,
  user_id,
  EXTRACT(MONTH from event_date) AS month
FROM user_actions
WHERE 
  EXTRACT(MONTH from event_date) = 6 OR EXTRACT(MONTH from event_date) = 7),


t2 AS (SELECT 
  COUNT (DISTINCT(month)) AS num_months_active,
  user_id
FROM t1
GROUP BY user_id)

SELECT
COUNT(user_id) AS monthly_active_users
FROM t2
WHERE num_months_active > 1
