CREATE SCHEMA `pizza_shop` ;

SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

CREATE TABLE `pizza_shop`.`customers` (
  `customer_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `phone_number` VARCHAR(45) NULL,
  PRIMARY KEY (`customer_id`));
  
  CREATE TABLE `pizza_shop`.`pizza` (
  `pizza_id` INT NOT NULL,
  `pizza_type` VARCHAR(45) NULL,
  `price` DECIMAL(3,2) NOT NULL,
  PRIMARY KEY (`pizza_id`));

  
  CREATE TABLE `pizza_shop`.`date_time` (
  `order_id` INT NOT NULL,
  `date_time` DATETIME NULL,
  PRIMARY KEY (`order_id`));


  
INSERT INTO `customers` (customer_id, `name`, phone_number)
VALUES (1, 'Trevor Page', '226-555-4982');
  
INSERT INTO `customers` (customer_id, `name`, phone_number)
VALUES (2, 'John Doe', '555-555-9498');
  
INSERT INTO `pizza` (pizza_id, pizza_type, price)
VALUES (1, 'Pepperoni & Cheese', 7.99);
  
INSERT INTO `pizza` (pizza_id, pizza_type, price)
VALUES (2, 'Vegetarian', 9.99);
  
INSERT INTO `pizza` (pizza_id, pizza_type, price)
VALUES (3, 'Meat Lovers', 14.99);
  
INSERT INTO `pizza` (pizza_id, pizza_type, price)
VALUES (4, 'Hawaiian', 12.99);
  
INSERT INTO `date_time` (order_id, date_time)
VALUES (1, '2014-09-10 09:47:00');

INSERT INTO `date_time` (order_id, date_time)
VALUES (2, '2014-09-10 13:20:00');
  
INSERT INTO `date_time` (order_id, date_time)
VALUES (3, '2014-09-10 09:47:00');

INSERT INTO `customer_orders` (order_id, customer_id)
VALUES (1, 1);

INSERT INTO `customer_orders` (order_id, customer_id)
VALUES (2, 2);

INSERT INTO `customer_orders` (order_id, customer_id)
VALUES (3, 1);

INSERT INTO `pizza_orders` (order_id, pizza_id1, pizza_id2)
VALUES(1, 1, 3); 

INSERT INTO `pizza_orders` (order_id, pizza_id1, pizza_id2, pizza_id3)
VALUES(2, 2, 3, 3); 

INSERT INTO `pizza_orders` (order_id, pizza_id1, pizza_id2)
VALUES(3, 3, 4); 
  
SELECT * FROM `customers`;
SELECT * FROM `pizza`;
SELECT * FROM `date_time`;
SELECT * FROM `customer_orders`;
SELECT * FROM `pizza_orders`;
  
CREATE TABLE `pizza_shop`.`customer_orders` (
  `order_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `customer_od_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `pizza_shop`.`date_time` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `pizza_shop`.`customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    CREATE TABLE `pizza_shop`.`pizza_orders` (
  `order_id` INT NOT NULL,
  `pizza_id1` INT NULL,
  `pizza_id2` INT NULL,
  `pizza_id3` INT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `pizza_id1_idx` (`pizza_id1` ASC) VISIBLE,
  INDEX `pizza_id2_idx` (`pizza_id2` ASC) VISIBLE,
  INDEX `pizza_id3_idx` (`pizza_id3` ASC) VISIBLE,
  CONSTRAINT `order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `pizza_shop`.`customer_orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `pizza_id1`
    FOREIGN KEY (`pizza_id1`)
    REFERENCES `pizza_shop`.`pizza` (`pizza_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `pizza_id2`
    FOREIGN KEY (`pizza_id2`)
    REFERENCES `pizza_shop`.`pizza` (`pizza_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `pizza_id3`
    FOREIGN KEY (`pizza_id3`)
    REFERENCES `pizza_shop`.`pizza` (`pizza_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

    
SELECT * FROM `customers` c
JOIN `customer_orders` co ON c.customer_id = co.customer_id
JOIN `date_time` dt ON dt.order_id = co.order_id
JOIN `pizza_orders` po ON po.order_id = dt.order_id
JOIN `pizza` p ON p.pizza_id = po.pizza_id1 AND po.pizza_id2
GROUP BY po.order_id; 

SELECT * FROM customer_orders co
JOIN `pizza_orders` po ON co.order_id = po.order_id
JOIN `pizza` p ON p.pizza_id = po.pizza_id1;

SELECT sum(price) FROM pizza p
JOIN `pizza_orders` po ON p.pizza_id = po.pizza_id1
JOIN `; 






