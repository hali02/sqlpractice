WITH summary 
AS (
  SELECT 
    item_type,
    SUM(square_footage) AS total_sqft,
    COUNT(item_type) AS item_count
  FROM
    inventory
  GROUP BY item_type),
  
  prime_items
  AS (
    SELECT
      item_type,
      total_sqft,
      (TRUNC(500000/total_sqft, 0) * item_count) AS prime_item_count
    FROM summary
    WHERE item_type = 'prime_eligible'),
    
  not_prime
  AS (
    SELECT
      item_type,
      total_sqft,
      TRUNC((500000 - TRUNC((SELECT prime_item_count/
        (SELECT item_count FROM summary WHERE item_type = 'prime_eligible') 
        * total_sqft FROM prime_items)))/total_sqft) * item_count AS not_prime_count
    FROM summary
    WHERE item_type = 'not_prime')
  
  SELECT 
    item_type,
    prime_item_count AS item_count
  FROM prime_items
  UNION ALL
  SELECT
    item_type,
    not_prime_count AS item_count
  FROM not_prime
