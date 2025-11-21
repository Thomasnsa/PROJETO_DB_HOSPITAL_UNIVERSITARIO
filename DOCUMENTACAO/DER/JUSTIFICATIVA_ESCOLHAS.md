JUSTIFICA DAS ESCOLHAS

Criamos um pouco mais de tabelas do que o solicitado originalmente, especialmente as relacionadas a faturamento e formas de pagamento. Isso foi feito para garantir um controle mais detalhado sobre as modalidades de pagamento e melhorar a rastreabilidade financeira.

Centralizamos diversas entidades ao redor da tabela registro_atendimento, pois ela é o elemento principal do processo e influencia diretamente vários outros componentes do sistema.

As entidades agendamento e registro_atendimento poderiam ter sido unificadas, já que apresentam uma relação 1:1. Porém, optamos por mantê-las separadas para preservar a organização lógica das responsabilidades de cada uma.

A tabela projeto_pesquisa possui uma FK para registro_atendimento, e registro_atendimento mantém uma relação N:N com colaboradores. Ainda assim, incluímos uma relação N:N entre projeto_pesquisa e colaborador, pois nem todos os colaboradores envolvidos em um atendimento necessariamente participarão de um projeto — como é o caso de pesquisadores ou supervisores.

No registro_atendimento, existe uma tabela associativa de colaboradores e uma FK para agendamento. Já em agendamento, há uma FK para colaborador. Essa configuração permite identificar quem realizou o atendimento presencial quando aplicável. Caso o agendamento tenha sido feito online, o preenchimento dessa FK não é obrigatório.