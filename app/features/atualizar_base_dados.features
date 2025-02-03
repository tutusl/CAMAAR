Feature: Atualizar a base de dados do sistema CAMAAR com dados do SIGAA
  Como administrador do sistema
  Quero atualizar a base de dados já existente com os dados atuais do SIGAA
  Para corrigir a base de dados do sistema e mantê-la atualizada

  Scenario: Acessar a funcionalidade de atualização de dados
    Given que o administrador está autenticado no sistema CAMAAR
    And está na página "Atualizar base de dados"
    When ele clicar no botão "Iniciar atualização"
    Then o sistema deve buscar os dados mais recentes de turmas, matérias e participantes no SIGAA

  Scenario: Verificar e comparar dados com a base atual
    Given que os dados mais recentes foram buscados no SIGAA
    When o sistema comparar os dados do SIGAA com a base de dados atual do CAMAAR
    Then ele deve substituir os dados antigos pelos novos
    And garantir que a integridade da base seja mantida
    And deve ver uma mensagem de sucesso "Base de dados atualizada com sucesso"

  Scenario: Falha ao atualizar registros na base de dados
    Given que existe alguma inconsistência dos dados com a base de dados
    When o sistema tentar atualizar os dados na base de dados CAMAAR
    And ocorrer um erro durante a atualização
    Then o sistema deve exibir uma mensagem de erro "Erro ao atualizar dados."
    And reverter qualquer alteração parcial feita
