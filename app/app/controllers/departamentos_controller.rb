# frozen_string_literal: true

class DepartamentosController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def create(departamentos_data)
    departamentos_data.each do |departamento|
      Departamento.new(nomeDepartamento: departamento[:nomeDepartamento])
    end
  end
end
