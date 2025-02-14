Feature: Login de usuário
  Como um usuário registrado
  Eu quero fazer login no sistema
  Para que eu possa acessar minhas informações

  Scenario: Login bem-sucedido
    Given que eu estou na página de login
    And existe um usuário cadastrado com email "teste1@teste1.com" e senha "teste1"
    When eu preencho o campo "Email" com "teste1@teste1.com"
    And eu preencho o campo "Senha" com "teste1"
    And eu clico no botão "Entrar"
    Then eu devo ser redirecionado para a página inicial do meu papel de usuário(Aluno, Professor ou Administrador)

  Scenario: Login com credenciais inválidas
    Given que eu estou na página de login
    When eu preencho o campo "Email" com "email@invalido.com"
    And eu preencho o campo "Senha" com "senhaerrada"
    And eu clico no botão "Entrar"
    Then eu devo permanecer na página de login

  Scenario: Tentativa de login com campos vazios
    Given que eu estou na página de login
    When eu clico no botão "Entrar"
    Then eu devo permanecer na página de login