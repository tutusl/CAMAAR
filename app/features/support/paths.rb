# frozen_string_literal: true

# features/support/paths.rb
module NavigationHelpers
  def path_to(page_name)
    case page_name
    when /a página de login/
      new_session_path
    when /a página inicial do administrador/
      respostas_path
    when /a página inicial do (aluno|professor)/
      avaliacoes_path
    else
      raise "Caminho para '#{page_name}' não está definido em #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
