# frozen_string_literal: true

class Turma < ApplicationRecord
  belongs_to :disciplina, foreign_key: 'codigoDisciplina'
  has_many :usuario_turmas
  has_many :usuarios, through: :usuario_turmas
  has_many :formulario_turmas
  has_many :formularios, through: :formulario_turmas

  validates :codigoDisciplina, presence: true
  validates :codigoTurma, presence: true
  validates :semestre, presence: true
  validates :horario, presence: true
end
