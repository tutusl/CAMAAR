# frozen_string_literal: true

class Disciplina < ApplicationRecord
  self.primary_key = 'codigoDisciplina'

  belongs_to :departamento, class_name: 'Departamento'
  has_many :turmas, class_name: 'Turma'

  validates :codigoDisciplina, presence: true, uniqueness: true
  validates :nomeDisciplina, presence: true
  validates :departamento_id, presence: true
end
