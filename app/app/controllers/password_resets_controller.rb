class PasswordResetsController < ApplicationController
    skip_before_action :require_login
  
    def new; end
  
    def create
      @usuario = Usuario.find_by(email: params[:email])
      @usuario&.generate_password_reset_token!
      UserMailer.email_alterar_senha(@usuario).deliver_later if @usuario
      redirect_to root_path, notice: 'Instruções de redefinição enviadas para seu e-mail.'
    end
  
    def edit
      @usuario = Usuario.find_by(id: params[:user])
      unless @usuario && !@usuario.password_reset_expired?
        redirect_to root_path, alert: 'Link inválido ou expirado.' 
      end
    end
  
    def update
      @usuario = Usuario.find_by(id: params[:user])
      puts "AAAAAAAAAAAAAAAAA"
      puts password_params
      if @usuario.update(password_params)
        redirect_to root_path, notice: 'Senha redefinida com sucesso!'
      else
        render :edit
      end
    end
  
    private
  
    def password_params
      params.require(:usuario).permit(:password, :password_confirmation)
    end
  end