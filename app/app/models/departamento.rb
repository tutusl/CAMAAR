class Departamento < ApplicationRecord
    has_many :usuarios
    has_many :disciplinas
    
    validates :nomeDepartamento, presence: true
end