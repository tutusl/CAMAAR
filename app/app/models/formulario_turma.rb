class FormularioTurma < ApplicationRecord
    belongs_to :turma, foreign_key: 'idTurma'
    belongs_to :formulario, foreign_key: 'idFormulario'
  end