class PendingUsersController < ApplicationController
  def create(usuario_params)
    # Cria um registro temporário do usuário
    pending_user = PendingUser.create(usuario_params)

    if pending_user.persisted?
      UserMailer.email_define_senha(pending_user).deliver_now
      redirect_to root_path, notice: 'E-mail enviado para definir a senha.'
    end
  end

  private

  def usuario_params
    params.permit(
      :matricula, :nome, :email,
      :papel, :formacao, :departamento, :curso
    )
  end
end
