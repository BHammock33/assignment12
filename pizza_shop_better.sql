CREATE SCHEMA `pizza_shop` ;

SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

CREATE TABLE `pizza_shop`.`customers` (
  `customer_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `phone_number` VARCHAR(45) NULL,
  PRIMARY KEY (`customer_id`));
  
 CREATE TABLE `pizza_shop`.`orders` (
  `order_id` INT NOT NULL,
  `date` DATETIME NULL,
  PRIMARY KEY (`order_id`)); 
  
 CREATE TABLE `pizza_shop`.`pizzas` (
  `pizza_id` INT NOT NULL,
  `type` VARCHAR(45) NULL,
  `price` DECIMAL(5,2) NULL,
  PRIMARY KEY (`pizza_id`));
  
CREATE TABLE `pizza_shop`.`customer_orders` (
  `customer_id` INT NOT NULL,
  `order_id` INT NULL,
  FOREIGN KEY (customer_id) REFERENCES `customers` (customer_id),
  FOREIGN KEY (order_id) REFERENCES `orders` (order_id));
    
CREATE TABLE `pizza_shop`.`pizza_orders` (
  `pizza_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  FOREIGN KEY (pizza_id) REFERENCES `pizzas` (pizza_id),
  FOREIGN KEY (order_id) REFERENCES `orders` (order_id));
  
  SELECT * FROM `customers`;
  SELECT * FROM `pizzas`;
  SELECT * FROM `orders`;
  SELECT * FROM `customer_orders`;
  SELECT * FROM `pizza_orders`;
  
 INSERT INTO pizza_shop.customers(customer_id, `name`, phone_number)
 VALUES (1, 'Trevor Page', '226-555-4982');
 
INSERT INTO pizza_shop.customers(customer_id, `name`, phone_number)
VALUES (2, 'John Doe', '555-555-9498');
 
INSERT INTO pizza_shop.pizzas(pizza_id, `type`, price)
VALUES (1, 'Pepperoni & Cheese', 7.99);

INSERT INTO pizza_shop.pizzas(pizza_id, `type`, price)
VALUES (2, 'Vegetarian', 9.99);

INSERT INTO pizza_shop.pizzas(pizza_id, `type`, price)
VALUES (3, 'Meat Lovers', 14.99);

INSERT INTO pizza_shop.pizzas(pizza_id, `type`, price)
VALUES (4, 'Hawaiian', 12.99);

INSERT INTO pizza_shop.pizzas(pizza_id, `type`, price)
VALUES (4, 'Hawaiian', 12.99);

INSERT INTO pizza_shop.orders(order_id, `date`)
VALUES (1, '2014-09-10 09:47:00');

INSERT INTO pizza_shop.orders(order_id, `date`)
VALUES (2, '2014-09-10 13:20:00');

INSERT INTO pizza_shop.orders(order_id, `date`)
VALUES (3, '2014-09-10 09:47:00');

INSERT INTO pizza_shop.customer_orders(customer_id, order_id)
VALUES (1,1);

INSERT INTO pizza_shop.customer_orders(customer_id, order_id)
VALUES (2,2);

INSERT INTO pizza_shop.customer_orders(customer_id, order_id)
VALUES (1,3);

INSERT INTO pizza_shop.pizza_orders(pizza_id, order_id, quantity)
VALUES (1,1, 1);

INSERT INTO pizza_shop.pizza_orders(pizza_id, order_id, quantity)
VALUES (3, 1, 1);

INSERT INTO pizza_shop.pizza_orders(pizza_id, order_id, quantity)
VALUES (2,2,1);

INSERT INTO pizza_shop.pizza_orders(pizza_id, order_id, quantity)
VALUES (3,2,2);

INSERT INTO pizza_shop.pizza_orders(pizza_id, order_id, quantity)
VALUES (3,3,1);

INSERT INTO pizza_shop.pizza_orders(pizza_id, order_id, quantity)
VALUES (4,3,1);

SELECT * FROM pizza_shop.customers c
JOIN `customer_orders` co ON co.customer_id = c.customer_id
JOIN `orders` o ON o.order_id = co.order_id
JOIN `pizza_orders` po ON po.order_id = o.order_id
JOIN `pizzas` p ON p.pizza_id = po.pizza_id;

SELECT c.customer_id, `name`, sum(CASE
	WHEN quantity > 0 THEN quantity * price
    END) as total FROM pizza_shop.customers c
   JOIN `customer_orders` co ON co.customer_id = c.customer_id
   JOIN `orders` o ON o.order_id = co.order_id
   JOIN `pizza_orders` po ON po.order_id = o.order_id
   JOIN `pizzas` p ON p.pizza_id = po.pizza_id
   GROUP BY c.customer_id;







