# frozen_string_literal: true

class Resposta < ApplicationRecord
  belongs_to :usuario
  belongs_to :formulario
  belongs_to :questao

  validates :dataResposta, presence: true
  validates :valorResposta, presence: true
end