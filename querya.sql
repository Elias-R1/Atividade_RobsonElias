USE restaurante_db;

-- letra a: Listar produtos de um pedido específico
SELECT 
    o.id AS order_id, 
    COUNT(p.pid) AS total_products,
    SUM(p.quantity) AS total_quantity,
    GROUP_CONCAT(pr.name ORDER BY pr.name SEPARATOR ', ') AS product_names
FROM orders o
JOIN order_items p ON o.id = p.sid
JOIN products pr ON p.pid = pr.id
WHERE o.id = 1 -- Substituir pelo ID do pedido desejado
GROUP BY o.id;
