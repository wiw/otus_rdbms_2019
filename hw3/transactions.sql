-- MySQL transactions list
SET autocommit = 0;

/*
Задача:
    Размещение заказа нового клиента.

Фазы:
    Установка связи клиент-столик-официант
    Бронируется (блокируется для аренды) столик для нового клиента
    Размещается новый заказ с блюдами и их количеством

Особенности:
    Если клиента нет в БД, происходит добавление нового клиента

*/
START TRANSACTION;
INSERT INTO orders(client_id, table_id, waiter_id) VALUES (1, 2, 3);
IF NOT SELECT EXISTS(SELECT * FROM clients WHERE client_id = 1) THEN INSERT INTO clients VALUES (1, 4);
END IF;
SELECT * FROM restaurant_tables WHERE table_id = 2 FOR UPDATE;
UPDATE restaurant_tables SET status = 0 WHERE table_id = 2;
INSERT INTO order_line(order_id, dish_id, count_item) VALUES (0, 20, 1),(0, 24, 1),(0, 38, 1);
COMMIT;

/*
Задача:
    Иногда клиенты могут менять зарезервированный столик

Фазы:
    Меняется номер столик в заказах
    Снимается блокировка со старого столика и бронируется новый столик
*/

START TRANSACTION;
SELECT * FROM orders WHERE order_id = 0 FOR UPDATE;
SELECT * FROM restaurant_tables WHERE table_id IN (2,15) FOR UPDATE;
UPDATE orders SET table_id = 15 WHERE order_id = 0;
UPDATE restaurant_tables SET status = 1 WHERE table_id = 2;
UPDATE restaurant_tables SET status = 0 WHERE table_id = 15;
COMMIT;

/*
Задача:
    При размещении нового заказа, по умолчанию, устанавливается метод оплаты 
    наличными. Для клиента это может быть неудобным, поэтому предусмотрено
    изменение метода оплаты

Фазы:
    Изменяется метод оплаты для выбранного заказа   
*/

START TRANSACTION;
SELECT * FROM orders WHERE order_id = 0 FOR UPDATE;
UPDATE orders SET payment_method_id = 2 WHERE order_id = 0;
COMMIT;

/*
Задача:
    Изменение блюд и их количества в заказе

Фазы:
    Для позиции в заказе изменяется идентификатор блюда и его количество

*/

START TRANSACTION;
SELECT * FROM order_line WHERE order_id = 0 FOR UPDATE;
UPDATE order_line SET dish_id = 30 WHERE order_id = 0 AND dish_id = 24;
UPDATE order_line SET count_id = 2 WHERE order_id = 0 AND dish_id = 24;
COMMIT;

/*
Задача:
    Установить значение чаевых для официанта

Фазы:
    В заказах обновляется размер чаевых в абсолютных величинах для
    официанта
*/

START TRANSACTION;
SELECT * FROM orders WHERE order_id = 0 FOR UPDATE;
UPDATE orders SET tip = 300.0000 WHERE order_id = 0;
COMMIT;

/*
Задача:
    Отмена заказа

Фазы:
    Удаление записи о заказе из таблицы заказов
    Удаление позиций в заказе
    Отмена бронирования столика
*/

START TRANSACTION;
SELECT * FROM restaurant_tables WHERE table_id = 2 FOR UPDATE;
DELETE FROM orders, order_line WHERE order_id = 0;
UPDATE restaurant_tables SET status = 1 WHERE table_id = 2;
COMMIT;

/*
Задача:
    В случае непредвиденных проблемм или иных причин, может потребоваться
    замена официанта

Фазы:
    Для заказа изменить связанного официанта
*/

START TRANSACTION;
SELECT * FROM orders WHERE order_id = 0 FOR UPDATE;
UPDATE orders SET waiter_id = 5 WHERE order_id = 0;
COMMIT;

/*
Задача:
    Клиент передал бронирование на другого клиента. Или при ошибочном
    бронировании на клиента, требуется замена на другого клиента

Фаза:
    Для заказа установить другого клиента
    Если такого клиента не существует, тогда создать нового клиента, и затем
    назначить этого клиента на заказ
*/

START TRANSACTION;
SELECT * FROM orders WHERE order_id = 0 FOR UPDATE;
IF NOT SELECT EXISTS(SELECT * FROM clients WHERE client_id = 7) THEN INSERT INTO clients VALUES (7, 1);
END IF;
UPDATE orders SET client_id = 7 WHERE order_id = 0;
COMMIT;