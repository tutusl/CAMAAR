# frozen_string_literal: true

class CursosController < ApplicationController
  def create(cursos_data)
    cursos_data.each do |curso|
      id_departamento = Departamento.find_by(nomeDepartamento: curso[:nomeDepartamento])
      Curso.new(nomeCurso: curso[:nomeCurso], departamento_id: id_departamento.id)
    end
  end
end
