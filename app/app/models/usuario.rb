class Usuario < ApplicationRecord
  has_secure_password
  validates :matricula, uniqueness: true
  validates :nome, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "E-mail inválido." }
  validates :papel, presence: true
  validates :formacao, presence: true
  validates :departamento_id, presence: true
  belongs_to :departamento, class_name: "Departamento"
  belongs_to :curso, class_name: "Curso", optional: true
  has_many :usuario_turmas
  has_many :turmas, through: :usuario_turmas
  has_many :respostas
  private
end
