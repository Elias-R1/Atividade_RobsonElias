USE restaurante_db;

-- Inserir dados na tabela locations (mesas)
INSERT INTO locations (id, table_number, hourvalues) VALUES 
(1, 1, 10.0),  -- Mesa 1 com disponibilidade de 10 horas
(2, 2, 12.5),  -- Mesa 2 com disponibilidade de 12.5 horas
(3, 3, 8.0),   -- Mesa 3 com disponibilidade de 8 horas
(4, 4, 9.5),   -- Mesa 4 com disponibilidade de 9.5 horas
(5, 5, 11.0),  -- Mesa 5 com disponibilidade de 11 horas
(6, 6, 10.5),  -- Mesa 6 com disponibilidade de 10.5 horas
(7, 7, 13.0),  -- Mesa 7 com disponibilidade de 13 horas
(8, 8, 7.5),   -- Mesa 8 com disponibilidade de 7.5 horas
(9, 9, 14.0),  -- Mesa 9 com disponibilidade de 14 horas
(10, 10, 12.0), -- Mesa 10 com disponibilidade de 12 horas
(11, 11, 15.0); -- Mesa 11 com disponibilidade de 15 horas

-- Inserir dados na tabela clients (clientes)
INSERT INTO clients (name, email) VALUES 
('Robson Pereira', 'robson@example.com'),
('Maria Silva', 'maria@example.com'),
('Carlos Souza', 'carlos@example.com'),
('Fernanda Oliveira', 'fernanda@example.com'),
('João Santos', 'joao@example.com'),
('Luciana Costa', 'luciana@example.com');

-- Inserir dados na tabela products (produtos)
INSERT INTO products (name, price) VALUES 
('Ovo Frito', 5.50),
('Hambúrguer', 15.00),
('Picanha', 120.00),
('Café', 10.00),
('Batata Frita', 8.00),
('Frango Grelhado', 25.00),
('Suco de Laranja', 7.50),
('Sorvete', 12.00),
('Nescau', 6.00);

-- Inserir dados na tabela orders (pedidos)
INSERT INTO orders (tid, clid, dates, status) VALUES 
(1, 1, '2025-03-29', 'open'),
(2, 2, '2025-03-01', 'reserved'),
(3, 3, '2025-03-30', 'canceled'),
(4, 4, '2025-03-25', 'payment'),
(5, 5, '2025-03-20', 'open'),
(6, 6, '2025-03-15', 'closed');

-- Inserir dados na tabela order_items (itens do pedido)
INSERT INTO order_items (sid, pid, quantity) VALUES 
(1, 1, 3),  -- Pedido 1: 3 Ovos Fritos
(1, 2, 2),  -- Pedido 1: 2 Hambúrgueres
(2, 3, 1),  -- Pedido 2: 1 Picanha
(2, 6, 2),  -- Pedido 2: 2 Frangos Grelhados
(3, 4, 5),  -- Pedido 3: 5 Cafés
(3, 5, 10), -- Pedido 3: 10 Batatas Fritas
(4, 7, 4),  -- Pedido 4: 4 Suco de Laranja
(4, 8, 3),  -- Pedido 4: 3 Sorvetes
(5, 9, 6),  -- Pedido 5: 6 Nescau
(6, 2, 2);  -- Pedido 6: 2 Hambúrgueres
