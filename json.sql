SELECT
    e.payload ->> 'product_name' AS product_name,
    COUNT(*) AS add_to_cart_count
FROM users u
JOIN events e ON e.user_id = u.user_id
WHERE e.event_name = 'add_to_cart'
  AND e.payload ->> 'product_name' IS NOT NULL
GROUP BY product_name
ORDER BY add_to_cart_count DESC, product_name;
