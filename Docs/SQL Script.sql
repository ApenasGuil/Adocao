##### Database and Table

CREATE DATABASE adocao;
USE adocao;
# DROP DATABASE adocao;

CREATE TABLE IF NOT EXISTS `pet_category` (
    `category_id` TINYINT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `category_name` VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS `city` (
	`city_id` INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `city_name` VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS `neighborhood` (
	`neighborhood_id` INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `neighborhood_name` VARCHAR(50) NOT NULL,
    `city_id` INT UNSIGNED NOT NULL,
    CONSTRAINT fk_city_id FOREIGN KEY (city_id) REFERENCES city(city_id)
);

CREATE TABLE IF NOT EXISTS `user` (
	`user_id` INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `user_name` VARCHAR(100) NOT NULL,
    `user_email` VARCHAR(100) UNIQUE NOT NULL,
    `user_password` VARCHAR(30) NOT NULL,
    `user_phone` VARCHAR(11) NOT NULL,
    `image_path` VARCHAR(255) NOT NULL,
    `is_deleted` BOOLEAN DEFAULT FALSE,
    `deleted_at` DATETIME,
    `neighborhood_id` INT UNSIGNED NOT NULL,
    CONSTRAINT fk_neighborhood_id FOREIGN KEY (neighborhood_id) REFERENCES neighborhood(neighborhood_id)
);

CREATE TABLE IF NOT EXISTS `pet` (
	`pet_id` INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `pet_name` VARCHAR(100) NOT NULL,
    `pet_sex` BOOLEAN NOT NULL,
    `pet_age` TINYINT UNSIGNED NOT NULL,
    CHECK (`pet_age` BETWEEN 0 AND 4),
    `pet_reason` TEXT,
    `pet_personality` TEXT NOT NULL,
    `pet_temper` TEXT,
    `pet_people` TINYINT UNSIGNED,
    CHECK (`pet_people` BETWEEN 0 AND 4),
    `pet_others` TINYINT UNSIGNED,
    CHECK (`pet_others` BETWEEN 0 AND 4),
    `pet_environment` TEXT,
    `pet_needs` TEXT,
    `pet_microchip` BOOLEAN,
    `pet_items` TEXT,
    `pet_vaccination` TEXT,
    `pet_history` TEXT,
    `pet_breed` VARCHAR(50) NOT NULL,
    `is_deleted` BOOLEAN DEFAULT FALSE,
    `deleted_at` DATETIME,
    `user_id` INT UNSIGNED NOT NULL,
    CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES `user`(user_id),
    `pet_category_id` TINYINT UNSIGNED NOT NULL,
    CONSTRAINT fk_pet_category_id FOREIGN KEY (pet_category_id) REFERENCES `pet_category`(category_id)
);

CREATE TABLE IF NOT EXISTS `pet_image` (
	`image_id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `image_path` VARCHAR(255) NOT NULL,
    `pet_id` INT UNSIGNED NOT NULL,
    CONSTRAINT fk_pet_id FOREIGN KEY (pet_id) REFERENCES pet(pet_id)
);

DELIMITER $$
CREATE TRIGGER `check_max_images`
BEFORE INSERT ON pet_image
FOR EACH ROW
BEGIN
    DECLARE image_count INT;

    -- Contar o número de imagens já associadas ao pet
    SELECT COUNT(*) INTO image_count
    FROM pet_image
    WHERE pet_id = NEW.pet_id;

    -- Se o pet já tem 3 imagens, impedir a inserção
    IF image_count >= 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O pet já excedeu 3 imagens.';
    END IF;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `soft_delete_pet`(IN input_pet_id INT)
BEGIN
	-- Atualiza o pet, marcando-o como deletado
    UPDATE pet
    SET `is_deleted` = TRUE, `deleted_at` = NOW()
    WHERE `pet_id` = input_pet_id;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `soft_delete_user`(IN input_user_id INT)
BEGIN
    -- Atualiza todos os pets vinculados ao usuário, marcando-os como deletados
    UPDATE pet
    SET is_deleted = TRUE, deleted_at = NOW()
    WHERE user_id = input_user_id;
    
    -- Agora, marca o usuário como deletado
    UPDATE user
    SET is_deleted = TRUE, deleted_at = NOW()
    WHERE user_id = input_user_id;
END $$
DELIMITER ;

##### Inserts

INSERT INTO `city` (`city_name`) VALUES ('São Vicente');
INSERT INTO `city` (`city_name`) VALUES ('Santos');
INSERT INTO `city` (`city_name`) VALUES ('Praia Grande');

INSERT INTO `neighborhood` (`neighborhood_name`, `city_id`) VALUES ('Centro', 1);
INSERT INTO `neighborhood` (`neighborhood_name`, `city_id`) VALUES ('Guilhermina', 3);
INSERT INTO `neighborhood` (`neighborhood_name`, `city_id`) VALUES ('Boqueirão', 2);
INSERT INTO `neighborhood` (`neighborhood_name`, `city_id`) VALUES ('Boqueirão', 3);
INSERT INTO `neighborhood` (`neighborhood_name`, `city_id`) VALUES ('José Menino', 2);
INSERT INTO `neighborhood` (`neighborhood_name`, `city_id`) VALUES ('Catiapoã', 1);
INSERT INTO `neighborhood` (`neighborhood_name`, `city_id`) VALUES ('Esmeralda', 3);
INSERT INTO `neighborhood` (`neighborhood_name`, `city_id`) VALUES ('Quarentenário', 1);

INSERT INTO `user` (`user_name`, `user_email`, `user_password`, `user_phone`, `image_path`, `neighborhood_id`)
	VALUES ('Guilherme Souza', 'guil@gmail.com', '123', '13981626000', 'public-path', 1);
INSERT INTO `user` (`user_name`, `user_email`, `user_password`, `user_phone`, `image_path`, `neighborhood_id`)
	VALUES ('Kervia Monic', 'kervia@gmail.com', '456', '13991279983', 'public-path', 6);
INSERT INTO `user` (`user_name`, `user_email`, `user_password`, `user_phone`, `image_path`, `neighborhood_id`)
	VALUES ('Angelo Marcio', 'angelo@gmail.com', '789', '13996289379', 'public-path', 7);

INSERT INTO `pet_category` (`category_name`)
	VALUES ('Cachorro');
INSERT INTO `pet_category` (`category_name`)
	VALUES ('Gato');
INSERT INTO `pet_category` (`category_name`)
	VALUES ('Roedor');
INSERT INTO `pet_category` (`category_name`)
	VALUES ('Pássaro');
    
INSERT INTO `pet` (	`pet_name`, `pet_sex`,  `pet_age`,  `pet_reason`,  `pet_personality`, `pet_temper`,  `pet_people`,  `pet_others`,  `pet_environment`, 
					`pet_needs`,  `pet_microchip`,  `pet_items`,  `pet_vaccination`,  `pet_history`,  `pet_breed`,
                    `user_id`, `pet_category_id`)
	VALUES ('Mia', 0, 4, 'Vou viajar e não posso levá-la', 'Muito calma e quieta', 'Quando ela quer, ela pede carinho', 4, 1, 'Apartamento',
			'Nada muito caro, ela gosta de caixa de papelão', 0, 'Potinho de comida e uma caminha vermelha', 'Todas as vacinas foram dadas', '', 'Munchkin',
            1, 2);

INSERT INTO `pet` (	`pet_name`, `pet_sex`,  `pet_age`,  `pet_reason`,  `pet_personality`, `pet_temper`,  `pet_people`,  `pet_others`,  `pet_environment`, 
					`pet_needs`,  `pet_microchip`,  `pet_items`,  `pet_vaccination`,  `pet_history`,  `pet_breed`,
                    `user_id`, `pet_category_id`)
	VALUES ('Sheldon', 1, 1, 'No prédio não pode animais...', 'Brincalhão e curioso', 'Gosta de carinho o tempo todo e comer mamão', 4, 4, 'Quintal com bastante espaço',
			'Caixa de papelão', 1, 'Bolinha e potes', 'Todas', 'Nasceu feio mas agora tá gatão', 'SRD (Sem Raça Definida)', 
            2, 2);
            
INSERT INTO `pet` (	`pet_name`, `pet_sex`,  `pet_age`,  `pet_reason`,  `pet_personality`, `pet_temper`,  `pet_people`,  `pet_others`,  `pet_environment`, 
					`pet_needs`,  `pet_microchip`,  `pet_items`,  `pet_vaccination`,  `pet_history`,  `pet_breed`,
                    `user_id`, `pet_category_id`)
	VALUES ('Bob', 1, 2, 'Doação consciente', 'Calmo e tranquilo', 'Não gosta de muito carinho na barriga', 0, 0, 'Lugar calmo e sem barulho de preferência',
			'Gosta de ficar sozinho', 0, 'Meio kg de ração', 'Sem informação', 'Sem informação', 'SRD (Sem Raça Definida)', 
            3, 1);
            
INSERT INTO `pet` (	`pet_name`, `pet_sex`,  `pet_age`,  `pet_reason`,  `pet_personality`, `pet_temper`,  `pet_people`,  `pet_others`,  `pet_environment`, 
					`pet_needs`,  `pet_microchip`,  `pet_items`,  `pet_vaccination`,  `pet_history`,  `pet_breed`,
                    `user_id`, `pet_category_id`)
	VALUES ('Belinha', 2, 3, 'Minha tia não pode mais tê-la', 'Só fica agitada quando vem visita em casa', 'Gosta de pegar sol', 4, 3, 'Cerca e portão fechado, ela foge se deixar',
			'Late quando falamos com ela', 0, 'Ração e pote para água', 'Sem informação', 'Sem informação', 'Poodle', 
            3, 1);

INSERT INTO `pet_image` (`image_path`, `pet_id`)
	VALUES ('C:/imagens/mia.png', 1);

INSERT INTO `pet_image` (`image_path`, `pet_id`)
	VALUES ('C:/imagens/mia-2.png', 1);
    
INSERT INTO `pet_image` (`image_path`, `pet_id`)
	VALUES ('D:/computador/sheldon.jpg', 2);
    
INSERT INTO `pet_image` (`image_path`, `pet_id`)
	VALUES ('D:/computador/sheldon-2.jpg', 2);
    
INSERT INTO `pet_image` (`image_path`, `pet_id`)
	VALUES ('D:/computador/sheldon-3.jpg', 2);

##### Selects

SELECT * FROM `city`;

SELECT n.neighborhood_id as `Identificador`, n.neighborhood_name as `Bairro`, n.city_id as `Id. Cidade`, c.city_name as `Cidade` FROM `neighborhood` n
	JOIN `city` c ON c.city_id = n.city_id;
    
SELECT * FROM `pet_category`;

SELECT * FROM `pet_image`;

SELECT pi.image_path as `Path da imagem`, p.pet_name as `Nome do pet` FROM `pet_image` pi
	JOIN `pet` p ON p.pet_id = pi.pet_id;

SELECT * FROM `pet`;

SELECT * FROM `user`;

SELECT p.pet_name as `Nome do pet`, u.user_name as `Doador` FROM `user` u
	JOIN `pet` p ON p.user_id = u.user_id;

##### Procedures testing

# CALL soft_delete_pet(2);
# CALL soft_delete_user(3);