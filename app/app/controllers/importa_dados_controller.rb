class ImportaDadosController < ApplicationController
  require "json"

  skip_before_action :require_login

  def import
    json_dir = Rails.root.join("config", "json_files")

    # Verifica se o diretório existe
    if Dir.exist?(json_dir)
      arquivos_json = Dir.glob(json_dir.join("*.json")) # Lista todos os arquivos JSON

      # Hash para armazenar os dados de cada arquivo
      dados_importados = {}

      arquivos_json.each do |file_path|
        nome_variavel = File.basename(file_path, ".json").to_sym # Nome da variável baseado no nome do arquivo

        # Verifica se o arquivo existe antes de processar
        if File.exist?(file_path)
          # Lê e parseia o JSON
          dados_importados[nome_variavel] = JSON.parse(File.read(file_path))
        end
      end

      processa_dados(dados_importados)
    end
  end

  private

  def processa_dados(dados)
    DepartamentosController.create(dados[:departamentos]) if dados[:departamentos]
    CursosController.create(dados[:cursos]) if dados[:cursos]
    UsuariosController.cadastra_usuarios(dados[:usuarios]) if dados[:usuarios]
    DisciplinasController.create(dados[:disciplinas]) if dados[:disciplinas]
    TurmasController.create(dados[:turmas]) if dados[:turmas]
    ParticipantesController.cadastra_usuario_turmas(dados[:participantes]) if dados[:participantes]
  end
end
