USE restaurante_db;

--  Letra C: Atualizar Quantidade de Produtos em um Pedido
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
