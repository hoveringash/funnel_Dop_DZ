WITH eligible_users AS (
    SELECT user_id
    FROM users
    WHERE registered_at >= TIMESTAMP '2024-01-01'
      AND registered_at < TIMESTAMP '2024-02-01'
)
SELECT
    (SELECT COUNT(*) FROM eligible_users) AS registered_users_count,

    (SELECT COUNT(*)
     FROM eligible_users u
     WHERE EXISTS (
         SELECT 1 FROM events e
         WHERE e.user_id = u.user_id AND e.event_name = 'app_open'
     )) AS opened_app_users_count,

    (SELECT COUNT(*)
     FROM eligible_users u
     WHERE EXISTS (
         SELECT 1 FROM events e
         WHERE e.user_id = u.user_id AND e.event_name = 'add_to_cart'
     )) AS added_to_cart_users_count,

    (SELECT COUNT(*)
     FROM eligible_users u
     WHERE EXISTS (
         SELECT 1 FROM events e
         WHERE e.user_id = u.user_id AND e.event_name = 'purchase'
     )) AS purchased_users_count,

    (SELECT COUNT(*)
     FROM eligible_users u
     WHERE EXISTS (
         SELECT 1 FROM payments p
         WHERE p.user_id = u.user_id AND p.status = 'success'
     )) AS successfully_purchased_users_count;
