SELECT COUNT (DISTINCT CONCAT(t1.product_id, t2.product_id)) AS pair
FROM transactions t1
INNER JOIN transactions t2 ON
t2.transaction_id = t1.transaction_id
AND t2.product_id > t1.product_id
