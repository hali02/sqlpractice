WITH repeats AS
(SELECT t1.merchant_id, 
  (t1.transaction_timestamp) AS first_trans, 
  t2.transaction_timestamp, 
  t1.amount
FROM transactions t1
INNER JOIN transactions t2 
ON t1.transaction_timestamp != t2.transaction_timestamp
AND t1.merchant_id = t2.merchant_id
AND t1.amount = t2.amount
AND t1.credit_card_id = t2.credit_card_id
WHERE t1.transaction_timestamp < t2.transaction_timestamp
AND t2.transaction_timestamp <= (t1.transaction_timestamp + interval '10 minutes'))

SELECT COUNT(first_trans)
FROM repeats
