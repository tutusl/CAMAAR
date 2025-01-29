require 'rails_helper'

RSpec.describe Turma, type: :model do
  let(:departamento) { Departamento.create(
    idDepartamento: 1,
    nomeDepartamento: "Departamento de Informática"
  )}
  
  let(:disciplina) { Disciplina.create(
    codigoDisciplina: "INF001",
    nomeDisciplina: "Programação Web",
    idDepartamento: departamento.id
  )}

  it "Cria uma turma válida" do
    turma = Turma.new(
      idTurma: 1,
      codigoTurma: "TURMA2024.1",
      codigoDisciplina: disciplina.codigoDisciplina,
      semestre: "2024.1",
      horario: "Segunda 14:00-16:00"
    )
    expect(turma).to be_valid
  end

  it "Não cria turma sem código" do
    turma = Turma.new(
      idTurma: 1,
      codigoDisciplina: disciplina.codigoDisciplina,
      semestre: "2024.1",
      horario: "Segunda 14:00-16:00"
    )
    expect(turma).not_to be_valid
  end
end