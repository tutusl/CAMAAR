class Resposta < ApplicationRecord
    belongs_to :usuario
    belongs_to :formulario
    belongs_to :questao
    
    validates :idResposta, presence: true, uniqueness: true
    validates :dataResposta, presence: true
    validates :valorResposta, presence: true
  end