/* Fill database by data
*/

-- Waiters
insert into waiters (waiter_name, waiter_status)
values
    ('Чеглокова Азалия', 'работает'),
    ('Мартынова Ксения', 'работает'),
    ('Татева Марта', 'работает'),
    ('Васютина Ирина', 'работает'),
    ('Леванидова Людмила', 'работает'),
    ('Ивашкин Александрин', 'работает'),
    ('Болотников Климент', 'работает'),
    ('Глинка Алексей', 'работает'),
    ('Бухарин Исмаил', 'работает'),
    ('Блинов Никодим', 'работает');


-- Tables
INSERT INTO restaurant_tables (seats_number, status)
VALUES (2, 'free'), (2, 'free'), (2, 'free'),
(2, 'free'), (2, 'free'), (2, 'free'), (2, 'free'),
(4, 'free'), (4, 'free'), (4, 'free'), (4, 'free'),
(4, 'free'), (4, 'free'), (4, 'free'),
(6, 'free'), (6, 'free'), (6, 'free'),
(6, 'free'), (6, 'free'), (6, 'free'), (6, 'free'), (6, 'free');

-- payment methods
INSERT INTO payment_methods (pm_name, pm_tax)
VALUES ('наличные', 20), ('кредитная карта', 25), ('безналичный перевод', 12);

-- discounts
INSERT INTO discounts (discount_method, discount_value)
VALUES ('скидок нет', 0), ('бонусная акция', 10), ('скидка постоянного клиента', 7), ('скидка на день рождения клиента', 25), ('день рождения ресторана', 50);

-- clients
ALTER TABLE clients DROP COLUMN client_id;

INSERT INTO clients (client_name, phone_number, discount_id)
VALUES
('Огинская Инга Брониславовна', '7598571671', 1),
('Спесивцева Акулина Касьяновна', '79301000726', 1),
('Фустова Домнина Северьяновна', '7511012371', 3),
('Анохина Альбина Нафанаиловна', '76733088029', 1),
('Ипатьева Иоланта Орестовна', '749043108230', 4),
('Хвостенко Дарья Мартимьяновна', '74274382656', 3),
('Спиридов Парамон Маркелович', '744777138512', 1),
('Магалов Мавр Зенонович', '710942839082', 1),
('Соколинский Евстахий Леонтьевич', '708469146617', 1),
('Саблуков Афанасий Елизарович', '703022286315', 1);


-- units dictionary
CREATE TABLE units (
    id INT NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор единицы измерения',
    units_name VARCHAR(100) NOT NULL COMMENT 'Наименование единицы измерения',
    units_value DECIMAL(10,4) NOT NULL COMMENT 'Численное значение единицы измерения',
    PRIMARY KEY (id)    
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci;

INSERT INTO units (units_name, units_value)
    VALUES ('1 килограмм', 1), ('1 грамм', 0.001), ('10 грамм', 0.01), 
    ('100 грамм', 0.1), ('500 грамм', 0.5), ('1 литр', 1), 
    ('500 миллилитров', 0.5), ('100 миллилитров', 0.1), ('1 штука', 1),
    ('700 миллилитров', 0.7);


-- dishes_category
CREATE TABLE dishes_category (
    id INT NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор категории блюда',
    category_name varchar(1000) NOT NULL COMMENT 'Наименование категории блюда',
    PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci;

INSERT INTO dishes_category (category_name) VALUES ('Салаты'), ('Закуски'), ('Первые блюда'), ('Горячие блюда'), ('Спиртные напитки'), ('Соки'), ('Чаи'), ('Хлеб'), ('Десерты');

-- product_category
CREATE TABLE product_category (
    id INT NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор категории продукта',
    category_name varchar(1000) NOT NULL COMMENT 'Наименование категории продукта',
    PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci;

INSERT INTO product_category (category_name) 
VALUES ('Овощи сырые'), ('Овощи готовые'), ('Сыры'), ('Молочные продукты'), 
('Морепродукты'), ('Мясо сырое'), ('Мясные деликатесы'), 
('Орехи'), ('Соусы'), ('Бакалея'), ('Алкоголь'), ('Соки'),
('Чаи')

-- dealers
CREATE TABLE dealers (
    id INT NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор поставщика',
    dealer_name VARCHAR(1000) NOT NULL COMMENT 'Наименование поставщика',
    agent VARCHAR(1000) COMMENT 'Наименование представителя или генерального директора',
    legal_address VARCHAR(1000) COMMENT 'Юридический адрес',
    actual_address VARCHAR(1000) COMMENT 'Действительный адрес',
    details VARCHAR(4000) COMMENT 'Реквизиты организации, JSON хранится в строке',
    PRIMARY KEY (id)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci;

INSERT INTO dealers (dealer_name, actual_address)
    VALUES ('ОАО РыбМореПродукт', 'г. Владивосток'), 
    ('ООО НМпЗ', 'г. Новосибирск'), ('ОАО Быстроном', 'г. Новосибирск'), 
    ('ИП Игнатенко', 'Украина, Донецк'), 
    ('ИП Загребудько', 'Украина, Киев'), 
    ('ООО Брониславона и дочеры', 'Белоруссия, Минск'), 
    ('ООО Мхысако', 'г. Новороссийск, Мхысако'), ('ОАО Абрау-Дюрсо', 'г. Новороссийск'), ('Чжень-Мень', 'Китай, Пекин')

-- products
CREATE TABLE products (
    id INT NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор продукта',
    product_name varchar(1000) NOT NULL COMMENT ' Наименование продукта',
    product_cost decimal(10,4) DEFAULT 0.0000 COMMENT 'Стоимость продукта за единицу, указанную в unit_id',
    unit_id INT NOT NULL COMMENT 'Идентификатор единицы стоимости продукта',
    product_category_id INT NOT NULL COMMENT 'Идентификатор категории продукта',
    product_dealer_id INT NOT NULL COMMENT 'Идентификатор поставщика продукта',
    INDEX `product_category_id_idx` (product_category_id),
    INDEX `product_dealer_id_idx` (product_dealer_id),
    PRIMARY KEY (id)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci;

INSERT INTO products (product_name, product_cost, unit_id, product_category_id, product_dealer_id)
VALUES ('помидоры', 320, 1, 1, 4), ('огурцы', 270, 1, 1, 4), ('маслины', 180, 4, 10, 5), ('брынза', 345, 1, 3, 6), ('крабовые палочки', 120, 4, 5, 1), ('яйцо', 12, 9, 4, 6), ('майонез', 187, 7, 9, 6), ('капуста', 37, 1, 1, 4), ('горошек консервированный', 29, 4, 2, 3), ('перец болгарский', 85, 1, 1, 4), ('масло растительное', 98, 6, 10, 3), ('грибы', 400, 1, 1, 6), ('ветчина', 680, 1, 7, 2), ('картофель', 45, 1, 1, 4), ('огурцы соленые', 168, 5, 2, 3), ('лук репчатый', 30, 1, 1, 5), ('зелень', 100, 4, 1, 5), ('курица', 600, 1, 6, 6), ('сыр', 1250, 1, 3, 6), ('грецкие орехи', 700, 1, 8, 3), ('судак', 820, 1, 5, 1), ('семга', 1600, 1, 5, 1), ('шпроты', 160, 4, 5, 1), ('икра красная', 568, 4, 5, 1), ('морковь', 48, 1, 1, 5), ('лимон', 150, 9, 1, 5), ('карбонад', 480, 1, 7, 2), ('колбаса вареная', 350, 1, 7, 2), ('язык говяжий', 780, 1, 7, 2), ('колбаса копченая', 950, 1, 7, 2), ('телятина', 700, 1, 6, 2), ('лапша домашняя', 380, 1, 10, 6), ('говяжий фарш', 450, 1, 6, 6), ('хлеб', 67, 5, 10, 6), ('свинина', 300, 1, 6, 2), ('Водка Ярославская', 900, 10, 11, 3), ('Водка Флагман', 450, 10, 11, 3), ('Водка Гжелка', 300, 10, 11, 3), ('Вермут «Чинзано Бианко»', 1100, 10, 11, 3), ('Хванчкара', 448, 10, 11, 7), ('Арбатское', 290, 10, 11, 7), ('Изабелла', 350, 10, 11, 8), ('Шампанское', 780, 10, 11, 8), ('Ярпиво оригинальное', 75, 7, 11, 3), ('Ярпиво янтарное', 98, 7, 11, 3), ('Клинское', 58, 7, 11, 3), ('Эфес Пилснер', 100, 7, 11, 3), ('Невское', 69, 7, 11, 3), ('Старый Мельник', 75, 7, 11, 3), ('Сок апельсиновый', 160, 6, 12, 3), ('Сок яблочный', 165, 6, 12, 3), ('Сок виноградный', 166, 6, 12, 3), ('Сок томатный', 158, 6, 12, 3), ('Чай цейлонский', 250, 4, 13, 9), ('Чай зеленый', 380, 4, 13, 9), ('Сахар-песок', 65, 1, 10, 3), 'говядина', 690, 1, 6, 2)


-- composition_of_dishes
CREATE TABLE dish_compose (
    id BIGINT NOT NULL AUTO_INCREMENT,
    dish_id INT NOT NULL COMMENT 'Идентификатор блюда',
    product_id INT NOT NULL COMMENT 'Идентификатор продукта',
    INDEX dish_id_idx (dish_id),
    INDEX product_id_idx (product_id),
    PRIMARY KEY (id)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci;

insert into dish_compose (dish_id, product_id)
    values (1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (2, 8), (2, 9), (2, 1), (2, 2), (2, 6), (2, 7), (3, 1), (3, 10), (3, 3), (3, 4), (3, 11), (4, 12), (4, 13), (4, 14), (4, 15), (4, 1), (4, 7), (4, 16), (4, 17), (5, 18), (5, 16), (5, 15), (5, 6), (5, 7), (5, 19), (5, 20), (6, 21), (6, 7), (6, 1), (6, 2), (7, 22), (7, 23), (7, 24), (7, 15), (7, 1), (7, 25), (7, 9), (7, 17), (7, 26), (8, 27), (8, 13), (8, 28), (9, 29), (9, 9), (9, 17), (10, 3), (11, 15), (12, 8), (12, 25), (12, 16), (12, 18), (12, 28), (12, 30), (12, 31), (13, 32), (13, 25), (13, 16), (13, 18), (14, 15), (14, 16), (14, 1), (14, 26), (14, 3), (14, 7), (14, 18), (14, 28), (14, 30), (14, 31), (15, 21), (15, 14), (15, 16), (15, 19), (16, 57), (16, 14), (16, 16), (16, 12), (17, 31), (17, 1), (17, 7), (17, 17), (18, 33), (18, 16), (18, 6), (18, 34), (19, 21), (19, 16), (19, 25), (19, 11), (19, 14), (19, 7), (20, 35), (20, 16), (21, 31), (21, 16), (22, 36), (23, 37), (24, 38), (25, 39), (26, 40), (27, 41), (28, 42), (29, 43), (30, 44), (31, 45), (32, 46), (33, 47), (34, 48), (35, 49), (36, 50), (37, 51), (38, 52), (39, 53), (40, 54), (40, 56), (41, 54), (41, 56), (41, 26), (42, 55), (43, 34), (44, 34)



-- booking
ALTER TABLE booking DROP COLUMN booking_id;


-- dishes
ALTER TABLE dishes ADD dish_weight VARCHAR(4000) COMMENT 'Вес блюда или его комбинации в граммах';
ALTER TABLE dishes ADD category_id INT UNSIGNED NOT NULL COMMENT 'Категория блюда';


INSERT INTO dishes (dish_name,dish_cost,dish_weight,category_id)
VALUES
('салат крабовый', 456, '190', 1), 
('салат традиционный', 213, '100', 1), 
('салат греческий', 412, '140', 1), 
('салат грибной', 412, '160', 1), 
('салат куриный', 480, '190', 1), 
('закуска', 747, '185', 1), 
('ассорти рыбное', 960, '144', 2), 
('ассорти мясное', 379, '75/20/2', 2), 
('язык с гарниром', 577, '75/22', 2), 
('маслины порционные', 370, '100/2', 2), 
('огурцы соленые', 200, '100', 2), 
('щи', 453, '250/40/100', 3), 
('Суп-лапша домашняя', 250, '250/50', 3), 
('солянка сборная мясная', 413, '250/40', 3), 
('рыба по-барски', 813, '375', 4), 
('жаркое по-русски', 820, '345', 4), 
('телятина', 1080, '200', 4), 
('шишки мясные по-царски', 429, '145', 4), 
('рыба в горшочке', 882, '260', 4), 
('эскалоп из свинины', 625, '100', 4), 
('филе из телятины', 665, '100', 4), 
('Ярославская', 600, '100', 5), 
('Флагман', 450, '100', 5), 
('Гжелка', 300, '100', 5), 
('Вермут "Чинзано Бианко"', 550, '100', 5), 
('Хванчкара', 320, '100', 5), 
('Арбатское', 170, '100', 5), 
('Изабелла', 160, '100', 5), 
('Шампанское', 400, '100', 5), 
('Ярпиво оригинальное', 700, '500', 5), 
('Ярпиво янтарное', 800, '500', 5), 
('Клинское', 500, '500', 5), 
('Эфес Пилснер', 550, '500', 5), 
('Невское', 580, '500', 5), 
('Старый Мельник', 580, '500', 5), 
('Апельсиновый', 280, '200', 6), 
('Яблочный', 280, '200', 6), 
('Виноградный', 280, '200', 6), 
('Томатный', 280, '200', 6), 
('Чай черный с сахаром', 180, '200', 7), 
('Чай черный с лимоном и сахаром', 250, '200', 7), 
('Чай зеленый', 320, '250', 7), 
('хлеб белый', 150, '50', 8), 
('хлеб ржаной', 280, '50', 8)

