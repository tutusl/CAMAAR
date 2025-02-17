# frozen_string_literal: true

# controllers/usuarios_controller.rb
class UsuariosController < ApplicationController
  skip_before_action :require_login, only: %i[new create alterar_senha_form]

  def index
    @usuarios = Usuario.all
  end

  def show
    @usuario = Usuario.find(params[:id])
  end

  def new
    # Recupera as informações do PendingUser pelo token
    @pending_user = PendingUser.find_by(token: params[:token])
    if @pending_user && !@pending_user.token_expired?
      render :new
    else
      redirect_to root_path, alert: 'Link inválido ou expirado.'
    end
  end

  def create
    pending_user = PendingUser.find_by(token: params[:token])
    service = UsuarioCreationService.new(pending_user, params)
    result = service.call

    if result[:success]
      redirect_to new_session_path, notice: 'Usuário criado com sucesso.'
    else
      flash.now[:alert] = result[:error]
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @usuario = Usuario.find(params[:id])
  end

  def update
    @usuario = Usuario.find(params[:id])
    if @usuario.update(usuario_params)
      redirect_to @usuario, notice: 'Usuário atualizado com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @usuario = Usuario.find(params[:id])
    @usuario.destroy
    redirect_to usuarios_path, notice: 'Usuário excluído com sucesso.'
  end

  def self.cadastra_usuarios(usuarios_data)
    # Extraindo o array de usuários corretamente0
    usuarios_array = usuarios_data['usuarios'] || usuarios_data[:usuarios] || []

    usuarios_array.each do |usuario|
      usuario_existe = Usuario.find_by(email: usuario['email'])
      pending_user_existe = PendingUser.find_by(email: usuario['email'])
      PendingUser.create(usuario) if usuario_existe.nil? && pending_user_existe.nil?
    end
  end

  def alterar_senha
    @usuario = Usuario.find(params[:id])
    UserMailer.email_alterar_senha(@usuario).deliver_later
    redirect_to edit_usuario_path(@usuario), notice: 'Um e-mail foi enviado para redefinir sua senha.'
  end

  def alterar_senha_form
    render :alterar_senha
  end

  private

  def usuario_params
    params.require(:usuario).permit(
      :matricula, :nome, :email, :password, :password_confirmation,
      :papel, :formacao, :departamento_id, :curso_id
    )
  end

  def ensure_correct_user
    return if current_usuario.id.to_s == params[:id]

    redirect_to root_path, alert: 'Você não tem permissão para essa ação'
  end
end
