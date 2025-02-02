class TurmasController < ApplicationController
  def self.create(turmas_data)
    turmas_array = turmas_data["turmas"] || turmas_data[:turmas] || []

    turmas_array.each do |turma|
      puts turma
      Turma.create!(codigoDisciplina: turma["code"],
                codigoTurma: turma["class"]["classCode"],
                semestre: turma["class"]["semester"],
                horario: turma["class"]["time"])
    end
  end
end
