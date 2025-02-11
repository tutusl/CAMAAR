class SessionsController < ApplicationController
  def new
  end

  skip_before_action :require_login, only: [ :create, :new ]

  def create
    @usuario = Usuario.find_by(email: session_params[:email])
    if @usuario && @usuario.authenticate(session_params[:password])
      session[:user_id] = @usuario.id

      # Redireciona com base no tipo de usuário
      if @usuario.papel == "administrador"
        redirect_to respostas_path
      else
        redirect_to avaliacoes_path
      end
    else
      flash[:notice] = "Login inválido!"
      redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logout feito com sucesso!"
    redirect_to new_session_path
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
