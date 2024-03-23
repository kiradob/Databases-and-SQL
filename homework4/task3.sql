/*
Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем 
(написал ему сообщений).
*/

use vk;

SELECT m.sender_id, u.firstname, COUNT(m.message_id) AS count_of_messages
FROM messages m
JOIN users u ON m.sender_id = u.user_id
WHERE m.receiver_id = 2
GROUP BY m.sender_id, u.firstname
ORDER BY count_of_messages DESC
LIMIT 1;