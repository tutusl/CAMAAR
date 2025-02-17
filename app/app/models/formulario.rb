# frozen_string_literal: true

class Formulario < ApplicationRecord
  belongs_to :template
  has_many :formulario_turmas
  has_many :turmas, through: :formulario_turmas
  has_many :respostas
  has_many :questaos, through: :template

  validates :dataCriacao, presence: true
  validates :tipoDestinatario, presence: true
end
