# frozen_string_literal: true

class Curso < ApplicationRecord
  has_many :usuarios

  validates :nomeCurso, presence: true
  validates :departamento_id, presence: true

  belongs_to :departamento, class_name: 'Departamento'
end
