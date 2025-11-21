PROBLEMAS ENCONTRADOS E SOLUÇÕES APLICADAS

Sincronização entre Internação e Status do Leito: Foi necessário garantir que, quando um paciente fosse internado e recebesse um leito, as tabelas REGISTRO_ATENDIMENTO e LEITO permanecem coerentes, a solução que encontramos foi as trigger onde foi criada duas triggers: 

trg_atribui_leito_auto (Antes)
Se o ID_LEITO for preenchido: o campo INTERNACAO vira automaticamente 'SIM'.


Se INTERNACAO = 'NAO':  o ID_LEITO é automaticamente zerado (NULL).


trg_ocupa_leito_status (Depois)
Quando um leito é atribuído o status do leito muda para 'Ocupado'.


Quando o leito é liberado o  status muda para 'Em limpeza'.


Essas triggers mantêm coerência entre atendimento e disponibilidade do leito.

Relacionamentos Muitos-para-Muitos (M:N): Havia dúvidas sugerindo que tabelas de associação não eram necessárias, a solução que encontramos foi as tabelas de associação foram mantidas corretamente: PROJETO_PESQUISA_COLABORADOR, AGENDAMENTO_PROCEDIMENTO_PRECO. Isso guardou as relações M:N sem alterar o modelo

Tinhamos feito M:N de auditoria e colaborador, mas posteriormente percebemos que não tinha sido necessário, então realizamos o devido ajuste com a cardinalidade 1:N com FK em auditoria.

Nos aconselhamos com o professor, discutimos e realizamos reuniões para conclusão do projeto, e debatemos muito a respeito da modelagem de entidades e relacionamentos. Se houvesse mais tempo, poderíamos ter feito uma modelagem com maior quantidade de entidades, porém a modelagem atual está bem elaborada.