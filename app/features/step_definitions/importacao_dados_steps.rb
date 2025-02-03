Quando("ele acessar a página {string}") do |page_name|
    case page_name
    when "Importar dados SIGAA"
      visit importar_dados_path
    end
  end
  
  Então("ele deve ver a opção de {string}") do |option|
    expect(page).to have_content(option)
  end
  
  Dado("que os dados foram buscados no SIGAA") do
    # Simula a busca de dados do SIGAA
    @dados_sigaa = { turmas: ['Turma A', 'Turma B'] }
  end
  
  Quando("o sistema verificar que os dados já existem na base de dados do CAMAAR") do
    # Cria uma turma existente para simular conflito
    create(:turma, nome: 'Turma A')
  end
  
  Então("ele deve identificar os dados que não existem na base atual") do
    @dados_novos = @dados_sigaa[:turmas].reject { |turma| Turma.exists?(nome: turma) }
  end
  
  Então("inserir esses dados na base de dados") do
    @dados_novos.each { |turma| create(:turma, nome: turma) }
  end
  
  Então("a base de dados do sistema CAMAAR deve ser atualizada com as informações importadas") do
    expect(Turma.count).to eq(2)
  end