# app/models/template.rb
class Template < ApplicationRecord
  has_many :formularios
  has_many :questaos
  validates :nomeTemplate, presence: true
  validates :dataCriacao, presence: true
  validates :semestre, presence: true

  accepts_nested_attributes_for :questaos, allow_destroy: true
end