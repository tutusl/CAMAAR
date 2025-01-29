class UsuarioTurma < ApplicationRecord
    belongs_to :usuario, foreign_key: 'idUsuario'
    belongs_to :turma, foreign_key: 'idTurma'
  end