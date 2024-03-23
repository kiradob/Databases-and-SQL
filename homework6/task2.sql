
/*
Задание 2. Предыдущую задачу решить с помощью процедуры и обернуть используемые команды в транзакцию внутри процедуры.
*/
DROP PROCEDURE IF EXISTS delete_user;

DELIMITER //
CREATE PROCEDURE delete_user(IN user_id BIGINT(11))
BEGIN
	START TRANSACTION;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error during transaction';
    END;
    
    DELETE FROM messages
    WHERE to_user_id = user_id;
    
	DELETE FROM messages
    WHERE from_user_id = user_id;
	
    DELETE FROM likes
    WHERE user_id = user_id;
    
    DELETE FROM media
    WHERE user_id = user_id;
    
    DELETE FROM friend_requests
    WHERE target_user_id = user_id;
    
    DELETE FROM friend_requests
    WHERE initiator_user_id = user_id;
    
    DELETE FROM communities
    WHERE admin_user_id = user_id;
    
    DELETE FROM profiles
    WHERE user_id = user_id;
    
    DELETE FROM users
    WHERE id = user_id;
    
    COMMIT;
END//
DELIMITER ;

CALL delete_user(2);