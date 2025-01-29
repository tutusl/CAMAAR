class Disciplina < ApplicationRecord
    belongs_to :departamento
    has_many :turmas, class_name: 'Turma'
    
    validates :codigoDisciplina, presence: true, uniqueness: true
    validates :nomeDisciplina, presence: true
    validates :idDepartamento, presence: true
  end