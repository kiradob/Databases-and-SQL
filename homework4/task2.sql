/*
2. Подсчитать количество пользователей в каждом сообществе.
*/

use vk;

SELECT g.group_id, g.group_name, COUNT(gu.user_id) AS count_of_users
FROM groups g
LEFT JOIN group_users gu ON g.group_id = gu.group_id
GROUP BY g.group_id, g.group_name;