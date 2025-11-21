---PEGA O NOME DOS PACIENTES QUE FORAM INTERNADOS E SEUS DIAGNOSTICOS---
SELECT 
P.NOME,
R.DIAGNOSTICO,
R.INTERNACAO
FROM REGISTRO_ATENDIMENTO R
JOIN AGENDAMENTO A ON R.ID_AGENDAMENTO = A.ID_AGENDAMENTO
JOIN PACIENTE P ON A.ID_PACIENTE = P.ID_PACIENTE
WHERE R.INTERNACAO = 'SIM';

---A consulta seleciona o nome dos pacientes e, no WHERE, verifica se o ID do paciente
--- aparece na subconsulta. A subconsulta identifica quais pacientes realmente tiveram
--- um exame solicitado: primeiro verifica se o paciente possui um agendamento, depois
--- confere se esse agendamento está registrado na tabela de registro de atendimento, 
--- e por fim verifica se existe algum exame solicitado relacionado a esse atendimento.
--- Se todas essas condições forem verdadeiras, o ID do paciente aparece na subconsulta 
--- e, assim, seu nome é retornado pela consulta principal.
SELECT NOME
FROM PACIENTE
WHERE ID_PACIENTE IN (
    SELECT A.ID_PACIENTE
    FROM AGENDAMENTO A
    JOIN REGISTRO_ATENDIMENTO R
    ON A.ID_AGENDAMENTO = R.ID_AGENDAMENTO
    JOIN EXAME_SOLICITADO E
    ON E.ID_REGISTRO_ATENDIMENTO = R.ID_REGISTRO_ATENDIMENTO
);


---VAI MOSTRAR A QUANTIDADE DE ATENDIMENTO POR STATUS
SELECT 
    STATUS,
    COUNT(*) AS QUANTIDADE
    FROM REGISTRO_ATENDIMENTO
    GROUP BY STATUS;

---MOSTRA STATUS QUE TIVERAM MAIS DE 3 ATENDIMENTOS
SELECT 
    STATUS,
    COUNT(*) AS QUANTIDADE
    FROM REGISTRO_ATENDIMENTO
    GROUP BY STATUS
    HAVING COUNT(*) >3;