# Login como administrador ou usuário comum
Dado("que estou logado como {string}") do |user_type|
    case user_type.downcase
    when "administrador"
      @user = create(:user, role: 'admin', email: 'admin@admin.com', password: 'admin')
    when "participante de uma turma"
      @user = create(:user, role: 'participant', email: 'participante@example.com', password: 'password')
    else
      @user = create(:user, email: 'usuario@example.com', password: 'password')
    end
  
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Senha', with: 'password'
    click_button 'Entrar'
  end
  
  # Login com credenciais específicas
  Dado("que estou logado com o email {string} e senha {string}") do |email, password|
    @user = create(:user, email: email, password: password)
    visit new_user_session_path
    fill_in 'Email', with: email
    fill_in 'Senha', with: password
    click_button 'Entrar'
  end
  
  # Visitar a página de login
  Dado("que estou na página de login") do
    visit new_user_session_path
  end
  
  # Preencher campos de login
  Quando("preencho o campo de email com {string}") do |email|
    fill_in 'Email', with: email
  end
  
  Quando("preencho o campo de senha com {string}") do |password|
    fill_in 'Senha', with: password
  end
  
  # Submeter o formulário de login
  Quando("clico no botão de login") do
    click_button 'Entrar'
  end
  
  # Verificar login bem-sucedido
  Então("devo ser redirecionado para a página inicial") do
    expect(page).to have_current_path(root_path)
  end
  
  Então("devo ver uma mensagem de login bem-sucedido") do
    expect(page).to have_content('Login efetuado com sucesso')
  end
  
  # Verificar login inválido
  Então("devo ver uma mensagem de erro {string}") do |message|
    expect(page).to have_content(message)
  end
  
  # Logout
  Quando("clico no link de logout") do
    click_link 'Sair'
  end
  
  Então("devo ser redirecionado para a página de login") do
    expect(page).to have_current_path(new_user_session_path)
  end
  
  Então("devo ver uma mensagem de logout {string}") do |message|
    expect(page).to have_content(message)
  end