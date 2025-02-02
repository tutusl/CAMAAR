class DisciplinasController < ApplicationController
  def self.create(disciplinas_data)
    disciplinas_array = disciplinas_data["disciplinas"] || disciplinas_data[:disciplinas] || []

    disciplinas_array.each do |disciplina|
      idDepartamento = Departamento.find_by(nomeDepartamento: disciplina["nomeDepartamento"])
      Disciplina.create!(
        codigoDisciplina: disciplina["codigoDisciplina"],
        nomeDisciplina: disciplina["nomeDisciplina"],
        departamento_id: idDepartamento&.id # Garante que não passe um objeto em vez do ID
      )
    end
  end
end
