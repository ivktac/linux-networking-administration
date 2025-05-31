-- Вивести всі акаунти, в яких відсутні паролі.
SELECT * FROM Accounts WHERE password is NULL;

-- Вивести всі акаунти, в яких id починається з 0
SELECT * FROM Accounts WHERE id LIKE "0%";

-- Вивести Customer, які мають в імені слово "Test"

SELECT * FROM Customers WHERE name LIKE "%Test%";

-- * Вивести імена Customers, у яких є акаунти з billing_model = -1 (використати підзапит)
SELECT * FROM Customers 
	WHERE id_customer IN (SELECT id_customer FROM Accounts WHERE billing_model = -1);

-- ** Порахувати кількість акаунтів під кожним Customer, формат: ім'я, число акаунтів. (використати JOIN)
SELECT Customers.name AS name, COUNT(Accounts.id_customer) as count_accounts
FROM Customers
INNER JOIN Accounts ON Accounts.id_customer = Customers.id_customer
GROUP BY Accounts.id_customer;
