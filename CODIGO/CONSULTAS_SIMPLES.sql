-- #######################################################################
-- # CONSULTAS BÁSICAS (SELECTS PUROS) COM DOCUMENTAÇÃO
-- #######################################################################

-- 1. Cargo_View – Análise do resultado: A consulta retorna todos os cargos cadastrados no sistema, mostrando apenas o ID, o nome e a observação.
-- Uso: Serve para conferir rapidamente quais cargos existem, como “médico”, “enfermeiro” ou “recepcionista”.
SELECT
ID_CARGO,
NOME_CARGO,
OBSERVACAO
FROM
CARGO;

---

-- 2. Setor_View – Análise do resultado: A consulta retorna todos os setores do hospital, exibindo o ID, nome e observações.
-- Uso: Permite visualizar setores como UTI, laboratório ou recepção. É útil para organizar e consultar áreas internas do hospital.
SELECT
ID_SETOR,
NOME_SETOR,
OBSERVACAO
FROM
SETOR;

---

-- 3. Convenio_View – Análise do resultado: A consulta mostra todos os convênios cadastrados, incluindo nome, CNPJ e telefone.
-- Uso: Através dessa visão, é possível verificar rapidamente quais convênios são aceitos e seus dados principais.
SELECT
ID_CONVENIO,
NOME_CONVENIO,
CNPJ,
TELEFONE
FROM
CONVENIO;

---

-- 4. Auditoria_View – Análise do resultado: Retorna o histórico de ações realizadas no sistema, como alterações e exclusões, mostrando a data, a ação e a tabela afetada.
-- Uso: É usada para controle e segurança, permitindo identificar modificações feitas no banco.
SELECT
ID_AUDITORIA,
DATA_HORA_AUDITORIA,
ACAO_REALIZADA,
TABELA_AFETADA
FROM
AUDITORIA;

---

-- 5. Paciente_View – Análise do resultado: A consulta retorna dados completos dos pacientes cadastrados, como nome, sexo, endereço e CPF.
-- Uso: Ela simplifica a visualização dos pacientes. Serve para consultas rápidas na recepção ou busca por CPF.
SELECT
ID_PACIENTE,
NOME,
SEXO,
DATA_NASCIMENTO,
ENDERECO,
TELEFONE,
EMAIL,
CPF
FROM
PACIENTE;

---

-- 6. Leito_View – Análise do resultado: Mostra os leitos existentes no hospital, indicando o setor, número e status (livre ou ocupado).
-- Uso: Ajuda a verificar em qual setor há vagas disponíveis. É fundamental para internações.
SELECT
ID_LEITO,
ID_SETOR,
NUMERO_LEITO,
STATUS
FROM
LEITO;

---

-- 7. Colaborador_View – Análise do resultado: Retorna os colaboradores com seus cargos, dados pessoais e contato.
-- Uso: Essa visão facilita verificações rápidas de funcionários e suas funções no hospital.
SELECT
ID_COLABORADOR,
ID_CARGO,
NOME,
DATA_NASCIMENTO,
ENDERECO,
TELEFONE,
EMAIL,
SEXO,
CPF
FROM
COLABORADOR;

---

-- 8. Plano_Saude_View – Análise do resultado: A consulta exibe os planos de saúde disponíveis, com preço, tipo e convênio vinculado.
-- Uso: Ajuda a verificar quais planos o paciente pode utilizar e seus valores.
SELECT
ID_PLANO_SAUDE,
ID_CONVENIO,
NOME_PLANO,
TIPO_PLANO,
PRECO,
OBSERVACAO
FROM
PLANO_SAUDE;

---

-- 9. Agendamento_View – Análise do resultado: A consulta retorna todos os agendamentos feitos, incluindo paciente, colaborador e data.
-- Uso: É uma visão completa da agenda do hospital, permitindo saber quem tem consulta marcada e quando.
SELECT
ID_AGENDAMENTO,
ID_PLANO_SAUDE,
ID_PACIENTE,
ID_COLABORADOR,
VALOR_ORCAMENTO,
DATA_INICIO,
DATA_FIM,
TIPO_ATENDIMENTO,
OBSERVACAO
FROM
AGENDAMENTO;

---

-- 10. Tipo_Pagamento_View – Análise do resultado: A consulta mostra todas as formas de pagamento cadastradas no sistema.
-- Uso: Simplifica a visualização de tipos como “dinheiro”, “cartão” ou “pix”.
SELECT
ID_TIPO_PAGAMENTO,
TIPO_PAGAMENTO
FROM
TIPO_PAGAMENTO;

---

-- 11. Registro_Atendimento_View – Análise do resultado: Retorna informações detalhadas sobre atendimentos realizados, como diagnóstico, leito, pagamento e alta.
-- Uso: É uma visão completa do atendimento do paciente, usada para histórico clínico e faturamento.
SELECT
ID_REGISTRO_ATENDIMENTO,
ID_AGENDAMENTO,
ID_LEITO,
ID_PLANO_SAUDE,
DATA_INICIO_ATENDIMENTO,
VALOR_FATURADO,
STATUS_PAGAMENTO,
DIAGNOSTICO,
DATA_HORA_ALTA,
INTERNACAO,
STATUS,
OBSERVACAO
FROM
REGISTRO_ATENDIMENTO;

---

-- 12. Projeto_Pesquisa_View – Análise do resultado: Mostra projetos de pesquisa vinculados a atendimentos.
-- Uso: Serve para monitorar pesquisas científicas em andamento no hospital.
SELECT
ID_PROJETO_PESQUISA,
ID_REGISTRO_ATENDIMENTO,
NOME_PROJETO,
STATUS,
OBJETIVO,
OBSERVACAO
FROM
PROJETO_PESQUISA;

---

-- 13. Procedimento_Preco_View – Análise do resultado: Traz os procedimentos médicos cadastrados, com seus preços e observações.
-- Uso: Ajuda a montar orçamentos e calcular valores cobrados.
SELECT
ID_PROCEDIMENTO,
ID_AGENDAMENTO,
NOME_PROCEDIMENTO,
PRECO,
OBSERVACAO
FROM
PROCEDIMENTO_PRECO;

---

-- 14. Historico_Paciente_View – Análise do resultado: A consulta mostra registros históricos de cada paciente, como ocorrências e datas.
-- Uso: É usada para acompanhar a evolução clínica ao longo do tempo.
SELECT
ID_HISTORICO_PACIENTE,
ID_PACIENTE,
ID_REGISTRO_ATENDIMENTO,
DATA_REGISTRO,
OBSERVACAO
FROM
HISTORICO_PACIENTE;

---

-- 15. Item_Faturamento_View – Análise do resultado: Exibe itens cobrados em cada atendimento, mostrando acréscimos, descontos e novo valor.
-- Uso: Ajuda a calcular o valor final faturado para cada paciente.
SELECT
ID_ITEM_FATURAMENTO,
ID_PROCEDIMENTO,
ID_REGISTRO_ATENDIMENTO,
ACRESCIMO,
DESCONTO,
NOVO_VALOR
FROM
ITEM_FATURAMENTO;

---

-- 16. Exame_Solicitado_View – Análise do resultado: Mostra exames solicitados, com datas, resultados e laudos.
-- Uso: Permite acompanhar o status dos exames e visualizar resultados rapidamente.
SELECT
ID_EXAME_SOLICITADO,
ID_PROCEDIMENTO,
ID_SETOR,
ID_REGISTRO_ATENDIMENTO,
NOME_EXAME,
DATA_SOLICITACAO,
DATA_FINALIZACAO,
RESULTADO_EXAME,
LAUDO,
STATUS
FROM
EXAME_SOLICITADO;

---

-- 17. Colaborador_Auditoria_View – Análise do resultado: Retorna quais colaboradores participaram de auditorias.
-- Uso: Serve para rastrear quem verificou ou alterou informações no sistema.
SELECT
ID_AUDITORIA,
ID_COLABORADOR
FROM
COLABORADOR_AUDITORIA;

---

-- 18. Projeto_Pesquisa_Colaborador_View – Análise do resultado: Mostra colaboradores envolvidos em projetos de pesquisa.
-- Uso: A visão ajuda a identificar equipes responsáveis por estudos internos.
SELECT
ID_COLABORADOR,
ID_PROJETO_PESQUISA
FROM
PROJETO_PESQUISA_COLABORADOR;

---

-- 19. Agendamento_Procedimento_Preco_View – Análise do resultado: Exibe os procedimentos vinculados a cada agendamento.
-- Uso: É essencial para cobrança e conferência dos serviços realizados no atendimento.
SELECT
ID_PROCEDIMENTO,
ID_AGENDAMENTO
FROM
AGENDAMENTO_PROCEDIMENTO_PRECO;

---

-- 20. Registro_Atendimento_Setor_View – Análise do resultado: Mostra os setores envolvidos em cada atendimento.
-- Uso: Ajuda a entender o caminho do paciente dentro do hospital.
SELECT
ID_REGISTRO_ATENDIMENTO,
ID_SETOR
FROM
REGISTRO_ATENDIMENTO_SETOR;

---

-- 21. Registro_Atendimento_Tipo_Pagamento_View – Análise do resultado: Retorna pagamentos realizados, incluindo valor, data e parcelas.
-- Uso: Usada para relatórios financeiros e controle de pagamento dos atendimentos.
SELECT
ID_TIPO_PAGAMENTO,
ID_REGISTRO_ATENDIMENTO,
VALOR_PAGO,
DATA_PAGAMENTO,
PARCELAS
FROM
REGISTRO_ATENDIMENTO_TIPO_PAGAMENTO;