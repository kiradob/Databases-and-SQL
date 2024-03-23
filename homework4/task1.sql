/*
1. Подсчитать количество групп (сообществ), в которые вступил каждый пользователь.
*/
use vk;

SELECT u.user_id, u.firstname, COUNT(gu.group_id) AS count_of_groups
FROM users u
LEFT JOIN group_users gu ON u.user_id = gu.user_id
GROUP BY u.user_id, u.firstname;