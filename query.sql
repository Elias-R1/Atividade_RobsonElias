USE restaurante_db;

-- letra a: Listar produtos de um pedido específico
SELECT 
    o.id AS order_id, 
    COUNT(p.pid) AS total_products,
    SUM(p.quantity) AS total_quantity,
    GROUP_CONCAT(DISTINCT pr.name ORDER BY pr.name SEPARATOR ', ') AS product_names
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

-- letra d: Listar Pedidos em Andamento para uma Mesa Específica
SELECT 
    o.id AS order_id,
    o.clid AS client_id,
    o.dates AS order_date,
    o.status AS order_status,
    COUNT(p.pid) AS total_products,
    SUM(p.quantity) AS total_quantity,
    GROUP_CONCAT(DISTINCT pr.name ORDER BY pr.name SEPARATOR ', ') AS product_names
FROM orders o
JOIN order_items p ON o.id = p.sid
JOIN products pr ON p.pid = pr.id
WHERE o.tid = 1  -- Substitua o ID pela mesa desejada
AND o.status IN ('reserved', 'open', 'payment')
GROUP BY o.id;

-- letra e: Cancelar Pedido
DELIMITER //

CREATE PROCEDURE CancelarPedido(
    IN pedido_id INT
)
BEGIN
    DECLARE pedido_status VARCHAR(20);
    SELECT status INTO pedido_status
    FROM orders
    WHERE id = pedido_id;
    IF pedido_status IN ('delivered', 'canceled') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Este pedido não pode ser cancelado, pois já foi entregue ou cancelado.';
    ELSE
        UPDATE orders
        SET status = 'canceled'
        WHERE id = pedido_id;
    END IF;

END //

DELIMITER ;

-- letra f: Gerar Relatório de Pedidos por Status
SELECT 
    o.status AS order_status,
    COUNT(o.id) AS total_orders,
    SUM(p.quantity) AS total_quantity,
    SUM(p.quantity * pr.price) AS total_value
FROM orders o
JOIN order_items p ON o.id = p.sid
JOIN products pr ON p.pid = pr.id
GROUP BY o.status;

-- letra g: Listar Pedidos de um Cliente
SELECT 
    o.id AS order_id,
    o.dates AS order_date,
    o.status AS order_status,
    COUNT(p.pid) AS total_products,
    SUM(p.quantity) AS total_quantity,
    GROUP_CONCAT(DISTINCT pr.name ORDER BY pr.name SEPARATOR ', ') AS product_names
FROM orders o
JOIN order_items p ON o.id = p.sid
JOIN products pr ON p.pid = pr.id
WHERE o.clid = 1  -- Substitua 1 pelo ID do cliente desejado
GROUP BY o.id;

-- letra h: Atualizar Status do Pedido
DELIMITER //

CREATE PROCEDURE AtualizarStatusPedido(
    IN pedido_id INT,
    IN novo_status VARCHAR(20)
)
BEGIN
    UPDATE orders
    SET status = novo_status
    WHERE id = pedido_id;
END //

DELIMITER ;

-- letra i: Excluir Pedido e Itens Associados
DELIMITER //

CREATE PROCEDURE ExcluirPedido(
    IN pedido_id INT
)
BEGIN
    START TRANSACTION;
    DELETE FROM order_items
    WHERE sid = pedido_id;
    DELETE FROM orders
    WHERE id = pedido_id;
    COMMIT;
END //

DELIMITER ;
