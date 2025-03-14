USE restaurante_system;

-- A) listar o número de produtos e a quantidade para um pedido específico
SELECT 
    ped.id AS pedido_numero, 
    COUNT(it.pid) AS qtd_produtos, 
    SUM(it.qtde) AS soma_quantidades
FROM pedidos ped
JOIN itens_pedido it ON ped.id = it.sid
WHERE ped.id = 2  -- aqui eh so alterar o id de algum pedido especifico
GROUP BY ped.id;

DELIMITER //

-- B) Procedure para aceitar pedidos apenas de mesas ocupadas
CREATE PROCEDURE ControlarPedidosMesa(
    IN mesa_id INT, 
    IN cliente_id INT, 
    IN data_pedido DATE
)
BEGIN
    DECLARE mesa_ocupada INT;

    SELECT COUNT(*) INTO mesa_ocupada
    FROM pedidos
    WHERE tid = mesa_id AND status IN ('reservado', 'ativo', 'pagamento');

    IF mesa_ocupada > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: A mesa já está com um pedido em andamento!';
    ELSE
        INSERT INTO pedidos (tid, clid, datas, status)
        VALUES (mesa_id, cliente_id, data_pedido, 'reservado');
    END IF;
END //

-- C) Procedure para modificar a quantidade de um item já existente em um pedido
CREATE PROCEDURE ModificarQtdeItemPedido(
    IN id_pedido INT,
    IN id_item INT,
    IN nova_qtde INT
)
BEGIN
    UPDATE itens_pedido
    SET qtde = nova_qtde
    WHERE sid = id_pedido AND pid = id_item;
END //

DELIMITER ;

-- D) Listar os itens do pedido, suas quantidades, preço unitário, total por item e valor total do pedido
SELECT 
    prod.nome AS nome_item,
    it.qtde AS quantidade,
    (it.qtde * prod.preco) AS total_por_item,
    (SELECT SUM(it2.qtde * prod2.preco) 
     FROM itens_pedido it2
     JOIN produtos prod2 ON it2.pid = prod2.id
     WHERE it2.sid = ped.id) AS valor_total_pedido
FROM pedidos ped
JOIN itens_pedido it ON ped.id = it.sid
JOIN produtos prod ON it.pid = prod.id
WHERE ped.id = 2;  -- Altere para o ID do pedido desejado
