CREATE OR REPLACE PACKAGE PKG_INFO_ATENDIMENTO AS

    -- 1. Retorna a contagem de colaboradores envolvidos em um atendimento.
    FUNCTION FN_CONTA_COLABORADORES (
        p_id_registro_atendimento IN REGISTRO_ATENDIMENTO.ID_REGISTRO_ATENDIMENTO%TYPE
    ) 
    RETURN NUMBER;

    -- 2. Retorna 'S' se o ID do Atendimento estiver na tabela PROJETO_PESQUISA, ou 'N'.
    FUNCTION FN_ESTA_EM_PROJETO_PESQUISA (
        p_id_registro_atendimento IN REGISTRO_ATENDIMENTO.ID_REGISTRO_ATENDIMENTO%TYPE
    ) 
    RETURN VARCHAR2;
    
END PKG_INFO_ATENDIMENTO;
/



CREATE OR REPLACE PACKAGE BODY PKG_INFO_ATENDIMENTO AS

    -- FUNÇÃO 1: CONTA COLABORADORES
    FUNCTION FN_CONTA_COLABORADORES (
        p_id_registro_atendimento IN REGISTRO_ATENDIMENTO.ID_REGISTRO_ATENDIMENTO%TYPE
    ) 
    RETURN NUMBER 
    IS
        v_contagem NUMBER := 0;
    BEGIN
        -- Consulta a tabela associativa para contar quantas linhas têm o ID do atendimento
        SELECT COUNT(ID_COLABORADOR) INTO v_contagem
        FROM REGISTRO_ATENDIMENTO_COLABORADOR
        WHERE ID_REGISTRO_ATENDIMENTO = p_id_registro_atendimento;
        
        RETURN v_contagem;
    END FN_CONTA_COLABORADORES;

    -- FUNÇÃO 2: VERIFICA LIGAÇÃO DIRETA COM PROJETO DE PESQUISA
    FUNCTION FN_ESTA_EM_PROJETO_PESQUISA (
        p_id_registro_atendimento IN REGISTRO_ATENDIMENTO.ID_REGISTRO_ATENDIMENTO%TYPE
    ) 
    RETURN VARCHAR2 
    IS
        v_existe VARCHAR2(1) := 'N';
    BEGIN
        -- Usa o mecanismo EXISTS para verificar a presença do ID_REGISTRO_ATENDIMENTO
        -- na tabela PROJETO_PESQUISA (assumindo a FK direta).
        SELECT 'S' INTO v_existe
        FROM DUAL
        WHERE EXISTS (
            SELECT 1
            FROM PROJETO_PESQUISA 
            WHERE ID_REGISTRO_ATENDIMENTO = p_id_registro_atendimento
            AND ROWNUM = 1 -- Para a busca na primeira linha encontrada
        );

        RETURN v_existe;
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            -- Ocorre se a subconsulta WHERE EXISTS não retornar nenhuma linha
            RETURN 'N';
        WHEN OTHERS THEN
            RAISE; -- Lança outros erros inesperados
    END FN_ESTA_EM_PROJETO_PESQUISA;
    
END PKG_INFO_ATENDIMENTO;
/