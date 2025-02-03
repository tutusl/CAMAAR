Dado('que eu estou na página de login') do
    visit new_session_path
  end
  
  Dado('existe um usuário cadastrado com email {string} e senha {string}') do |email, senha|
    FactoryBot.create(:usuario, # Certifique-se de que a factory está definida como :usuario
      email: email,
      password: senha,
      password_confirmation: senha,
      papel: "administrador"
    )
  end
  
  Quando('eu preencho o campo {string} com {string}') do |campo, valor|
    fill_in campo, with: valor
  end
  
  Quando('eu clico no botão {string}') do |botao|
    click_button botao
  end
  
  Então('eu devo ser redirecionado para a página inicial do meu papel de usuário(Aluno, Professor ou Administrador)') do
    usuario = Usuario.last # Assume que o último usuário criado é o que fez login
    if usuario.admin?
      expect(page).to have_current_path(respostas_path)
    else
      expect(page).to have_current_path(avaliacoes_path)
    end
  end
  
  Então('eu devo ver a mensagem {string}') do |mensagem|
    expect(page).to have_content(mensagem)
  end
  
  Então('eu devo permanecer na página de login') do
    expect(page).to have_current_path(new_session_path)
  end