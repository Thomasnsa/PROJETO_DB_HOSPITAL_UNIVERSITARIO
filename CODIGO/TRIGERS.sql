-- #######################################################################
-- # TRIGGERS DE SINCRONIZAÇÃO DE LEITO E INTERNAÇÃO
-- #######################################################################
-- -----------------------------------------------------------------------
-- 1. TRG_ATRIBUI_LEITO_AUTO (Trigger BEFORE): Sincroniza colunas internas
-- Garante que ID_LEITO e INTERNACAO estejam sempre coerentes.
-- -----------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_atribui_leito_auto
BEFORE INSERT OR UPDATE OF id_leito, internacao ON registro_atendimento
FOR EACH ROW
BEGIN
    -- Verifica se um ID de leito está sendo atribuído (mudando de NULL para NOT NULL)
    IF :OLD.id_leito IS NULL AND :NEW.id_leito IS NOT NULL THEN
        -- Se um leito foi atribuído, força a internação para 'SIM'.
        :NEW.internacao := 'SIM';
        
    -- Se o usuário explicitamente marcou a internação como 'NAO'.
    ELSIF :NEW.internacao = 'NAO' THEN
    
        -- Força o ID do leito a ser NULL para liberar o leito no registro.
        :NEW.id_leito := NULL;        

    -- Se o usuário removeu o ID do leito (colocou NULL).
    ELSIF :NEW.id_leito IS NULL THEN
    
        -- Força o status de internação para 'NAO'.
        :NEW.internacao := 'NAO';     

    END IF;

END;
/

-- -----------------------------------------------------------------------
-- 2. TRG_OCUPA_LEITO_STATUS (Trigger AFTER): Altera status na tabela LEITO
-- ATENÇÃO: Contém a lógica original que pode gerar erro de sintaxe/lógica.
-- -----------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_ocupa_leito_status
AFTER INSERT OR UPDATE OF internacao, id_leito ON registro_atendimento
FOR EACH ROW
BEGIN
    -- Lógica AFTER: LIMPEZA DO LEITO ANTIGO (Se havia um leito, ele entra em limpeza)
    IF :OLD.id_leito IS NOT NULL THEN

        UPDATE leito
        SET status = 'Em limpeza'
        WHERE id_leito = :old.id_leito;

    -- Lógica AFTER: OCUPAÇÃO OU MANUTENÇÃO (Início do segundo IF aninhado)
    IF :NEW.id_leito IS NOT NULL THEN
        
        -- Ocupa o novo leito (ou mantém a ocupação se o ID for o mesmo)
        UPDATE leito
        SET status = 'Ocupado'
        WHERE id_leito = :NEW.id_leito;           

    -- Liberação Final/Limpeza
    ELSIF (:OLD.id_leito IS NOT NULL AND :NEW.id_leito IS NULL) OR :NEW.internacao = 'NAO' THEN
        
        -- O leito antigo é marcado como "Em limpeza" após a desocupação.
        UPDATE leito
        SET status = 'Em limpeza'
        WHERE id_leito = :OLD.id_leito;
        
    END IF;
    END IF; -- ESTE END IF É O PROVÁVEL CAUSADOR DO ERRO ORA-04098.
END;
/

-- #######################################################################
-- # TRG_ASSOCIA_COLAB_PROJETO: Propagação de Participantes de Atendimento para Projetos
-- # Objetivo: Inserir automaticamente o colaborador em PROJETO_PESQUISA_COLABORADOR 
-- #           se o REGISTRO_ATENDIMENTO estiver vinculado a um PROJETO_PESQUISA.
-- # Disparo:  Após a inserção de cada linha em REGISTRO_ATENDIMENTO_COLABORADOR.
-- #######################################################################

CREATE OR REPLACE TRIGGER TRG_ASSOCIA_COLAB_PROJETO
AFTER INSERT ON REGISTRO_ATENDIMENTO_COLABORADOR
FOR EACH ROW
DECLARE
    -- Cursor para buscar todos os projetos que usam o ID_REGISTRO_ATENDIMENTO recém-inserido.
    CURSOR cur_projetos IS
        SELECT ID_PROJETO_PESQUISA
        FROM PROJETO_PESQUISA
        WHERE ID_REGISTRO_ATENDIMENTO = :NEW.ID_REGISTRO_ATENDIMENTO;
BEGIN
    -- Itera sobre cada projeto de pesquisa que está vinculado ao atendimento.
    FOR proj IN cur_projetos LOOP
        
        -- Início do bloco de tratamento de exceção.
        BEGIN
            -- Tenta inserir a dupla (Colaborador, Projeto) na tabela associativa.
            INSERT INTO PROJETO_PESQUISA_COLABORADOR (ID_COLABORADOR, ID_PROJETO_PESQUISA)
            VALUES (:NEW.ID_COLABORADOR, proj.ID_PROJETO_PESQUISA);

        EXCEPTION
            -- Captura a exceção de Chave Duplicada (ORA-00001 - DUP_VAL_ON_INDEX).
            -- Isso acontece se o colaborador já estiver listado como participante do projeto.
            WHEN DUP_VAL_ON_INDEX THEN
                -- Ação: Não faz nada (NULL). A inserção falha silenciosamente, 
                -- garantindo que a Trigger não cause erro na transação principal.
                NULL; 
        END;
    END LOOP;
END;
/
