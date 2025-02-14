class UserMailer < ApplicationMailer
  default from: "software.engenharia.2024.2@gmail.com"

  def email_define_senha(pending_user)
    @pending_user = pending_user
    @url = "http://127.0.0.1:3000/usuarios/new?token=#{pending_user.token}"
    mail(to: @pending_user.email, subject: "Defina sua senha no sistema CAMAAR")
  end

  def email_alterar_senha(usuario)
    @usuario_alterar = usuario
    @url = "http://127.0.0.1:3000/usuarios/alterar_senha"
    mail(to: @usuario_alterar.email, subject: "Altere sua senha no sistema CAMAAR")
  end
end
