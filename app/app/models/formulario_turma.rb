# frozen_string_literal: true

class FormularioTurma < ApplicationRecord
  belongs_to :turma
  belongs_to :formulario
end
