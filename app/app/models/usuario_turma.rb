# frozen_string_literal: true

class UsuarioTurma < ApplicationRecord
  belongs_to :usuario, foreign_key: 'usuario_id'
  belongs_to :turma, foreign_key: 'turma_id'

  validates :usuario_id, presence: true, uniqueness: true
  validates :turma_id, presence: true, uniqueness: true
end
