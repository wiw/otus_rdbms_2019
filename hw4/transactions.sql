-- MySQL transactions list
SET autocommit = 0;

-- ------------------------------
-- 1. Insert new order
-- ------------------------------
START TRANSACTION;
INSERT INTO orders(client_id, table_id, waiter_id) VALUES (1, 2, 3);
IF NOT SELECT EXISTS(SELECT * FROM clients WHERE client_id = 1) THEN INSERT INTO clients VALUES (1, 4);
END IF;
SELECT * FROM restaurant_tables WHERE table_id = 2 FOR UPDATE;
UPDATE restaurant_tables SET status = 0 WHERE table_id = 2;
INSERT INTO order_line(order_id, dish_id, count_item) VALUES (0, 20, 1),(0, 24, 1),(0, 38, 1);
COMMIT;

-- ------------------------------
-- 2. Change reserved table
-- ------------------------------

START TRANSACTION;
SELECT * FROM orders WHERE order_id = 0 FOR UPDATE;
SELECT * FROM restaurant_tables WHERE table_id IN (2,15) FOR UPDATE;
UPDATE orders SET table_id = 15 WHERE order_id = 0;
UPDATE restaurant_tables SET status = 1 WHERE table_id = 2;
UPDATE restaurant_tables SET status = 0 WHERE table_id = 15;
COMMIT;

-- ------------------------------
-- 3. Change payment method
-- ------------------------------

START TRANSACTION;
SELECT * FROM orders WHERE order_id = 0 FOR UPDATE;
UPDATE orders SET payment_method_id = 2 WHERE order_id = 0;
COMMIT;

-- --------------------------------------------
-- 4. Change dishes or dish count in order
-- --------------------------------------------

START TRANSACTION;
SELECT * FROM order_line WHERE order_id = 0 FOR UPDATE;
UPDATE order_line SET dish_id = 30 WHERE order_id = 0 AND dish_id = 24;
UPDATE order_line SET count_id = 2 WHERE order_id = 0 AND dish_id = 24;
COMMIT;

-- ------------------------------
-- 5. Set tip
-- ------------------------------

START TRANSACTION;
SELECT * FROM orders WHERE order_id = 0 FOR UPDATE;
UPDATE orders SET tip = 300.0000 WHERE order_id = 0;
COMMIT;

-- ------------------------------
-- 6. Order cancellation
-- ------------------------------

START TRANSACTION;
SELECT * FROM restaurant_tables WHERE table_id = 2 FOR UPDATE;
DELETE FROM orders, order_line WHERE order_id = 0;
UPDATE restaurant_tables SET status = 1 WHERE table_id = 2;
COMMIT;

-- ------------------------------
-- 7. Waiter replacement 
-- ------------------------------

START TRANSACTION;
SELECT * FROM orders WHERE order_id = 0 FOR UPDATE;
UPDATE orders SET waiter_id = 5 WHERE order_id = 0;
COMMIT;

-- ------------------------------
-- 8. Client replacement 
-- ------------------------------

START TRANSACTION;
SELECT * FROM orders WHERE order_id = 0 FOR UPDATE;
IF NOT SELECT EXISTS(SELECT * FROM clients WHERE client_id = 7) THEN INSERT INTO clients VALUES (7, 1);
END IF;
UPDATE orders SET client_id = 7 WHERE order_id = 0;
COMMIT;