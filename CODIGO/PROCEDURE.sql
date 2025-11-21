"Retorna a quantidade de atendimentos com status de "Andamento""

CREATE OR REPLACE FUNCTION FN_CONTA_ATENDIMENTOS_ANDAMENTO
RETURN NUMBER
IS
    v_total_andamento NUMBER;
BEGIN
    -- 1. Conta todos os registros na tabela REGISTRO_ATENDIMENTO
    --    que têm o STATUS_ATENDIMENTO igual a 'Andamento'.
    SELECT COUNT(ID_REGISTRO_ATENDIMENTO)
    INTO v_total_andamento
    FROM REGISTRO_ATENDIMENTO
    WHERE STATUS_ATENDIMENTO = 'Andamento';

    -- 2. Retorna o valor diretamente.
    RETURN v_total_andamento;

EXCEPTION
    WHEN OTHERS THEN
        -- Em caso de erro, retorna 0
        RETURN 0; 
END FN_CONTA_ATENDIMENTOS_ANDAMENTO;
/

-- Consulta

SELECT 
    FN_CONTA_ATENDIMENTOS_ANDAMENTO() AS Total_Atendimentos_Em_Andamento
FROM 
    DUAL;