--Transação para Atualização de Preços com Rollback Parcial
BEGIN
    UPDATE PROCEDIMENTO_PRECO
       SET PRECO = 200.00
     WHERE ID_PROCEDIMENTO = 1;
    SAVEPOINT antes_exclusao_historicos;
    DELETE FROM HISTORICO_PACIENTE
     WHERE DATA_REGISTRO < ADD_MONTHS(SYSDATE, -24);
    -- Detectou muitos registros? Volte só a parte perigosa
    ROLLBACK TO SAVEPOINT antes_exclusao_historicos;
    COMMIT;
END;
/

 --Transação para Manutenção de Leitos com Verificação

BEGIN
    UPDATE LEITO 
       SET STATUS = 'Em Manutenção'
     WHERE ID_LEITO IN (1, 2, 3);
    SAVEPOINT antes_verificacao_ocupacao;
    UPDATE REGISTRO_ATENDIMENTO
       SET ID_LEITO = NULL
     WHERE ID_LEITO IN (1, 2, 3)
       AND STATUS = 'Em Andamento';
    -- Detectou pacientes sendo desalocados? Volte só a parte perigosa
    ROLLBACK TO SAVEPOINT antes_verificacao_ocupacao;
    COMMIT;
END;
/


 --Transação para Faturamento com Validação de Valores
	
	BEGIN
	    UPDATE REGISTRO_ATENDIMENTO
	       SET VALOR_FATURADO = 750.00,
	           STATUS_PAGAMENTO = 'Processando'
	     WHERE ID_REGISTRO_ATENDIMENTO = 1;
	    SAVEPOINT antes_desconto;
	    UPDATE ITEM_FATURAMENTO
	       SET DESCONTO = 100.00,
	           NOVO_VALOR = NOVO_VALOR - 100.00
	     WHERE ID_REGISTRO_ATENDIMENTO = 1;
	    -- Detectou valor negativo? Volte só a parte perigosa
	    ROLLBACK TO SAVEPOINT antes_desconto;
	    COMMIT;
	END;
	/
	
	
--Transação para Transferência de Paciente entre Leitos

BEGIN
    UPDATE REGISTRO_ATENDIMENTO
       SET ID_LEITO = NULL
     WHERE ID_REGISTRO_ATENDIMENTO = 1;
    SAVEPOINT antes_novo_leito;
    UPDATE REGISTRO_ATENDIMENTO
       SET ID_LEITO = 2
     WHERE ID_REGISTRO_ATENDIMENTO = 1;
    -- Detectou leito ocupado? Volte só a parte perigosa
    ROLLBACK TO SAVEPOINT antes_novo_leito;
    COMMIT;
END;
/

--Transação para Atualização em Massa com Controle


BEGIN
    UPDATE COLABORADOR
       SET EMAIL = LOWER(EMAIL)
     WHERE EMAIL != LOWER(EMAIL);
    SAVEPOINT antes_atualizacao_enderecos;
    UPDATE PACIENTE
       SET ENDERECO = 'Endereço não informado'
     WHERE ENDERECO IS NULL OR TRIM(ENDERECO) = '';
    -- Detectou muitos endereços alterados? Volte só a parte perigosa
    ROLLBACK TO SAVEPOINT antes_atualizacao_enderecos;
    COMMIT;
END;
/


--Transação para Exclusão de Dados com Backup Implícito
DEU ERRO - 
BEGIN
    INSERT INTO AUDITORIA (ACAO_REALIZADA, TABELA_AFETADA)
    VALUES ('Backup antes de exclusão', 'AGENDAMENTO');
    SAVEPOINT antes_exclusao_agendamentos;
    DELETE FROM AGENDAMENTO
     WHERE DATA_INICIO < ADD_MONTHS(SYSDATE, -6)
       AND NOT EXISTS (
           SELECT 1 FROM REGISTRO_ATENDIMENTO ra 
            WHERE ra.ID_AGENDAMENTO = AGENDAMENTO.ID_AGENDAMENTO
       );
    -- Detectou muitas exclusões? Volte só a parte perigosa
    ROLLBACK TO SAVEPOINT antes_exclusao_agendamentos;
    COMMIT;
END;
/

 

--Transação para Atualização de Convênios


BEGIN
    UPDATE CONVENIO
       SET TELEFONE = '1133334444'
     WHERE ID_CONVENIO = 1;
    SAVEPOINT antes_exclusao_planos;
    DELETE FROM PLANO_SAUDE
     WHERE ID_CONVENIO = 1
       AND PRECO = 0;
    -- Detectou planos sendo removidos? Volte só a parte perigosa
    ROLLBACK TO SAVEPOINT antes_exclusao_planos;
    COMMIT;
END;
/




--Transação para Reorganização de Setores

BEGIN
    UPDATE SETOR
       SET OBSERVACAO = 'Setor reorganizado'
     WHERE ID_SETOR = 1;
    SAVEPOINT antes_mover_leitos;
    UPDATE LEITO
       SET ID_SETOR = 2
     WHERE ID_SETOR = 1;
    -- Detectou leitos sendo movidos? Volte só a parte perigosa
    ROLLBACK TO SAVEPOINT antes_mover_leitos;
    COMMIT;
END;
/



-- Transação para Atualização de Cargos

BEGIN
    UPDATE CARGO
       SET OBSERVACAO = 'Período integral'
     WHERE ID_CARGO = 3;
    SAVEPOINT antes_inativar_colaboradores;
    UPDATE COLABORADOR
       SET TELEFONE = 'INATIVO'
     WHERE ID_CARGO = 3
       AND DATA_NASCIMENTO < DATE '1980-01-01';
    -- Detectou colaboradores sendo inativados? Volte só a parte perigosa
    ROLLBACK TO SAVEPOINT antes_inativar_colaboradores;
    COMMIT;
END;
/



	
