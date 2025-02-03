Feature: Redefinição de senha
  Como um usuário já cadastrado
  Eu quero redefinir a minha senha a partir de um e-mail após a solicitação de troca de senha
  Para que eu possa recuperar o acesso a minha conta

  Scenario: Solicitar redefinição de senha
    Given que eu esteja na página de login
    When eu clicar no link "Esqueceu sua senha?"
    Then eu deve ser direcionado para a página "Solicitar redefinição de senha"

  Scenario: Preencher o formulário de solicitação de redefinição de senha
    Given que eu esteja na página "Solicitar redefinição de senha"
    When eu preencher o campo "Digite seu e-mail" com um e-mail já cadastrado
    And clicar no botão "Enviar solicitação"
    Then eu devo ver uma mensagem de confirmação "E-mail enviado"
    And um e-mail com o link para redefinir a senha deve ser enviado para o meu e-mail fornecido

  Scenario: Troca de senha sem e-mail cadastrado
    Given que eu esteja na página "Solicitar redefinição de senha"
    When eu preencher o campo "Digite seu e-mail" com um e-mail não cadastrado
    And clicar no botão "Enviar solicitação"
    Then eu devo receber uma mensagem "E-mail não cadastrado"
    And eu devo permanecer na página "Redefinir senha"

  Scenario: Acessar a página de redefinição de senha
    Given que eu receba um e-mail com o link para redefinir a senha
    When eu clicar no link fornecido no e-mail
    Then eu devo ser direcionado para a página "Redefinir senha"

  Scenario: Cadastrar uma nova senha
    Given que eu esteja na página "Redefinir senha"
    When eu preencher o campo "Nova senha" com uma nova senha válida
    And eu preencher o campo "Repetir senha" com a mesma nova senha
    And clicar no botão "Confirmar"
    Then eu devo ver uma mensagem de confirmação "Senha redefinida com sucesso"
    And eu devo poder acessar o sistema usando a nova senha

  Scenario: "Nova senha" e "Repetir senha" estão diferentes
    Given que eu esteja na página "Redefinir senha"
    When eu preencher o campo "Nova senha" com uma senha "Novasenha123"
    And eu preencher o campo "Repetir senha" com uma senha "senha123"
    And eu clico no botão "Confirmar"
    Then eu devo ver uma mensagem "As senhas não coincidem"
    And eu devo permanecer na página "Redefinir senha"
    And a troca de senha senha não deve ser efetuada
