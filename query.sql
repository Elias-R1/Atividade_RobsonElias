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
WHERE o.id = 1 -- Substituir pelo ID do pedido...
GROUP BY o.id;

-- letra b: Limitar pedidos para mesas que estão em atendimento
DELIMITER //

CREATE PROCEDURE LimitarPedidos(
    IN tid_param INT, 
    IN clid_param INT, 
    IN data_param DATE
)
BEGIN
    DECLARE mesa_em_atendimento INT;
    
    SELECT COUNT(*) INTO mesa_em_atendimento
    FROM orders
    WHERE tid = tid_param AND status IN ('reserved', 'open', 'payment');

    IF mesa_em_atendimento > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Esta mesa já tem um pedido em andamento!';
    ELSE
        INSERT INTO orders (tid, clid, dates, status)
        VALUES (tid_param, clid_param, data_param, 'reserved');
    END IF;

END //

DELIMITER ;

-- letra c: Atualizar a quantidade de produtos em um pedido
DELIMITER //

CREATE PROCEDURE AtualizarQuantidadeProdutoPedido(
    IN pedido_id INT,
    IN produto_id INT,
    IN nova_quantidade INT
)
BEGIN
    DECLARE produto_existente INT;

    START TRANSACTION;

    SELECT COUNT(*) INTO produto_existente
    FROM order_items
    WHERE sid = pedido_id AND pid = produto_id;

    IF produto_existente > 0 THEN
        UPDATE order_items
        SET quantity = nova_quantidade
        WHERE sid = pedido_id AND pid = produto_id;
    ELSE
        INSERT INTO order_items (sid, pid, quantity)
        VALUES (pedido_id, produto_id, nova_quantidade);
    END IF;

    COMMIT;
END //

DELIMITER ;
