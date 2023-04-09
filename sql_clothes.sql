-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


-- -----------------------------------------------------
-- Table `clothes`.`color`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clothes`.`color` ;

CREATE TABLE IF NOT EXISTS `clothes`.`color` (
  `color_id` INT NOT NULL AUTO_INCREMENT,
  `color_value` VARCHAR(10) NOT NULL,
  `color_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`color_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clothes`.`characteristics`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clothes`.`characteristics` ;

CREATE TABLE IF NOT EXISTS `clothes`.`characteristics` (
  `characteristics_id` INT NOT NULL AUTO_INCREMENT,
  `characteristics_material` VARCHAR(20) NOT NULL,
  `characteristics_fasteners` VARCHAR(20) NULL DEFAULT 'нет',
  `characteristics_picture` VARCHAR(25) NULL DEFAULT 'нет',
  `characteristics_gender` VARCHAR(15) NULL DEFAULT 'унисекс',
  `characteristics_season` VARCHAR(35) NOT NULL DEFAULT 'круглогидичный сезон',
  `characteristics_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`characteristics_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clothes`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clothes`.`product` ;

CREATE TABLE IF NOT EXISTS `clothes`.`product` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(45) NULL,
  `product_url` VARCHAR(255) NULL,
  `product_url_back` VARCHAR(255) NULL,
  `product_url_addtional` VARCHAR(255) NULL,
  `product_price` INT NULL,
  `product_description` TEXT(1000) NULL,
  `color_color_id` INT NOT NULL,
  `characteristics_characteristics_id` INT NOT NULL,
  INDEX `fk_product_color1_idx` (`color_color_id` ASC) VISIBLE,
  INDEX `fk_product_characteristics1_idx` (`characteristics_characteristics_id` ASC) VISIBLE,
  PRIMARY KEY (`product_id`),
  CONSTRAINT `fk_product_color1`
    FOREIGN KEY (`color_color_id`)
    REFERENCES `clothes`.`color` (`color_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_characteristics1`
    FOREIGN KEY (`characteristics_characteristics_id`)
    REFERENCES `clothes`.`characteristics` (`characteristics_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clothes`.`size`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clothes`.`size` ;

CREATE TABLE IF NOT EXISTS `clothes`.`size` (
  `size_id` INT NOT NULL,
  `size_value` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`size_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clothes`.`client`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clothes`.`client` ;

CREATE TABLE IF NOT EXISTS `clothes`.`client` (
  `client_id` INT NOT NULL AUTO_INCREMENT,
  `client_name` VARCHAR(45) NOT NULL,
  `client_surname` VARCHAR(45) NOT NULL,
  `client_patronymic` VARCHAR(45) NOT NULL,
  `client_mail` VARCHAR(255) NOT NULL,
  `client_password` VARCHAR(255) NOT NULL,
  `client_phone` VARCHAR(20) NOT NULL,
  `client_region` VARCHAR(255) NULL,
  `client_city` VARCHAR(255) NULL,
  `client_street` VARCHAR(255) NULL,
  `client_appartment` INT NULL,
  `client_house` VARCHAR(45) NULL,
  `client_index` INT NULL,
  `client_payment_method` INT(5) NULL DEFAULT 1,
  `client_snipping_method` INT(5) NULL DEFAULT 1,
  PRIMARY KEY (`client_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clothes`.`product_has_size`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clothes`.`product_has_size` ;

CREATE TABLE IF NOT EXISTS `clothes`.`product_has_size` (
  `size_size_id1` INT NOT NULL,
  `product_product_id` INT NOT NULL,
  INDEX `fk_product_has_size_size1_idx` (`size_size_id1` ASC) VISIBLE,
  INDEX `fk_product_has_size_product1_idx` (`product_product_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_has_size_size1`
    FOREIGN KEY (`size_size_id1`)
    REFERENCES `clothes`.`size` (`size_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_has_size_product1`
    FOREIGN KEY (`product_product_id`)
    REFERENCES `clothes`.`product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clothes`.`basket`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clothes`.`basket` ;

CREATE TABLE IF NOT EXISTS `clothes`.`basket` (
  `id_product` INT NOT NULL,
  `client_client_id` INT NOT NULL,
  `basket_quantity` INT NOT NULL DEFAULT 1,
  `basket_id` INT NOT NULL AUTO_INCREMENT,
  `size_size_id` INT NOT NULL,
  INDEX `fk_product_id_idx` (`id_product` ASC) VISIBLE,
  INDEX `fk_basket_client1_idx` (`client_client_id` ASC) VISIBLE,
  PRIMARY KEY (`basket_id`),
  INDEX `fk_basket_size1_idx` (`size_size_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_id`
    FOREIGN KEY (`id_product`)
    REFERENCES `clothes`.`product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_basket_client1`
    FOREIGN KEY (`client_client_id`)
    REFERENCES `clothes`.`client` (`client_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_basket_size1`
    FOREIGN KEY (`size_size_id`)
    REFERENCES `clothes`.`size` (`size_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clothes`.`favorites`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clothes`.`favorites` ;

CREATE TABLE IF NOT EXISTS `clothes`.`favorites` (
  `client_client_id` INT NOT NULL,
  `product_product_id` INT NOT NULL,
  `favorites_id` INT NOT NULL AUTO_INCREMENT,
  INDEX `fk_client_has_product_product1_idx` (`product_product_id` ASC) VISIBLE,
  INDEX `fk_client_has_product_client1_idx` (`client_client_id` ASC) VISIBLE,
  PRIMARY KEY (`favorites_id`),
  CONSTRAINT `fk_client_has_product_client1`
    FOREIGN KEY (`client_client_id`)
    REFERENCES `clothes`.`client` (`client_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_client_has_product_product1`
    FOREIGN KEY (`product_product_id`)
    REFERENCES `clothes`.`product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clothes`.`Purchases`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clothes`.`Purchases` ;

CREATE TABLE IF NOT EXISTS `clothes`.`Purchases` (
  `client_client_id` INT NOT NULL,
  `product_product_id` INT NOT NULL,
  `Purchases_id` INT NOT NULL AUTO_INCREMENT,
  `Purchases_stast` DATETIME NOT NULL,
  `Purchases_end` DATETIME NULL,
  `Purchases_status` VARCHAR(45) NOT NULL DEFAULT '1',
  `size_size_id` INT NOT NULL,
  INDEX `fk_client_has_product_product2_idx` (`product_product_id` ASC) VISIBLE,
  INDEX `fk_client_has_product_client2_idx` (`client_client_id` ASC) VISIBLE,
  PRIMARY KEY (`Purchases_id`),
  INDEX `fk_Purchases_size1_idx` (`size_size_id` ASC) VISIBLE,
  CONSTRAINT `fk_client_has_product_client2`
    FOREIGN KEY (`client_client_id`)
    REFERENCES `clothes`.`client` (`client_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_client_has_product_product2`
    FOREIGN KEY (`product_product_id`)
    REFERENCES `clothes`.`product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Purchases_size1`
    FOREIGN KEY (`size_size_id`)
    REFERENCES `clothes`.`size` (`size_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `clothes` ;

-- -----------------------------------------------------
-- procedure getAllProduct
-- -----------------------------------------------------

USE `clothes`;
DROP procedure IF EXISTS `clothes`.`getAllProduct`;

DELIMITER $$
USE `clothes`$$
CREATE PROCEDURE getAllProduct()
BEGIN
	SELECT product_id,product_name,product_url,product_url_back,product_price FROM clothes.product;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure getListProduct
-- -----------------------------------------------------

USE `clothes`;
DROP procedure IF EXISTS `clothes`.`getListProduct`;

DELIMITER $$
USE `clothes`$$
CREATE PROCEDURE getListProduct()
BEGIN
	SELECT product_id,product_name,product_url,product_url_back,product_price FROM clothes.product;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure getProduct
-- -----------------------------------------------------

USE `clothes`;
DROP procedure IF EXISTS `clothes`.`getProduct`;

DELIMITER $$
USE `clothes`$$
CREATE PROCEDURE getProduct(IN user_id INT,IN pro_id INT)
BEGIN
    SELECT product_id,product_name,product_url,product_url_back,product_url_addtional,
    product_price,product_description, characteristics_material, characteristics_fasteners,characteristics_picture,
    characteristics_gender,characteristics_season,color_value, 
    EXISTS(SELECT * FROM `clothes`.`favorites`, `clothes`.`client`, `clothes`.`product` 
    WHERE product_id = product_product_id AND user_id = client_client_id AND pro_id = product_id ) AS favorite_boulean,
    CASE WHEN product_id = (SELECT product_product_id FROM `clothes`.`favorites` WHERE product_product_id = pro_id AND client_client_id = user_id)
    THEN (SELECT favorites_id FROM `clothes`.`favorites` WHERE product_product_id = product_id AND client_client_id = user_id) ELSE NULL END as favorites_id
    FROM `clothes`.`product`,`clothes`.`characteristics`,`clothes`.`color` 
    WHERE characteristics_id = characteristics_characteristics_id AND color_color_id = color_id AND product_id = pro_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure getProductWithFilter
-- -----------------------------------------------------

USE `clothes`;
DROP procedure IF EXISTS `clothes`.`getProductWithFilter`;

DELIMITER $$
USE `clothes`$$
CREATE PROCEDURE getProductWithFilter(IN product_id INT)
BEGIN
SELECT product_id,product_name,product_url,product_url_back,product_price 
	FROM clothes.product, clothes.characteristics ,clothes.color, clothes.size, clothes.product_has_size
	WHERE characteristics_characteristics_id = characteristics_id 
		AND  color_color_id = color_id
		AND (size_id = size_size_id1 AND product_id = product_product_id)
		AND (characteristics_material = 'хлопок' OR characteristics_material = 'полиэстер')
		AND (characteristics_fasteners = 'пуговицы' OR characteristics_fasteners = 'молния')
		AND (characteristics_picture = 'вельветовая рубашка' OR characteristics_picture = '1')
		AND (characteristics_gender = 'мужской' OR characteristics_gender = '1')
		AND (characteristics_season = 'круглогидичный сезон' OR characteristics_season = '1')
		AND (characteristics_type = 'рубашка' OR characteristics_type = 'зип-худи')
	GROUP BY product_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure User
-- -----------------------------------------------------

USE `clothes`;
DROP procedure IF EXISTS `clothes`.`User`;

DELIMITER $$
USE `clothes`$$
CREATE PROCEDURE User()
BEGIN
	SELECT product_id,product_name,product_url,product_url_back,product_price FROM clothes.product;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure UserEntry
-- -----------------------------------------------------

USE `clothes`;
DROP procedure IF EXISTS `clothes`.`UserEntry`;

DELIMITER $$
USE `clothes`$$
CREATE PROCEDURE UserEntry()
BEGIN
	SELECT * FROM clothes.client;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure UserInfo
-- -----------------------------------------------------

USE `clothes`;
DROP procedure IF EXISTS `clothes`.`UserInfo`;

DELIMITER $$
USE `clothes`$$
CREATE PROCEDURE UserInfo(IN user_id INT)
BEGIN
	SELECT * FROM clothes.client WHERE client_id = user_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure UpdateUser
-- -----------------------------------------------------

USE `clothes`;
DROP procedure IF EXISTS `clothes`.`UpdateUser`;

DELIMITER $$
USE `clothes`$$
CREATE PROCEDURE UpdateUser(IN user_id INT)
BEGIN
	SELECT * FROM clothes.client WHERE client_id = user_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure UpdateUserProfile
-- -----------------------------------------------------

USE `clothes`;
DROP procedure IF EXISTS `clothes`.`UpdateUserProfile`;

DELIMITER $$
USE `clothes`$$
CREATE PROCEDURE UpdateUserProfile(IN new_phone NVARCHAR(255), IN new_mail NVARCHAR(255), IN user_id INT)
BEGIN
	UPDATE clothes.client SET client_mail = new_phone , client_phone = new_mail WHERE client_id = user_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure UpdateUserAddress
-- -----------------------------------------------------

USE `clothes`;
DROP procedure IF EXISTS `clothes`.`UpdateUserAddress`;

DELIMITER $$
USE `clothes`$$
CREATE PROCEDURE UpdateUserAddress(IN new_region NVARCHAR(255),IN new_city NVARCHAR(255), IN new_street NVARCHAR(255),IN new_house INT,IN new_appartment INT,IN new_index INT,IN new_payment_method INT,IN new_snipping_method INT, IN user_id INT)
BEGIN
    UPDATE clothes.client SET
    client_region = new_region , client_city = new_city ,client_street = new_street , client_house = new_house ,
    client_appartment = new_appartment, client_index = new_index, client_payment_method = new_payment_method, client_snipping_method = new_snipping_method 
    WHERE client_id = user_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure getListBasket
-- -----------------------------------------------------

USE `clothes`;
DROP procedure IF EXISTS `clothes`.`getListBasket`;

DELIMITER $$
USE `clothes`$$
CREATE PROCEDURE getListBasket(IN user_id INT)
BEGIN
	SELECT product_id, product_name ,product_url,product_url_back,
    product_price,size_value,color_value,basket_quantity,basket_id,siz.size_id
    FROM clothes.basket AS bas 
    INNER JOIN clothes.client AS cli 
    INNER JOIN clothes.product AS pro 
    INNER JOIN clothes.size AS siz 
    INNER JOIN clothes.color AS col 
    ON cli.client_id = client_client_id 
    AND col.color_id = pro.color_color_id 
    AND bas.size_size_id = siz.size_id 
    AND pro.product_id = bas.id_product 
    AND cli.client_id = user_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure addListBasket
-- -----------------------------------------------------

USE `clothes`;
DROP procedure IF EXISTS `clothes`.`addListBasket`;

DELIMITER $$
USE `clothes`$$
CREATE PROCEDURE addListBasket(IN id_product INT,IN client_client_id INT,IN basket_quantity INT,IN size_size_id INT)
BEGIN
	  INSERT INTO `clothes`.`basket` (`id_product`, `client_client_id`, `basket_quantity`, `size_size_id`) 
      VALUES (id_product, client_client_id, basket_quantity, size_size_id);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delitListBasket
-- -----------------------------------------------------

USE `clothes`;
DROP procedure IF EXISTS `clothes`.`delitListBasket`;

DELIMITER $$
USE `clothes`$$
CREATE PROCEDURE delitListBasket(IN id_basket INT)
BEGIN
	DELETE FROM `clothes`.`basket` WHERE basket_id = id_basket;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updateProductQuantity
-- -----------------------------------------------------

USE `clothes`;
DROP procedure IF EXISTS `clothes`.`updateProductQuantity`;

DELIMITER $$
USE `clothes`$$
CREATE PROCEDURE updateProductQuantity(IN new_quantity INT,IN id_basket INT)
BEGIN
    UPDATE clothes.basket SET basket_quantity=new_quantity WHERE basket_id=id_basket;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure getList
-- -----------------------------------------------------

USE `clothes`;
DROP procedure IF EXISTS `clothes`.`getList`;

DELIMITER $$
USE `clothes`$$
CREATE PROCEDURE getList(IN new_quantity INT,IN id_basket INT)
BEGIN
    UPDATE clothes.basket SET basket_quantity=new_quantity WHERE basket_id=id_basket;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure getListFavorites
-- -----------------------------------------------------

USE `clothes`;
DROP procedure IF EXISTS `clothes`.`getListFavorites`;

DELIMITER $$
USE `clothes`$$
CREATE PROCEDURE getListFavorites(IN user_id INT)
BEGIN
    SELECT product_id,product_name,product_url,product_url_back,product_price,color_value, favorites_id 
    FROM clothes.favorites AS fav 
    INNER JOIN clothes.client AS cli 
    INNER JOIN clothes.product AS pro 
    INNER JOIN clothes.color AS col 
    ON cli.client_id = fav.client_client_id 
    AND col.color_id = pro.color_color_id 
    AND pro.product_id = fav.product_product_id 
    AND cli.client_id = user_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure addListFavorites
-- -----------------------------------------------------

USE `clothes`;
DROP procedure IF EXISTS `clothes`.`addListFavorites`;

DELIMITER $$
USE `clothes`$$
CREATE PROCEDURE addListFavorites(IN client_id INT,IN product_id INT) 
BEGIN
        INSERT INTO `clothes`.`favorites` (`client_client_id`, `product_product_id`) VALUES (client_id,product_id);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure deliteListFavorites
-- -----------------------------------------------------

USE `clothes`;
DROP procedure IF EXISTS `clothes`.`deliteListFavorites`;

DELIMITER $$
USE `clothes`$$
CREATE PROCEDURE deliteListFavorites(IN id_favorites INT) 
BEGIN
    DELETE FROM `clothes`.`favorites` WHERE favorites_id = id_favorites;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure getPurchases
-- -----------------------------------------------------

USE `clothes`;
DROP procedure IF EXISTS `clothes`.`getPurchases`;

DELIMITER $$
USE `clothes`$$
CREATE PROCEDURE getPurchases(IN id_client INT)
BEGIN
    SELECT product_id,product_name,product_url,product_url_back,product_price,
    size_value,Purchases_stast,Purchases_end,Purchases_status
    FROM clothes.purchases AS pur 
    INNER JOIN clothes.client AS cli 
    INNER JOIN clothes.product AS pro 
    INNER JOIN clothes.size AS siz 
    ON cli.client_id = client_client_id 
    AND pur.size_size_id = siz.size_id 
    AND pro.product_id = pur.product_product_id 
    AND cli.client_id = id_client;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure getProductSize
-- -----------------------------------------------------

USE `clothes`;
DROP procedure IF EXISTS `clothes`.`getProductSize`;

DELIMITER $$
USE `clothes`$$
CREATE PROCEDURE getProductSize(IN pro_id INT)
BEGIN
    SELECT size_value,size_id FROM clothes.product , clothes.product_has_size, clothes.size 
	WHERE product_id = product_product_id AND size_size_id1 = size_id 
	AND product_id = pro_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure FilterParams
-- -----------------------------------------------------

USE `clothes`;
DROP procedure IF EXISTS `clothes`.`FilterParams`;

DELIMITER $$
USE `clothes`$$
CREATE PROCEDURE FilterParams(IN client_id INT,IN product_id INT) 
BEGIN
        INSERT INTO `clothes`.`favorites` (`client_client_id`, `product_product_id`) VALUES (client_id,product_id);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure addUser
-- -----------------------------------------------------

USE `clothes`;
DROP procedure IF EXISTS `clothes`.`addUser`;

DELIMITER $$
USE `clothes`$$
CREATE PROCEDURE addUser(IN new_name NVARCHAR(255),IN new_surname NVARCHAR(255), IN new_patronymic NVARCHAR(255), IN new_mail NVARCHAR(255), IN new_pass NVARCHAR(255), IN new_phone NVARCHAR(255))
BEGIN
	INSERT INTO `clothes`.`client` (`client_name`, `client_surname`, `client_patronymic`, `client_mail`, `client_password`, `client_phone`, `client_region`, `client_city`, `client_street`, `client_appartment`, `client_house`, `client_index`, `client_payment_method`, `client_snipping_method`) 
    VALUES (new_name, new_surname, new_patronymic, new_mail, new_pass, new_phone, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `clothes`.`color`
-- -----------------------------------------------------
START TRANSACTION;
USE `clothes`;
INSERT INTO `clothes`.`color` (`color_id`, `color_value`, `color_name`) VALUES (1, '#a7999b', 'бежевый');
INSERT INTO `clothes`.`color` (`color_id`, `color_value`, `color_name`) VALUES (2, '#000000', 'черный');
INSERT INTO `clothes`.`color` (`color_id`, `color_value`, `color_name`) VALUES (3, '#000000', '123');
INSERT INTO `clothes`.`color` (`color_id`, `color_value`, `color_name`) VALUES (4, '#000000', '123');
INSERT INTO `clothes`.`color` (`color_id`, `color_value`, `color_name`) VALUES (5, '#000000', '123');
INSERT INTO `clothes`.`color` (`color_id`, `color_value`, `color_name`) VALUES (6, '#93aeb1', 'мятный');
INSERT INTO `clothes`.`color` (`color_id`, `color_value`, `color_name`) VALUES (7, '#000000', 'черный');
INSERT INTO `clothes`.`color` (`color_id`, `color_value`, `color_name`) VALUES (8, '#765364', 'сиреневый');
INSERT INTO `clothes`.`color` (`color_id`, `color_value`, `color_name`) VALUES (9, '#615668', 'серый');
INSERT INTO `clothes`.`color` (`color_id`, `color_value`, `color_name`) VALUES (10, '#ffffff', 'белый');
INSERT INTO `clothes`.`color` (`color_id`, `color_value`, `color_name`) VALUES (11, '#4d3d40', 'коричневый');
INSERT INTO `clothes`.`color` (`color_id`, `color_value`, `color_name`) VALUES (12, '#ffffff', 'белый');
INSERT INTO `clothes`.`color` (`color_id`, `color_value`, `color_name`) VALUES (13, '#ec5669', 'коралловый');
INSERT INTO `clothes`.`color` (`color_id`, `color_value`, `color_name`) VALUES (14, '#93aeb1', 'мятный');
INSERT INTO `clothes`.`color` (`color_id`, `color_value`, `color_name`) VALUES (15, '#23242b', 'черный');
INSERT INTO `clothes`.`color` (`color_id`, `color_value`, `color_name`) VALUES (16, '#ffffff', 'белый');
INSERT INTO `clothes`.`color` (`color_id`, `color_value`, `color_name`) VALUES (17, '#000000', 'черный');

COMMIT;


-- -----------------------------------------------------
-- Data for table `clothes`.`characteristics`
-- -----------------------------------------------------
START TRANSACTION;
USE `clothes`;
INSERT INTO `clothes`.`characteristics` (`characteristics_id`, `characteristics_material`, `characteristics_fasteners`, `characteristics_picture`, `characteristics_gender`, `characteristics_season`, `characteristics_type`) VALUES (1, 'полиэстер', 'пуговицы', 'вельветовая рубашка', 'мужской', 'круглогодичный', 'рубашка');
INSERT INTO `clothes`.`characteristics` (`characteristics_id`, `characteristics_material`, `characteristics_fasteners`, `characteristics_picture`, `characteristics_gender`, `characteristics_season`, `characteristics_type`) VALUES (2, 'хлопок', 'молния', '', 'женский', 'демисезон', 'зип-худи');
INSERT INTO `clothes`.`characteristics` (`characteristics_id`, `characteristics_material`, `characteristics_fasteners`, `characteristics_picture`, `characteristics_gender`, `characteristics_season`, `characteristics_type`) VALUES (3, 'хлопок', '', 'готика', 'унисекс', 'круглогодичный', 'лонгслив');
INSERT INTO `clothes`.`characteristics` (`characteristics_id`, `characteristics_material`, `characteristics_fasteners`, `characteristics_picture`, `characteristics_gender`, `characteristics_season`, `characteristics_type`) VALUES (4, 'хлопок', '', '', 'женский', 'круглогодичный', 'лонгслив');
INSERT INTO `clothes`.`characteristics` (`characteristics_id`, `characteristics_material`, `characteristics_fasteners`, `characteristics_picture`, `characteristics_gender`, `characteristics_season`, `characteristics_type`) VALUES (5, 'полиэстер', '', '', 'женский', 'круглогодичный', 'водолазка');
INSERT INTO `clothes`.`characteristics` (`characteristics_id`, `characteristics_material`, `characteristics_fasteners`, `characteristics_picture`, `characteristics_gender`, `characteristics_season`, `characteristics_type`) VALUES (6, 'полиэстер', '', 'в клетку', 'женский', 'круглогодичный', 'рубашка');
INSERT INTO `clothes`.`characteristics` (`characteristics_id`, `characteristics_material`, `characteristics_fasteners`, `characteristics_picture`, `characteristics_gender`, `characteristics_season`, `characteristics_type`) VALUES (7, 'полиэстер', '', '', 'мужской', 'круглогодичный', 'рубашка');
INSERT INTO `clothes`.`characteristics` (`characteristics_id`, `characteristics_material`, `characteristics_fasteners`, `characteristics_picture`, `characteristics_gender`, `characteristics_season`, `characteristics_type`) VALUES (8, 'полиэстер', '', 'вельветовая рубашка', 'женский', 'круглогодичный', 'рубашка');
INSERT INTO `clothes`.`characteristics` (`characteristics_id`, `characteristics_material`, `characteristics_fasteners`, `characteristics_picture`, `characteristics_gender`, `characteristics_season`, `characteristics_type`) VALUES (9, 'хлопок', '', '', 'мужской', 'демисезон', 'худи');
INSERT INTO `clothes`.`characteristics` (`characteristics_id`, `characteristics_material`, `characteristics_fasteners`, `characteristics_picture`, `characteristics_gender`, `characteristics_season`, `characteristics_type`) VALUES (10, 'хлопок', '', '', 'мужской', 'демисезон', 'худи');
INSERT INTO `clothes`.`characteristics` (`characteristics_id`, `characteristics_material`, `characteristics_fasteners`, `characteristics_picture`, `characteristics_gender`, `characteristics_season`, `characteristics_type`) VALUES (11, 'хлопок', '', '', 'женский', 'демисезон', 'худи');
INSERT INTO `clothes`.`characteristics` (`characteristics_id`, `characteristics_material`, `characteristics_fasteners`, `characteristics_picture`, `characteristics_gender`, `characteristics_season`, `characteristics_type`) VALUES (12, 'хлопок', '', 'готика', 'мужской', 'круглогодичный', 'футболка');
INSERT INTO `clothes`.`characteristics` (`characteristics_id`, `characteristics_material`, `characteristics_fasteners`, `characteristics_picture`, `characteristics_gender`, `characteristics_season`, `characteristics_type`) VALUES (13, 'хлопок', '', '', 'женский', 'демисезон', 'футболка');
INSERT INTO `clothes`.`characteristics` (`characteristics_id`, `characteristics_material`, `characteristics_fasteners`, `characteristics_picture`, `characteristics_gender`, `characteristics_season`, `characteristics_type`) VALUES (14, 'хлопок', '', '', 'женский', 'демисезон', 'футболка');
INSERT INTO `clothes`.`characteristics` (`characteristics_id`, `characteristics_material`, `characteristics_fasteners`, `characteristics_picture`, `characteristics_gender`, `characteristics_season`, `characteristics_type`) VALUES (15, 'джинса', 'молния', '', 'женский', 'демисезон', 'джинсы');
INSERT INTO `clothes`.`characteristics` (`characteristics_id`, `characteristics_material`, `characteristics_fasteners`, `characteristics_picture`, `characteristics_gender`, `characteristics_season`, `characteristics_type`) VALUES (16, 'джинса', 'молния', '', 'женский', 'демисезон', 'джинсы');
INSERT INTO `clothes`.`characteristics` (`characteristics_id`, `characteristics_material`, `characteristics_fasteners`, `characteristics_picture`, `characteristics_gender`, `characteristics_season`, `characteristics_type`) VALUES (17, 'джинса', 'молния', '', 'мужской', 'демисезон', 'джинсы');

COMMIT;


-- -----------------------------------------------------
-- Data for table `clothes`.`product`
-- -----------------------------------------------------
START TRANSACTION;
USE `clothes`;
INSERT INTO `clothes`.`product` (`product_id`, `product_name`, `product_url`, `product_url_back`, `product_url_addtional`, `product_price`, `product_description`, `color_color_id`, `characteristics_characteristics_id`) VALUES (1, 'Рубашка', 'https://basket-05.wb.ru/vol943/part94356/94356933/images/big/2.jpg', 'https://basket-05.wb.ru/vol943/part94356/94356933/images/big/1.jpg', 'https://basket-05.wb.ru/vol943/part94356/94356933/images/big/3.jpg', 1690, 'Качественная рубашка мужская вельветовая в стиле оверсайз, из микровельвета.', 1, 1);
INSERT INTO `clothes`.`product` (`product_id`, `product_name`, `product_url`, `product_url_back`, `product_url_addtional`, `product_price`, `product_description`, `color_color_id`, `characteristics_characteristics_id`) VALUES (2, 'Зип-худи', 'https://basket-08.wb.ru/vol1164/part116445/116445192/images/big/1.jpg', 'https://basket-08.wb.ru/vol1164/part116445/116445192/images/big/2.jpg', 'https://basket-08.wb.ru/vol1164/part116445/116445192/images/big/3.jpg', 1790, 'Толстовка на молнии теплая, мягкая и очень приятная на ощупь. Внутренняя сторона зипки выполнена из футера с начесом, который не даст вам замерзнуть в холодную ветреную погоду. Зипка-худи оверсайз отлично смотрится на всех типах фигуры — не сковывает движения и удобна в повседневной носке за счет своего свободного кроя.', 2, 2);
INSERT INTO `clothes`.`product` (`product_id`, `product_name`, `product_url`, `product_url_back`, `product_url_addtional`, `product_price`, `product_description`, `color_color_id`, `characteristics_characteristics_id`) VALUES (3, 'Лонгслив', 'https://basket-09.wb.ru/vol1249/part124925/124925408/images/big/3.jpg', 'https://basket-09.wb.ru/vol1249/part124925/124925408/images/big/4.jpg', 'https://basket-09.wb.ru/vol1249/part124925/124925408/images/big/5.jpg', 1490, NULL, 3, 3);
INSERT INTO `clothes`.`product` (`product_id`, `product_name`, `product_url`, `product_url_back`, `product_url_addtional`, `product_price`, `product_description`, `color_color_id`, `characteristics_characteristics_id`) VALUES (4, 'Лонгслив', 'https://basket-03.wb.ru/vol381/part38155/38155246/images/big/1.jpg', 'https://basket-03.wb.ru/vol381/part38155/38155246/images/big/2.jpg', 'https://basket-03.wb.ru/vol381/part38155/38155246/images/big/3.jpg', 1300, 'Свободный лонгслив женский не имеет застёжки, карманов и капюшона, а низ изделия и рукавов выполнены с НЕОБРАБОТАННЫМИ КРАЯМИ.', 4, 4);
INSERT INTO `clothes`.`product` (`product_id`, `product_name`, `product_url`, `product_url_back`, `product_url_addtional`, `product_price`, `product_description`, `color_color_id`, `characteristics_characteristics_id`) VALUES (5, 'Водолазка', 'https://basket-03.wb.ru/vol419/part41962/41962183/images/big/1.jpg', 'https://basket-03.wb.ru/vol419/part41962/41962183/images/big/2.jpg', 'https://basket-03.wb.ru/vol419/part41962/41962183/images/big/3.jpg', 1590, NULL, 5, 5);
INSERT INTO `clothes`.`product` (`product_id`, `product_name`, `product_url`, `product_url_back`, `product_url_addtional`, `product_price`, `product_description`, `color_color_id`, `characteristics_characteristics_id`) VALUES (6, 'Рубашка', 'https://basket-02.wb.ru/vol178/part17890/17890490/images/big/1.jpg', 'https://basket-02.wb.ru/vol178/part17890/17890490/images/big/2.jpg', 'https://basket-02.wb.ru/vol178/part17890/17890490/images/big/3.jpg', 1890, 'Удлиненная фланелевая рубашка с принтом в клетку в стиле оверсайз - это модный тренд сезонов осень - зима 2022 - 2023! Стильная рубашка изготовлена из теплой, плотной, мягкой, дышащей и приятной телу ткани.', 6, 6);
INSERT INTO `clothes`.`product` (`product_id`, `product_name`, `product_url`, `product_url_back`, `product_url_addtional`, `product_price`, `product_description`, `color_color_id`, `characteristics_characteristics_id`) VALUES (7, 'Рубашка', 'https://basket-03.wb.ru/vol341/part34133/34133608/images/big/1.jpg', 'https://basket-03.wb.ru/vol341/part34133/34133608/images/big/2.jpg', 'https://basket-03.wb.ru/vol341/part34133/34133608/images/big/3.jpg', 2190, ' В такой рубашке Вы будете чувствовать себя всегда элегантным и на высоте! ', 7, 7);
INSERT INTO `clothes`.`product` (`product_id`, `product_name`, `product_url`, `product_url_back`, `product_url_addtional`, `product_price`, `product_description`, `color_color_id`, `characteristics_characteristics_id`) VALUES (8, 'Рубашка', 'https://basket-03.wb.ru/vol378/part37821/37821948/images/big/1.jpg', 'https://basket-03.wb.ru/vol378/part37821/37821948/images/big/2.jpg', 'https://basket-03.wb.ru/vol378/part37821/37821948/images/big/3.jpg', 2390, 'Рубашка женская из вельвета oversize свободного кроя хорошо сидит на любой фигуре, подходит для беременных, будущих мам, для девушек подростков и женщин. Рубашка из микровельвета - это модный и стильный тренд сезона!', 8, 8);
INSERT INTO `clothes`.`product` (`product_id`, `product_name`, `product_url`, `product_url_back`, `product_url_addtional`, `product_price`, `product_description`, `color_color_id`, `characteristics_characteristics_id`) VALUES (9, 'Худи', 'https://basket-03.wb.ru/vol356/part35675/35675795/images/big/1.jpg', 'https://basket-03.wb.ru/vol356/part35675/35675795/images/big/2.jpg', 'https://basket-03.wb.ru/vol356/part35675/35675795/images/big/3.jpg', 1315, 'Оверсайз худи, которое вы искали! Толстовка свободного силуэта, с увеличенной проймой, шириной рукавов и спущенной плечевой линией.', 9, 9);
INSERT INTO `clothes`.`product` (`product_id`, `product_name`, `product_url`, `product_url_back`, `product_url_addtional`, `product_price`, `product_description`, `color_color_id`, `characteristics_characteristics_id`) VALUES (10, 'Худи', 'https://basket-02.wb.ru/vol189/part18985/18985539/images/big/1.jpg', 'https://basket-02.wb.ru/vol189/part18985/18985539/images/big/2.jpg', 'https://basket-02.wb.ru/vol189/part18985/18985539/images/big/3.jpg', 1490, 'Оверсайз крой не сковывает движений, изделие хорошо держит форму. Толстовка из трикотажного футера с мягким начесом очень теплая и приятная к телу. Худи одинаково стильно будет смотреться на разных типах фигуры.', 10, 10);
INSERT INTO `clothes`.`product` (`product_id`, `product_name`, `product_url`, `product_url_back`, `product_url_addtional`, `product_price`, `product_description`, `color_color_id`, `characteristics_characteristics_id`) VALUES (11, 'Худи', 'https://basket-03.wb.ru/vol356/part35673/35673223/images/big/1.jpg', 'https://basket-03.wb.ru/vol356/part35673/35673223/images/big/2.jpg', 'https://basket-03.wb.ru/vol356/part35673/35673223/images/big/3.jpg', 1650, NULL, 11, 11);
INSERT INTO `clothes`.`product` (`product_id`, `product_name`, `product_url`, `product_url_back`, `product_url_addtional`, `product_price`, `product_description`, `color_color_id`, `characteristics_characteristics_id`) VALUES (12, 'Футболка', 'https://basket-08.wb.ru/vol1129/part112930/112930590/images/big/1.jpg', 'https://basket-08.wb.ru/vol1129/part112930/112930590/images/big/2.jpg', 'https://basket-08.wb.ru/vol1129/part112930/112930590/images/big/3.jpg', 790, 'Молодежная мужская футболка - это красивые насыщенные цвета и кайфовый дизайн, лучший принт, поэтому это та модная футболка с принтом, которая будет незаменимой в вашем гардеробе, поэтому даже не думай и заказывай белую футболку оверсайз.', 12, 12);
INSERT INTO `clothes`.`product` (`product_id`, `product_name`, `product_url`, `product_url_back`, `product_url_addtional`, `product_price`, `product_description`, `color_color_id`, `characteristics_characteristics_id`) VALUES (13, 'Футболка', 'https://basket-09.wb.ru/vol1201/part120103/120103090/images/big/1.jpg', 'https://basket-09.wb.ru/vol1201/part120103/120103090/images/big/2.jpg', 'https://basket-09.wb.ru/vol1201/part120103/120103090/images/big/3.jpg', 990, 'Одной из таких является однотонная футболка кроя оверсайз. С нашей комфортной удлиненной кофтой для женщин можно составить спортивный, деловой или повседневный образ.', 13, 13);
INSERT INTO `clothes`.`product` (`product_id`, `product_name`, `product_url`, `product_url_back`, `product_url_addtional`, `product_price`, `product_description`, `color_color_id`, `characteristics_characteristics_id`) VALUES (14, 'Футболка', 'https://basket-01.wb.ru/vol133/part13354/13354737/images/big/1.jpg', 'https://basket-01.wb.ru/vol133/part13354/13354737/images/big/4.jpg', 'https://basket-01.wb.ru/vol133/part13354/13354737/images/big/5.jpg', 1190, 'Невероятно комфортная, приятная к телу базовая футболка правильной длины. Ее удобно заправлять и носить навыпуск, отлично сочетается с юбкой, брюками с джинсами, а также можно надеть под пиджак, жакет или кардиган.', 14, 14);
INSERT INTO `clothes`.`product` (`product_id`, `product_name`, `product_url`, `product_url_back`, `product_url_addtional`, `product_price`, `product_description`, `color_color_id`, `characteristics_characteristics_id`) VALUES (15, 'Джинсы', 'https://basket-10.wb.ru/vol1386/part138609/138609205/images/big/2.jpg', 'https://basket-10.wb.ru/vol1386/part138609/138609205/images/big/3.jpg', 'https://basket-10.wb.ru/vol1386/part138609/138609205/images/big/5.jpg', 2490, 'Также прямые джинсы подойдут и девочкам подросткам. Короткие джинсы мом пользуются популярность не только из-за стиля, но и благодаря универсальности модели.', 15, 15);
INSERT INTO `clothes`.`product` (`product_id`, `product_name`, `product_url`, `product_url_back`, `product_url_addtional`, `product_price`, `product_description`, `color_color_id`, `characteristics_characteristics_id`) VALUES (16, 'Джинсы', 'https://basket-04.wb.ru/vol645/part64589/64589931/images/big/1.jpg', 'https://basket-04.wb.ru/vol645/part64589/64589931/images/big/2.jpg', 'https://basket-04.wb.ru/vol645/part64589/64589931/images/big/3.jpg', 1990, 'Джинсы с высокой посадкой из премиального хлопка.', 16, 16);
INSERT INTO `clothes`.`product` (`product_id`, `product_name`, `product_url`, `product_url_back`, `product_url_addtional`, `product_price`, `product_description`, `color_color_id`, `characteristics_characteristics_id`) VALUES (17, 'Джинсы', 'https://basket-07.wb.ru/vol1083/part108375/108375659/images/big/1.jpg', 'https://basket-07.wb.ru/vol1083/part108375/108375659/images/big/3.jpg', 'https://basket-07.wb.ru/vol1083/part108375/108375659/images/big/4.jpg', 2890, NULL, 17, 17);

COMMIT;


-- -----------------------------------------------------
-- Data for table `clothes`.`size`
-- -----------------------------------------------------
START TRANSACTION;
USE `clothes`;
INSERT INTO `clothes`.`size` (`size_id`, `size_value`) VALUES (1, 'XS');
INSERT INTO `clothes`.`size` (`size_id`, `size_value`) VALUES (2, 'S');
INSERT INTO `clothes`.`size` (`size_id`, `size_value`) VALUES (3, 'M');
INSERT INTO `clothes`.`size` (`size_id`, `size_value`) VALUES (4, 'L');
INSERT INTO `clothes`.`size` (`size_id`, `size_value`) VALUES (5, 'XL');
INSERT INTO `clothes`.`size` (`size_id`, `size_value`) VALUES (6, 'XXL');

COMMIT;


-- -----------------------------------------------------
-- Data for table `clothes`.`client`
-- -----------------------------------------------------
START TRANSACTION;
USE `clothes`;
INSERT INTO `clothes`.`client` (`client_id`, `client_name`, `client_surname`, `client_patronymic`, `client_mail`, `client_password`, `client_phone`, `client_region`, `client_city`, `client_street`, `client_appartment`, `client_house`, `client_index`, `client_payment_method`, `client_snipping_method`) VALUES (1, 'root', 'root', 'root', 'root@mail.ru', '1234', '89514788806', NULL, NULL, NULL, NULL, NULL, NULL, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `clothes`.`product_has_size`
-- -----------------------------------------------------
START TRANSACTION;
USE `clothes`;
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (1, 1);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (2, 1);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (3, 1);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (4, 1);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (5, 1);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (6, 1);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (2, 2);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (3, 2);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (5, 2);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (6, 2);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (1, 3);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (2, 3);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (3, 3);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (4, 3);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (5, 3);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (1, 4);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (1, 5);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (2, 5);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (3, 6);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (5, 6);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (6, 6);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (1, 2);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (2, 4);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (4, 6);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (1, 7);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (5, 7);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (6, 7);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (1, 8);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (2, 8);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (3, 8);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (4, 8);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (5, 8);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (1, 9);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (2, 9);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (3, 9);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (4, 9);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (5, 9);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (6, 9);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (2, 10);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (3, 10);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (4, 10);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (5, 10);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (6, 10);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (1, 11);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (2, 11);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (3, 11);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (4, 11);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (5, 11);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (6, 11);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (2, 12);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (3, 12);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (4, 12);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (5, 12);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (6, 12);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (1, 13);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (2, 13);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (3, 13);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (4, 13);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (5, 13);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (6, 13);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (2, 14);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (4, 14);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (5, 14);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (6, 14);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (2, 15);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (3, 15);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (4, 15);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (5, 15);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (3, 16);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (4, 16);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (5, 16);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (6, 16);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (1, 17);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (2, 17);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (3, 17);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (4, 17);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (5, 17);
INSERT INTO `clothes`.`product_has_size` (`size_size_id1`, `product_product_id`) VALUES (6, 17);

COMMIT;


-- -----------------------------------------------------
-- Data for table `clothes`.`basket`
-- -----------------------------------------------------
START TRANSACTION;
USE `clothes`;
INSERT INTO `clothes`.`basket` (`id_product`, `client_client_id`, `basket_quantity`, `basket_id`, `size_size_id`) VALUES (1, 1, 1, 1, 1);
INSERT INTO `clothes`.`basket` (`id_product`, `client_client_id`, `basket_quantity`, `basket_id`, `size_size_id`) VALUES (2, 1, 2, 2, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `clothes`.`favorites`
-- -----------------------------------------------------
START TRANSACTION;
USE `clothes`;
INSERT INTO `clothes`.`favorites` (`client_client_id`, `product_product_id`, `favorites_id`) VALUES (1, 1, DEFAULT);
INSERT INTO `clothes`.`favorites` (`client_client_id`, `product_product_id`, `favorites_id`) VALUES (1, 2, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `clothes`.`Purchases`
-- -----------------------------------------------------
START TRANSACTION;
USE `clothes`;
INSERT INTO `clothes`.`Purchases` (`client_client_id`, `product_product_id`, `Purchases_id`, `Purchases_stast`, `Purchases_end`, `Purchases_status`, `size_size_id`) VALUES (1, 1, 1, '2023-03-05 13:00:00', NULL, '1', 1);
INSERT INTO `clothes`.`Purchases` (`client_client_id`, `product_product_id`, `Purchases_id`, `Purchases_stast`, `Purchases_end`, `Purchases_status`, `size_size_id`) VALUES (1, 2, 2, '2022-08-13 15:00:00', NULL, '2', 2);
INSERT INTO `clothes`.`Purchases` (`client_client_id`, `product_product_id`, `Purchases_id`, `Purchases_stast`, `Purchases_end`, `Purchases_status`, `size_size_id`) VALUES (1, 3, 3, '2022-04-24 17:00:00', NULL, '3', 3);
INSERT INTO `clothes`.`Purchases` (`client_client_id`, `product_product_id`, `Purchases_id`, `Purchases_stast`, `Purchases_end`, `Purchases_status`, `size_size_id`) VALUES (1, 4, 4, '2022-06-20 19:00:00', NULL, '4', 4);
INSERT INTO `clothes`.`Purchases` (`client_client_id`, `product_product_id`, `Purchases_id`, `Purchases_stast`, `Purchases_end`, `Purchases_status`, `size_size_id`) VALUES (1, 5, 5, '2022-07-26 21:00:00', NULL, '5', 5);

COMMIT;

