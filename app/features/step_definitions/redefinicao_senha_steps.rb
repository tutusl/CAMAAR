# frozen_string_literal: true

Dado('que eu esteja na página de login') do
  visit new_user_session_path
end

Quando('eu clicar no link {string}') do |link|
  click_link link
end

Então('eu deve ser direcionado para a página {string}') do |_page_name|
  expect(page).to have_current_path(new_user_password_path)
end

Quando('eu preencher o campo {string} com um e-mail já cadastrado') do |field|
  @user = create(:user)
  fill_in field, with: @user.email
end

Então('um e-mail com o link para redefinir a senha deve ser enviado para o meu e-mail fornecido') do
  open_email(@user.email)
  expect(current_email).to have_link('Redefinir senha')
end

Quando('eu preencher o campo {string} com um e-mail não cadastrado') do |field|
  fill_in field, with: 'nao_cadastrado@example.com'
end

Dado('que eu receba um e-mail com o link para redefinir a senha') do
  @user = create(:user)
  @user.send_reset_password_instructions
  open_email(@user.email)
end

Quando('eu clicar no link fornecido no e-mail') do
  current_email.click_link 'Redefinir senha'
end

Dado('que eu esteja na página {string}') do |page_name|
  case page_name
  when 'Redefinir senha'
    visit edit_user_password_path(reset_password_token: @user.reset_password_token)
  end
end

Quando('eu preencho o campo {string} com uma nova senha válida') do |field|
  fill_in field, with: 'NovaSenha123!'
end

Quando('eu preencho o campo {string} com a mesma nova senha') do |field|
  fill_in field, with: 'NovaSenha123!'
end

Então('eu devo poder acessar o sistema usando a nova senha') do
  visit new_user_session_path
  fill_in 'Email', with: @user.email
  fill_in 'Senha', with: 'NovaSenha123!'
  click_button 'Entrar'
  expect(page).to have_content('Login efetuado com sucesso')
end
