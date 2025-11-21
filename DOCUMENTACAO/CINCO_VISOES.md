5 visões ISO/IEC 10746 (RM-ODP)

1) Visão de Negócio (Enterprise)
•	Propósito: Gestão de procedimentos, auxílio/socorro a pacientes, e treinamento/aprendizado de colaboradores.
•	Atores: Paciente, Médico, Enfermeiro, Técnico de laboratório, estudante etc.
•	Políticas: prioridade de atendimento, cuidado centrado no paciente, controle de acesso a dados /LGPD, auditoria de registros.
•	Processos: cadastrar dados e manter, planejar e executar atendimentos, registrar e monitorar informações clinicas, faturar, auditar e gerar relatórios.
________________________________________
2) Visão de Informação (Information)
•	Conceitos: paciente, colaborador, setor, plano saúde, convênio, agendamento, leito, registro atendimento, histórico paciente, auditoria, projeto_pesquisa.
•	Invariantes:
o	Cada paciente e profissional possui um ID único.
o	Leito só pode estar ocupado por um paciente por vez.
o	Em uma pesquisa além dos estudantes, até o próprio médico e outros colaboradores relacionados podem participar.
o	Toda operação feita no sistema é auditada.
o	Não é possível agendar com um médico em um horário já ocupado.
•	Estados:
o	Leito {DISPONÍVEL, OCUPADO, EM LIMPEZA}
o	Faturamento {CONVÊNIO OU PARTICULAR}
o	Projeto_Pesquisa {NÃO INICIADO, EM ANDAMENTO, CONCLUÍDO}
•	Restrições:
o	O sistema vai gerenciar aproximadamente dados de 500 pessoas. 
o	Pode ser atendido simultaneamente em salas diferentes 20 pacientes.
o	Pode passar na triagem simultaneamente em salas diferentes 5 pacientes.
o	Estudante pode participar de um projeto por vez, já o médico e outros colaboradores relativos, não possuem essa restrição. 

________________________________________
3) Visão Computacional (Computational)
•	Interfaces/serviços:
o	CadastroService: CRUD de pacientes e profissionais.
o	GestaoHospitalarService: controle de setores, leitos e agendamentos.
o	AtendimentoService: registrar diagnósticos e exames.
o	FinanceiroService: faturar procedimentos por convênio ou particular.
o	RelatorioService: dados e auditorias para consultas.
•	Contratos: (colocar todo o código SQL aqui).
________________________________________
4) Visão de Engenharia (Engineering)
•	Oracle
•	Banco relacional
________________________________________
5) Visão Tecnológica (Technology)
•	Live Oracle

