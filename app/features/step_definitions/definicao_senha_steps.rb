Dado("que eu receba um e-mail de solicitação de cadastro para criar uma senha") do
    @user = create(:user, password: nil)
    @user.send_confirmation_instructions
    open_email(@user.email)
  end
  
  Dado("que eu seja redirecionado para a página de {string}") do |page_name|
    current_email.click_link 'Definir senha'
    expect(page).to have_current_path(edit_user_password_path)
  end
  
  Quando("eu preencho o campo {string} com uma senha {string}") do |field, password|
    fill_in field, with: password
  end
  
  Então("eu devo ser redirecionado para a página de login") do
    expect(page).to have_current_path(new_user_session_path)
  end