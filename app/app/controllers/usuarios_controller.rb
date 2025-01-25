class UsuariosController < ApplicationController
  def index
    @usuarios = Usuario.all
  end

  def show
    @usuario = Usuario.find(params[:id])
  end

  def new
    @usuario = Usuario.new
  end

  skip_before_action :require_login, only: [:new, :create]

  def create
    @usuario = Usuario.new(usuario_params)
    if @usuario.save
      redirect_to new_session_path, notice: "Usuário criado com sucesso."
    else
      Rails.logger.debug "Erro ao salvar usuário: #{@usuario.errors.full_messages.join(', ')}"
      render :new, status: :unprocessable_entity, notice: "Cadastro falhou! Tente novamente."
    end
  end

  def edit
    @usuario = Usuario.find(params[:id])
  end

  def update
    @usuario = Usuario.find(params[:id])
    if @usuario.update(usuario_params)
      redirect_to @usuario, notice: "Usuário atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @usuario = Usuario.find(params[:id])
    @usuario.destroy
    redirect_to usuarios_path, notice: "Usuário excluído com sucesso."
  end

  private

  def usuario_params
    params.require(:usuario).permit(
      :matricula, :nome, :email, :password, :password_confirmation,
      :papel, :formacao, :departamento_id, :curso_id
    )
  end
end
