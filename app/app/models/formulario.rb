class Formulario < ApplicationRecord
    belongs_to :template
    has_many :formulario_turmas
    has_many :turmas, through: :formulario_turmas
    has_many :respostas
    
    validates :idFormulario, presence: true, uniqueness: true
    validates :dataCriacao, presence: true
    validates :tipoDestinatario, presence: true
  end