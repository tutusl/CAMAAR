Feature: Importar dados do SIGAA para o sistema CAMAAR
  Como administrador do sistema
  Quero importar dados de turmas, matérias e participantes do SIGAA
  Caso não existam na base de dados atual
  Para alimentar a base de dados do sistema CAMAAR

  Scenario: Acessar a funcionalidade de importação
    Given que o administrador está autenticado no sistema CAMAAR
    When ele acessar a página "Importar dados SIGAA"
    And clicar no botão "Iniciar importação"
    Then ele deve ver a opção de "Importar dados do SIGAA"

  Scenario: Iniciar a importação de dados
    Given que o administrador está na página "Importar dados SIGAA"
    When ele clicar no botão "Iniciar importação"
    Then o sistema deve buscar os dados de turmas, matérias e participantes no SIGAA

  Scenario: Verificar existência de dados na base atual
    Given que os dados foram buscados no SIGAA
    When o sistema verificar que os dados já existem na base de dados do CAMAAR
    Then ele deve identificar os dados que não existem na base atual
    And inserir esses dados na base de dados

  Scenario: Confirmar a conclusão da importação
    Given que os dados foram inseridos com sucesso na base de dados do CAMAAR
    Then o administrador deve ver uma mensagem de sucesso "Importação concluída com sucesso"
    And a base de dados do sistema CAMAAR deve ser atualizada com as informações importadas

  Scenario: Falha na inserção de novos dados
    Given que os dados inexistentes foram preparados para inserção
    When o sistema tentar inserir os novos dados na base de dados do CAMAAR
    And ocorrer um erro durante a inserção
    Then o sistema deve exibir uma mensagem de erro "Erro ao inserir os dados na base."