USE restaurante_db;

-- Inserindo dados na tabela locations
INSERT INTO locations (id, locations, hourvalues) VALUES 
(1, 14, 4.0),
(2, 12, 3.0),
(3, 10, 5.0);

-- Inserindo dados na tabela clients
INSERT INTO clients (id, names, emails) VALUES 
(1, 'Laurindo', 'email@email'),
(2, 'Claudia', 'Email1@email'),
(3, 'Laura', 'Email2@email');

-- Inserindo dados na tabela products
INSERT INTO products (id, names, prices) VALUES 
(1, 'Ovo Frito', 4.0),
(2, 'Hamburguer', 10.0),
(3, 'Picanha', 200.0),
(4, 'Café', 45.0);

-- Inserindo dados na tabela orders
INSERT INTO orders (id, tid, clid, dates, status) VALUES 
(1, 2, 1, '2025-03-29', 'open'),
(2, 3, 1, '2025-03-01', 'open');

-- Inserindo dados na tabela productsche
INSERT INTO productsche (sid, pid, quantities) VALUES 
(1, 3, 1),
(1, 2, 1),
(2, 1, 1);
