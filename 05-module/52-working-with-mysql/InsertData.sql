INSERT INTO Customers (id_customer, name) VALUES (1, "zzzPortaTestCustomer");
INSERT INTO Customers (id_customer, name, firstname) VALUES (2, "John", "John");
INSERT INTO Customers (id_customer, name) VALUES (3, "zzzPortaTestCustomer");

INSERT INTO Accounts (id_account, id, password, id_customer, billing_model)
	VALUES (1, "000999123", "123test", 1, 1);
INSERT INTO Accounts (id_account, id, password, id_customer, billing_model)
	VALUES (2, "000999456", "123test", 1, 1);
INSERT INTO Accounts (id_account, id, password, id_customer, billing_model)
	VALUES (3, "380441112233", "ylxlab8", 2, 1);
INSERT INTO Accounts (id_account, id, password, balance, id_customer, billing_model)
	VALUES (4, "999610934091", NULL, 10.00000, 2, -1);
INSERT INTO Accounts (id_account, id, password, balance, id_customer, billing_model)
	VALUES (5, "998942226765", "1oyhptao", 10.00000, 2, -1);
INSERT INTO Accounts (id_account, id, password, id_customer, billing_model)
	VALUES (6, "997127472771", "123test", 3, 1);
INSERT INTO Accounts (id_account, id, password, id_customer, billing_model)
	VALUES (7, "000999123", "plt0wf", 3, 1);
INSERT INTO Accounts (id_account, id, password, balance, id_customer, billing_model)
	VALUES (8, "000999456", "xgmfy0", 10.00000, 2, -1);
INSERT INTO Accounts (id_account, id, password, balance, id_customer, billing_model)
	VALUES (9, "998819317344", NULL, 10.00000, 1, -1);

