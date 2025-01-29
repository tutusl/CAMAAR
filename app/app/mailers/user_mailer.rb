class UserMailer < ApplicationMailer
  default from: 'software.engenharia.2024.2@gmail.com'

  def email_define_senha(pending_user)
    @pending_user = pending_user
    @url = "http://127.0.0.1:3000/usuarios/new?token=#{pending_user.token}"
    puts "olasdas"
    mail(to: @pending_user.email, subject: 'Defina sua senha no sistema CAMAAR')
  end
end

