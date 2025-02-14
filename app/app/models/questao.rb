# app/models/questao.rb
class Questao < ApplicationRecord
  belongs_to :template

  validates :tipo, presence: true
  validates :enunciado, presence: true
end