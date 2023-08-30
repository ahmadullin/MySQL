1
DROP DATABASE IF EXISTS semimar_4;
CREATE DATABASE semimar_4;
USE semimar_4;
-- пользователи
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    firstname VARCHAR(50),
    lastname VARCHAR(50) COMMENT 'Фамилия',
    email VARCHAR(120) UNIQUE
);

INSERT INTO users (id, firstname, lastname, email) VALUES 
(1, 'Reuben', 'Nienow', 'arlo50@example.org'),
(2, 'Frederik', 'Upton', 'terrence.cartwright@example.org'),
(3, 'Unique', 'Windler', 'rupert55@example.org'),
(4, 'Norene', 'West', 'rebekah29@example.net'),
(5, 'Frederick', 'Effertz', 'von.bridget@example.net'),
(6, 'Victoria', 'Medhurst', 'sstehr@example.net'),
(7, 'Austyn', 'Braun', 'itzel.beahan@example.com'),
(8, 'Jaida', 'Kilback', 'johnathan.wisozk@example.com'),
(9, 'Mireya', 'Orn', 'missouri87@example.org'),
(10, 'Jordyn', 'Jerde', 'edach@example.com');


-- Создание таблицы users_old
CREATE TABLE users_old LIKE users;

-- Создание процедуры для перемещения пользователя
DELIMITER //

CREATE PROCEDURE MoveUserToOld(IN userId INT)
BEGIN
    START TRANSACTION;
    
    -- Создание временной таблицы для хранения данных пользователя
    CREATE TEMPORARY TABLE temp_user AS 
        SELECT * FROM users WHERE id = userId;
    
    -- Удаление пользователя из таблицы users
    DELETE FROM users WHERE id = userId;
    
    -- Вставка данных пользователя в таблицу users_old
    INSERT INTO users_old SELECT * FROM temp_user;
    
    -- Проверка наличия ошибок и фиксация или отмена изменений
    IF FOUND_ROWS() = 1 THEN
        COMMIT;
        SELECT 'Пользователь успешно перемещен в таблицу users_old';
    ELSE
        ROLLBACK;
        SELECT 'Ошибка при перемещении пользователя';
    END IF;
    
    -- Удаление временной таблицы
    DROP TABLE temp_user;
END//

DELIMITER ;

CALL MoveUserToOld(1);

2
DELIMITER //

CREATE FUNCTION hello()
RETURNS VARCHAR(50)
DETERMINISTIC
NO SQL
BEGIN
    DECLARE greeting VARCHAR(50);
    
    IF TIME_FORMAT(CURRENT_TIME(), '%H:%i') >= '06:00' AND TIME_FORMAT(CURRENT_TIME(), '%H:%i') < '12:00' THEN
        SET greeting = 'Доброе утро';
    ELSEIF TIME_FORMAT(CURRENT_TIME(), '%H:%i') >= '12:00' AND TIME_FORMAT(CURRENT_TIME(), '%H:%i') < '18:00' THEN
        SET greeting = 'Добрый день';
    ELSEIF TIME_FORMAT(CURRENT_TIME(), '%H:%i') >= '18:00' AND TIME_FORMAT(CURRENT_TIME(), '%H:%i') < '00:00' THEN
        SET greeting = 'Добрый вечер';
    ELSE
        SET greeting = 'Доброй ночи';
    END IF;
    
    RETURN greeting;
END//

DELIMITER ;
