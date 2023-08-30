1
CREATE VIEW young_users AS
SELECT users.firstname, users.lastname, profiles.hometown, profiles.gender
FROM users
JOIN profiles ON users.id = profiles.user_id
WHERE profiles.birthday >= DATE_SUB(NOW(), INTERVAL 20 YEAR);

SELECT * FROM young_users;

2
SELECT users.firstname, users.lastname, COUNT(messages.id) AS messages_sent, DENSE_RANK() OVER (ORDER BY COUNT(messages.id) DESC) AS user_rank
FROM users
JOIN messages ON users.id = messages.from_user_id
GROUP BY users.id
ORDER BY messages_sent DESC;

3
SELECT created_at, LEAD(created_at) OVER (ORDER BY created_at) - created_at AS time_diff
FROM messages
ORDER BY created_at ASC;