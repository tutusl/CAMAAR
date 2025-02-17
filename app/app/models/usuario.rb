# frozen_string_literal: true

class Usuario < ApplicationRecord
  has_secure_password
  validates :matricula, uniqueness: true
  validates :nome, presence: true
  validates :email, presence: true, uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: 'E-mail inválido.' }
  validates :papel, presence: true
  validates :formacao, presence: true
  validates :departamento_id, presence: true
  belongs_to :departamento, class_name: 'Departamento'
  belongs_to :curso, class_name: 'Curso', optional: true
  has_many :usuario_turmas
  has_many :turmas, through: :usuario_turmas
  has_many :respostas

  def admin?
    papel == 'administrador'
  end

  def generate_password_reset_token!
    self.password_reset_token = SecureRandom.urlsafe_base64
    self.password_reset_sent_at = Time.current
    save!(validate: false)
  end
  
  def password_reset_expired?
    password_reset_sent_at < 5.hours.ago
  end
end
