WITH eligible_users AS (
    SELECT user_id, registered_at
    FROM users
    WHERE registered_at >= TIMESTAMP '2024-01-01'
      AND registered_at < TIMESTAMP '2024-02-01'
)
SELECT COUNT(*) AS retention_d7_users_count
FROM eligible_users u
WHERE EXISTS (
    SELECT 1
    FROM events e
    WHERE e.user_id = u.user_id
      AND e.event_name = 'app_open'
      AND DATE_TRUNC('day', e.event_time) =
          DATE_TRUNC('day', u.registered_at) + INTERVAL '7 days'
);
