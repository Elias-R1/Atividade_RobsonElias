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
