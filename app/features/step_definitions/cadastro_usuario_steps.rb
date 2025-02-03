Dado("que eu estou na página de cadastro") do
    visit new_user_registration_path
  end
  
  Quando("eu seleciono o tipo de usuário {string}") do |user_type|
    select user_type, from: 'Tipo de Usuário'
  end
  
  Quando("eu preencho o campo único de {string} com o email do usuário") do |field|
    fill_in field, with: 'novo_usuario@example.com'
  end
  
  Quando("eu clico no botão {string}") do |button|
    click_button button
  end
  
  Então("eu devo ver a mensagem {string}") do |message|
    expect(page).to have_content(message)
  end
  
  Então("o usuario deve receber esse link por email") do
    # Usando a gem 'letter_opener' para verificar emails em ambiente de teste
    open_email('novo_usuario@example.com')
    expect(current_email).to have_content('Redefinição de senha')
  end
  
  Dado("que existe um usuário cadastrado com o email {string}") do |email|
    create(:user, email: email)
  end
  
  Quando("eu tento cadastrar um novo usuário com o email {string}") do |email|
    fill_in 'Email', with: email
    click_button 'Cadastrar'
  end
  
  Quando("eu preencho todos os campos exceto {string}") do |field|
    fill_in 'Email', with: 'usuario@example.com'
    # Deixa o campo "Tipo de Usuário" em branco
  end