use restaurante_db;

-- a) listar o número de produtos e a quantidade de um determinado pedido
SELECT 
    oi.sid AS pedido_id,
    p.name AS nome_produto,
    COUNT(oi.pid) AS numero_produtos,
    SUM(oi.quantity) AS quantidade_total
FROM order_items oi
JOIN products p ON oi.pid = p.id
WHERE oi.sid = ? -- Substituir (?) pelo id do pedido específico (ex: 1, 2, 3, 4, 5 ou 6)
GROUP BY oi.sid, p.name;

-- b) criação de de uma procedure para limitar os pedidos apenas a mesas que estejam em atendimento
DELIMITER //
CREATE PROCEDURE LimitarPedidos()
BEGIN
    DELETE FROM orders
    WHERE status NOT IN ('open', 'payment');
END //
DELIMITER ;

-- c) criação de uma procedure para atualizar a quantidade de um item em um pedido existente
DELIMITER //
CREATE PROCEDURE AtualizarQuantidadePedido(
    IN p_sid INT,
    IN p_pid INT,
    IN p_nova_quantidade INT
)
BEGIN
    UPDATE order_items
    SET quantity = p_nova_quantidade
    WHERE sid = p_sid AND pid = p_pid;
END //
DELIMITER ;

-- d) listar o nome dos produtos, a quantidade, o valor total de cada produto e o valor total da compra
SELECT p.name AS produto, oi.quantity AS quantidade, 
       (oi.quantity * p.price) AS valor_total_produto,
       (SELECT SUM(oi2.quantity * p2.price) 
        FROM order_items oi2 
        JOIN products p2 ON oi2.pid = p2.id 
        WHERE oi2.sid = oi.sid) AS valor_total_compra
FROM order_items oi
JOIN products p ON oi.pid = p.id
WHERE oi.sid = ? -- Substituir (?) pelo id do pedido desejado (ex: 1, 2, 3, 4, 5 ou 6)
ORDER BY produto;
