# frozen_string_literal: true

# Login como administrador ou usuário comum
Dado('que estou logado como {string}') do |user_type|
  @user = case user_type.downcase
          when 'administrador'
            create(:user, role: 'admin', email: 'admin@admin.com', password: 'admin')
          when 'participante de uma turma'
            create(:user, role: 'participant', email: 'participante@example.com', password: 'password')
          else
            create(:user, email: 'usuario@example.com', password: 'password')
          end

  visit new_user_session_path
  fill_in 'Email', with: @user.email
  fill_in 'Senha', with: 'password'
  click_button 'Entrar'
end

# Login com credenciais específicas
Dado('que estou logado com o email {string} e senha {string}') do |email, password|
  @user = create(:user, email: email, password: password)
  visit new_user_session_path
  fill_in 'Email', with: email
  fill_in 'Senha', with: password
  click_button 'Entrar'
end

# Visitar a página de login
Dado('que estou na página de login') do
  visit new_user_session_path
end

# Preencher campos de login
Quando('preencho o campo de email com {string}') do |email|
  fill_in 'Email', with: email
end

Quando('preencho o campo de senha com {string}') do |password|
  fill_in 'Senha', with: password
end

# Submeter o formulário de login
Quando('clico no botão de login') do
  click_button 'Entrar'
end

# Verificar login bem-sucedido
Então('devo ser redirecionado para a página inicial') do
  expect(page).to have_current_path(root_path)
end

# Logout
Quando('clico no link de logout') do
  click_link 'Sair'
end

Então('devo ser redirecionado para a página de login') do
  expect(page).to have_current_path(new_user_session_path)
end

Então('devo ver uma mensagem de logout {string}') do |message|
  expect(page).to have_content(message)
end

Dado('que eu estou na página de login') do
  visit new_session_path
end

Dado('existe um usuário cadastrado com email {string} e senha {string}') do |email, senha|
  FactoryBot.create(:usuario,
                    email: email,
                    password: senha,
                    password_confirmation: senha,
                    papel: 'administrador')
end

Quando('eu preencho o campo {string} com {string}') do |campo, valor|
  fill_in campo, with: valor
end

Quando('eu clico no botão Entrar') do |botao|
  click_button botao
end

Então('eu devo ser redirecionado para a página inicial do meu papel de usuário\(Aluno, Professor ou Administrador)') do
  usuario = Usuario.last
  if usuario.admin?
    expect(page).to have_current_path(respostas_path)
  else
    expect(page).to have_current_path(avaliacoes_path)
  end
end

Então('eu devo permanecer na página de login') do
  expect(page).to have_current_path(new_session_path)
end
