USE restaurante_db;

INSERT INTO locations (id, table_number, hourvalues) VALUES 
(1, 14, 4.0),
(2, 12, 3.0),
(3, 10, 5.0);

INSERT INTO clients (id, name, email) VALUES 
(1, 'Robson1', 'email@email.com'),
(2, 'Robson2', 'email1@email.com'),
(3, 'Robson3', 'email2@email.com');

INSERT INTO products (id, name, price) VALUES 
(1, 'Ovo Frito', 4.0),
(2, 'Hamburguer', 10.0),
(3, 'Picanha', 200.0),
(4, 'Café', 45.0);

INSERT INTO orders (id, tid, clid, dates, status) VALUES 
(1, 2, 1, '2025-03-29', 'open'),
(2, 3, 1, '2025-03-01', 'open');

INSERT INTO order_items (sid, pid, quantity) VALUES 
(1, 4, 10),
(1, 3, 10),
(1, 2, 20),
(2, 1, 30);
