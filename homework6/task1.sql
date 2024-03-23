USE vk;

/*
Задание 1. Написать функцию, которая удаляет всю информацию об указанном пользователе из БД vk. 
Пользователь задается по id. Удалить нужно все сообщения, лайки, медиа записи, 
профиль и запись из таблицы users. Функция должна возвращать номер пользователя.
*/

SET GLOBAL log_bin_trust_function_creators = 1;
DROP FUNCTION IF EXISTS delete_user_info;

DELIMITER //
CREATE FUNCTION delete_user_info(user_id BIGINT) RETURNS BIGINT
BEGIN
    DECLARE user_exists INT;
    
    SELECT COUNT(*) INTO user_exists FROM users WHERE id = user_id;
    
    IF user_exists = 0 THEN
        RETURN 0; -- Можно вернуть 0 в случае, если пользователя не существует
    END IF;
    
    BEGIN
        DELETE FROM messages WHERE to_user_id = user_id OR from_user_id = user_id;
        
        DELETE FROM likes WHERE user_id = user_id;
        
        DELETE FROM media WHERE user_id = user_id;
        
        DELETE FROM friend_requests WHERE target_user_id = user_id OR initiator_user_id = user_id;
        
        DELETE FROM communities WHERE admin_user_id = user_id;
        
        DELETE FROM profiles WHERE user_id = user_id;
        
        DELETE FROM users WHERE id = user_id;
        
        RETURN user_id;
    EXCEPTION
        WHEN others THEN
            ROLLBACK;
            RETURN -1; -- Можно вернуть -1 в случае ошибки
    END;
END//
DELIMITER ;

SELECT delete_user_info(1); -- Вызов функции для удаления информации о пользователе с id=1