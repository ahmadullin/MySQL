1 
SELECT COUNT(*) AS total_likes
FROM likes l
JOIN users u ON l.user_id = u.id
JOIN profiles p ON u.id = p.user_id
WHERE TIMESTAMPDIFF(YEAR, p.birthday, CURDATE()) < 12;

2
SELECT gender, COUNT(*) AS total_likes
FROM profiles
GROUP BY gender
ORDER BY total_likes DESC
LIMIT 1;

3
SELECT *
FROM users
WHERE id NOT IN (SELECT DISTINCT from_user_id FROM messages);