class CursosController < ApplicationController
  skip_before_action :require_login, only: [:create] # Skip authentication for this action if needed

  def create
    cursos_data = params[:cursos_data]
    created_cursos = []

    cursos_data.each do |curso|
      departamento = Departamento.find_by(nomeDepartamento: curso[:nomeDepartamento])
      raise "Departamento não encontrado: #{curso[:nomeDepartamento]}" unless departamento

      created_cursos << Curso.create!(
        nomeCurso: curso[:nomeCurso],
        departamento_id: departamento.id
      )
    end

    render json: { message: 'Cursos criados com sucesso!', cursos: created_cursos }, status: :created
  rescue StandardError => e
    Rails.logger.error("Erro ao criar cursos: #{e.message}")
    render json: { error: e.message }, status: :unprocessable_entity
  end
end