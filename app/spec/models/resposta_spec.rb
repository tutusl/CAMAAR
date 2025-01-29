require 'rails_helper'

RSpec.describe Resposta, type: :model do
  let(:departamento) { Departamento.create(
    idDepartamento: 1,
    nomeDepartamento: "Departamento de Informática"
  )}
  
  let(:curso) { Curso.create(
    idCurso: 1,
    nomeCurso: "Ciência da Computação"
  )}
  
  let(:usuario) { Usuario.create(
    matricula: "20240001",
    nome: "João Silva",
    email: "joao@exemplo.com",
    senha: "senha123",
    papel: "Discente",
    formacao: "Graduando",
    idCurso: curso.id,
    idDepartamento: departamento.id
  )}
  
  let(:template) { Template.create(
    idTemplate: 1,
    nomeTemplate: "Avaliação de Disciplina",
    dataCriacao: Date.today,
    semestre: "2024.1"
  )}
  
  let(:formulario) { Formulario.create(
    idFormulario: 1,
    idTemplate: template.id,
    dataCriacao: Date.today,
    tipoDestinatario: "Aluno"
  )}
  
  let(:questao) { Questao.create(
    idQuestao: 1,
    idTemplate: template.id,
    enunciado: "Como você avalia a disciplina?",
    tipoQuestao: "multipla_escolha"
  )}

  it "Cria uma resposta válida" do
    resposta = Resposta.new(
      idResposta: 1,
      idUsuario: usuario.id,
      idFormulario: formulario.id,
      idQuestao: questao.id,
      dataResposta: Date.today,
      valorResposta: "Muito boa"
    )
    expect(resposta).to be_valid
  end
end