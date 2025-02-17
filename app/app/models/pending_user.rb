# frozen_string_literal: true

class PendingUser < ApplicationRecord
  before_create :generate_token
  after_create :send_confirmation_email

  validates :nome, :email, :matricula, :curso, :departamento, :papel, :formacao, presence: true

  def token_expired?
    token_created_at < 2.hours.ago
  end

  private

  def generate_token
    self.token = SecureRandom.hex(10) # Gera um token único
    self.token_created_at = Time.current
  end

  def send_confirmation_email
    UserMailer.email_define_senha(self).deliver_later # Envia o email
  end
end
