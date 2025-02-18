class DepartamentosController < ApplicationController
  skip_before_action :require_login, only: [:create]

  def create
    departamentos_data = params[:departamentos_data]
    created_departamentos = []

    departamentos_data.each do |departamento|
      created_departamentos << Departamento.create!(
        nomeDepartamento: departamento[:nomeDepartamento]
      )
    end

    render json: { message: 'Departamentos criados com sucesso!', departamentos: created_departamentos }, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end