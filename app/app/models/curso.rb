class Curso < ApplicationRecord
    has_many :usuarios
    
    validates :nomeCurso, presence: true
end