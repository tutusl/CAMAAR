# controllers/usuarios_controller.rb
class UsuariosController < ApplicationController
  skip_before_action :require_login, only: [ :new, :create, :alterar_senha_form ]

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
      redirect_to root_path, alert: "Link inválido ou expirado."
    end
  end


  def create
    # Recupera o usuário temporário
    pending_user = PendingUser.find_by(token: params[:token])
    if pending_user&.token_expired?
      flash.now[:alert] = "Token inválido ou expirado."
      render :new, status: :unprocessable_entity and return
    end
    if params[:password] == params[:password_confirmation]
      curso = Curso.find_by(nomeCurso: pending_user.curso) if pending_user.curso.present?
      departamento = Departamento.find_by(nomeDepartamento: pending_user.departamento)

      unless departamento
        flash.now[:alert] = "Departamento inválido."
        render :new, status: :unprocessable_entity and return
      end

      usuario = Usuario.new(
          nome: pending_user.nome,
          email: pending_user.email,
          matricula: pending_user.matricula,
          curso_id: curso&.id,
          departamento_id: departamento.id,
          password: params[:password],
          papel: pending_user.papel,
          formacao: pending_user.formacao
        )

      if usuario.save
        # Remove o registro temporário
        pending_user.destroy
        redirect_to new_session_path, notice: "Usuário criado com sucesso."
      else
        flash.now[:alert] = usuario.errors.full_messages.to_sentence
        render :new, status: :unprocessable_entity
      end
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

  def self.cadastra_usuarios(usuarios_data)
    # Extraindo o array de usuários corretamente0
    usuarios_array = usuarios_data["usuarios"] || usuarios_data[:usuarios] || []

    usuarios_array.each do |usuario|
      usuario_existe = Usuario.find_by(email: usuario["email"])
      pending_user_existe = PendingUser.find_by(email: usuario["email"])
      if usuario_existe.nil? && pending_user_existe.nil?
        PendingUser.create(usuario)
      end
    end
  end

  def alterar_senha
    @usuario = Usuario.find(params[:id])
    UserMailer.email_alterar_senha(@usuario).deliver_later
    redirect_to edit_usuario_path(@usuario), notice: "Um e-mail foi enviado para redefinir sua senha."
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
    unless current_usuario.id.to_s == params[:id]
      redirect_to root_path, alert: 'Você não tem permissão para essa ação'
    end
  end
end
