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

-- letra b:
DELIMITER //

CREATE PROCEDURE LimitarPedidos(
    IN tid_param INT, 
    IN clid_param INT, 
    IN data_param DATE
)
BEGIN
    DECLARE mesa_em_atendimento INT;
    
    -- aqui verifica se a mesa tem um pedido que ainda não foi concluído
    SELECT COUNT(*) INTO mesa_em_atendimento 
    FROM orders 
    WHERE tid = tid_param AND status IN ('reserved', 'open', 'payment'); -- Agora verifica múltiplos status ativos

    -- bloqueia novo pedido se a mesa já estiver ocupada
    IF mesa_em_atendimento > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Esta mesa já tem um pedido em andamento!';
    ELSE
        -- criando novo pedido com status inicial 'reserved'...
        INSERT INTO orders (tid, clid, dates, status)
        VALUES (tid_param, clid_param, data_param, 'reserved');
    END IF;
END //

DELIMITER ;

-- consultas pra procedure...
CALL LimitarPedidos(2, 1, '2025-03-29');

SELECT id, tid, status 
FROM orders 
WHERE tid = 2;

UPDATE orders
SET status = 'closed'
WHERE tid = 2 AND status IN ('reserved', 'open', 'payment');

SELECT *FROM orders;
