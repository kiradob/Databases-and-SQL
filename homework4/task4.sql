/*
4. * Подсчитать общее количество лайков, которые получили пользователи младше 18 лет..
*/

use vk;

SELECT SUM(likes) AS total_likes_under_18
FROM users
WHERE age < 18;