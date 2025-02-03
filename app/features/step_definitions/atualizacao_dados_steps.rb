# features/step_definitions/atualizacao_dados_steps.rb

Dado("que o administrador está autenticado no sistema CAMAAR") do
    @admin = create(:user, role: 'admin')
    visit new_user_session_path
    fill_in 'Email', with: @admin.email
    fill_in 'Senha', with: 'password'
    click_button 'Entrar'
  end
  
  Dado("está na página {string}") do |page_name|
    case page_name
    when "Atualizar base de dados"
      visit atualizar_dados_path
    end
  end
  
  Quando("ele clicar no botão {string}") do |button|
    click_button button
  end
  
  Então("o sistema deve buscar os dados mais recentes de turmas, matérias e participantes no SIGAA") do
    expect(page).to have_content("Dados buscados com sucesso")
  end
  
  Então("ele deve substituir os dados antigos pelos novos") do
    # Exemplo: Verificar se um registro antigo foi substituído
    turma_antiga = Turma.find_by(nome: "Turma Antiga")
    expect(turma_antiga).to be_nil
  end
  
  Então("garantir que a integridade da base seja mantida") do
    # Exemplo: Verificar se todas as turmas têm uma matéria associada
    Turma.all.each do |turma|
      expect(turma.materia).not_to be_nil
    end
  end
  
  Então("deve ver uma mensagem de sucesso {string}") do |message|
    expect(page).to have_content(message)
  end
  
  Então("o sistema deve exibir uma mensagem de erro {string}") do |message|
    expect(page).to have_content(message)
  end
  
  Então("reverter qualquer alteração parcial feita") do
    # Exemplo: Verificar se um registro temporário não foi persistido
    expect(Turma.where(nome: "Turma Temporária")).to be_empty
  end