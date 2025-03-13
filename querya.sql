use restaurante_db;

-- letra a: Listar produtos
SELECT 
    o.id AS order_id, 
    COUNT(p.pid) AS total_products,
    SUM(p.quantity) AS total_quantity,
    GROUP_CONCAT(pr.name ORDER BY pr.name SEPARATOR ', ') AS product_names
FROM orders o
JOIN order_items p ON o.id = p.sid
JOIN products pr ON p.pid = pr.id
WHERE o.id = 1 -- trocar pelo ID de algum pedido...
GROUP BY o.id;
