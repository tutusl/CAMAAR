require 'rails_helper'

RSpec.describe Formulario, type: :model do
  let(:template) { Template.create(
    idTemplate: 1,
    nomeTemplate: "Avaliação de Disciplina",
    dataCriacao: Date.today,
    semestre: "2024.1"
  )}

  it "Cria um formulário válido" do
    formulario = Formulario.new(
      idFormulario: 1,
      idTemplate: template.id,
      dataCriacao: Date.today,
      tipoDestinatario: "Aluno"
    )
    expect(formulario).to be_valid
  end
end