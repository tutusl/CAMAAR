# frozen_string_literal: true

# app/models/questao.rb
class Questao < ApplicationRecord
  belongs_to :template
  has_many :respostas

  validates :tipoQuestao, presence: true
  validates :enunciado, presence: true
end
