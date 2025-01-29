class ImportaDadosController < ApplicationController
  require 'json'

  skip_before_action :require_login
  def import
    file_path = Rails.root.join('config', 'routes.rb').dirname.join('class_members.json')

    # Verifica se o arquivo existe antes de processar
    if File.exist?(file_path)
      # Lê e parseia o JSON
      data = JSON.parse(File.read(file_path))

      # Distribui os dados para os outros controllers
      distribui_data(data)

    end 
  end

  private

  # Método para distribuir os dados processados
  def distribui_data(data)
    UsuariosController.cadastra_usuarios(data)
  end
end
