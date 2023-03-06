WITH intermediary 
AS 
  (
  SELECT COALESCE(advertiser.user_id, daily_pay.user_id) AS user_id, status, paid 
  FROM advertiser
  FULL JOIN daily_pay ON advertiser.user_id = daily_pay.user_id)

SELECT 
  user_id,
  CASE WHEN paid IS NULL THEN 'CHURN'
  WHEN status = 'NEW' AND paid IS NOT NULL THEN 'EXISTING'
  WHEN status = 'EXISTING' AND paid IS NOT NULL THEN 'EXISTING'
  WHEN status = 'CHURN' AND paid IS NOT NULL THEN 'RESURRECT'
  WHEN status = 'RESURRECT' AND paid IS NOT NULL THEN 'EXISTING'
  WHEN status IS NULL AND paid is NOT NULL THEN 'NEW'
  END AS new_status
FROM intermediary
ORDER BY user_id
