class Questao < ApplicationRecord
    belongs_to :template
    has_many :respostas
    
    validates :idQuestao, presence: true, uniqueness: true
    validates :enunciado, presence: true
    validates :tipoQuestao, presence: true
  end