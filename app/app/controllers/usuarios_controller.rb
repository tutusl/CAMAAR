class UsuariosController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  
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
    # Recupera o usuário temporário
    pending_user = PendingUser.find_by(token: params[:token])
    
    if pending_user&.token_expired?
      flash.now[:alert] = 'Token inválido ou expirado.'
      render :new, status: :unprocessable_entity and return
    end
    if params[:password] == params[:password_confirmation]
      curso = Curso.find_by(nomeCurso: pending_user.curso) if pending_user.curso.present?
      departamento = Departamento.find_by(nomeDepartamento: pending_user.departamento)

      unless departamento
        flash.now[:alert] = 'Departamento inválido.'
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
    puts "Método cadastra_usuarios foi chamado!"
    usuarios_data.each do |usuario|
      %w[dicente docente].each do |tipo|
        usuario[tipo].each do |pessoa|
          atributos_permitidos = [:nome, :email, :matricula, :curso, :departamento, :papel, :formacao] # Ajuste conforme a tabela
          pessoa = pessoa.symbolize_keys
          puts "Criando usuário: #{pessoa.inspect}" # Verifica se os dados estão corretos0
          PendingUser.create(pessoa.slice(*atributos_permitidos))        
        end
      end
    end
  end
  

  private

  def usuario_params
    params.require(:usuario).permit(
      :matricula, :nome, :email, :password, :password_confirmation,
      :papel, :formacao, :departamento_id, :curso_id
    )
  end
end
