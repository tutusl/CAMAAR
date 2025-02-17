# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resposta, type: :model do
  let(:departamento) do
    Departamento.create(
      idDepartamento: 1,
      nomeDepartamento: 'Departamento de Informática'
    )
  end

  let(:curso) do
    Curso.create(
      idCurso: 1,
      nomeCurso: 'Ciência da Computação'
    )
  end

  let(:usuario) do
    Usuario.create(
      matricula: '20240001',
      nome: 'João Silva',
      email: 'joao@exemplo.com',
      senha: 'senha123',
      papel: 'Discente',
      formacao: 'Graduando',
      idCurso: curso.id,
      idDepartamento: departamento.id
    )
  end

  let(:template) do
    Template.create(
      idTemplate: 1,
      nomeTemplate: 'Avaliação de Disciplina',
      dataCriacao: Date.today,
      semestre: '2024.1'
    )
  end

  let(:formulario) do
    Formulario.create(
      idFormulario: 1,
      idTemplate: template.id,
      dataCriacao: Date.today,
      tipoDestinatario: 'Aluno'
    )
  end

  let(:questao) do
    Questao.create(
      idQuestao: 1,
      idTemplate: template.id,
      enunciado: 'Como você avalia a disciplina?',
      tipoQuestao: 'multipla_escolha'
    )
  end

  it 'Cria uma resposta válida' do
    resposta = Resposta.new(
      idResposta: 1,
      idUsuario: usuario.id,
      idFormulario: formulario.id,
      idQuestao: questao.id,
      dataResposta: Date.today,
      valorResposta: 'Muito boa'
    )
    expect(resposta).to be_valid
  end
end
