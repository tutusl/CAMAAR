Feature: Cadastro de usuários no sistema escolar
  Como um administrador
  Eu quero Cadastrar um usuário no sistema e importar os dados do usuário do SIGAA
  Para que ele possa acessar o sistema

  Scenario: Cadastro bem-sucedido de usuário
    Given que eu estou na página de cadastro
    When eu seleciono o tipo de usuário "Aluno" ou "Professor"
    And eu preencho o campo único de "email" com o email do usuário
    And eu clico no botão "enviar solicitação da definição da senha"
    Then eu devo ver a mensagem "Redefinição de senha enviada por email"
    And o usuario deve receber esse link por email
    And eu devo importar os dados do usuario do SIGAA para o sistema CAAMAR

  Scenario: Tentativa de cadastro com email já existente
    Given que existe um usuário cadastrado com o email "joao@email.com"
    When eu tento cadastrar um novo usuário com o email "joao@email.com"
    Then eu devo ver a mensagem "Email já cadastrado no sistema"

  Scenario: Tentativa de cadastro sem selecionar tipo de usuário
    Given que eu estou na página de cadastro
    When eu preencho todos os campos exceto "Tipo de Usuário"
    And eu clico no botão "Cadastrar"
    Then eu devo ver a mensagem "É necessário selecionar um tipo de usuário"