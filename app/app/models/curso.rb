class Curso < ApplicationRecord
    has_many :usuarios
    
    validates :idCurso, presence: true, uniqueness: true
    validates :nomeCurso, presence: true
  end