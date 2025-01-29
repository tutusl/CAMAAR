class Departamento < ApplicationRecord
    has_many :usuarios
    has_many :disciplinas
    
    validates :idDepartamento, presence: true, uniqueness: true
    validates :nomeDepartamento, presence: true
  end