# app/models/template.rb
class Template < ApplicationRecord
  has_many :formularios
  has_many :questaos
  validates :idTemplate, presence: true, uniqueness: true
  validates :nomeTemplate, presence: true
  validates :dataCriacao, presence: true
  validates :semestre, presence: true
end