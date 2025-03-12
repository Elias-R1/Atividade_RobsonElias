USE restaurante_db;

-- letra a = Listar o número de produtos e a quantidade de um determinado pedido
SELECT o.id AS order_id, COUNT(p.pid) AS total_products, SUM(p.quantities) AS total_quantities
FROM orders o
JOIN productsche p ON o.id = p.sid
WHERE o.id = 1 --apenas mudar o id do pedido desejado
GROUP BY o.id;

-- letra b = Procedure para limitar pedidos apenas a mesas que estejam em atendimento (status = 'open')
DELIMITER //

CREATE PROCEDURE LimitarPedidos(IN tid_param INT, IN clid_param INT, IN data_param DATE)
BEGIN
    DECLARE mesa_em_atendimento INT;
    
    -- aqui verifica se a mesa já tem um pedido em andamento
    SELECT COUNT(*) INTO mesa_em_atendimento 
    FROM orders 
    WHERE tid = tid_param AND status = 'open';

    -- se a mesa já estiver ocupada, não fazer um novo pedido
    IF mesa_em_atendimento > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Esta mesa já tem um pedido em andamento!';
    ELSE
        -- fazer novo pedido
        INSERT INTO orders (tid, clid, dates, status)
        VALUES (tid_param, clid_param, data_param, 'open');
    END IF;
END //

DELIMITER ;
