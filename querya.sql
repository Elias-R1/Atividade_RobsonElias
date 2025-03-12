use restaurante_db;

-- letra a:
SELECT 
    o.id AS order_id, 
    COUNT(DISTINCT p.pid) AS total_products,
    SUM(p.quantity) AS total_quantities,
    GROUP_CONCAT(DISTINCT pr.name ORDER BY pr.name SEPARATOR ', ') AS product_names
FROM orders o
JOIN order_items p ON o.id = p.sid
JOIN products pr ON p.pid = pr.id
WHERE o.id = 1 -- trocar pelo ID do pedido especifico
GROUP BY o.id;
