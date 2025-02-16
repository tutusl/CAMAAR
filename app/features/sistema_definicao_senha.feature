Feature: Definir senha para um novo usuário
  Como um novo usuário
  Eu quero definir uma senha para minha conta a partir de um e-mail de solicitação de cadastro
  Para que eu possa ser cadastrado e acessar o sistema

  Scenario: Definição de senha bem-sucedida
    Given que eu receba um e-mail de solicitação de cadastro para criar uma senha
    And que eu seja redirecionado para a página de "Criar senha"
    When eu preencho o campo "Criar senha" com uma senha "Senha123"
    And eu preencho o campo "Repetir senha" com a senha "Senha123"
    And eu clico no botão "Criar senha"
    Then eu devo ver a mensagem "Senha cadastrada com sucesso"
    And eu devo ser redirecionado para a página de login

  Scenario: "Criar senha" e "Repetir senha" estão diferentes
    Given que eu receba um e-mail de solicitação de cadastro para criar uma senha
    And que eu seja redirecionado para a página de "Criar senha"
    When eu preencho o campo "Criar senha" com uma senha "Senha123"
    And eu preencho o campo "Repetir senha" com uma senha "senha#exemplo"
    And eu clico no botão "Criar senha"
    Then eu devo ver a mensagem "As senhas não coincidem"
    And eu devo permanecer na página de "Criar senha"

