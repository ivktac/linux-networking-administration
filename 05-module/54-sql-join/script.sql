/* Додати до таблиці Movie фільм:

    режисер: Oleksandr Dovzhenko

    назва: Zvenyhora

    рік: 1927

    ID: 150
*/
INSERT INTO Movie VALUES (150, "Zvenyhora", 1927, "Oleksandr Dovzhenko");

-- Підвищити оцінку на один бал всім фільмам, чиї оцінки менше 5.
UPDATE Rating SET stars = stars + 1 WHERE stars < 5;

-- Видалити рядки таблиці Rating, що не містять дату.
DELETE FROM Rating WHERE ratingDate IS NULL;
