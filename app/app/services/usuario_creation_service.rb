# frozen_string_literal: true

class UsuarioCreationService
  def initialize(pending_user, params)
    @pending_user = pending_user
    @params = params
  end

  def call
    return { success: false, error: 'Token inválido ou expirado.' } if @pending_user&.token_expired?

    unless @params[:password] == @params[:password_confirmation]
      return { success: false,
               error: 'As senhas não coincidem.' }
    end

    curso = Curso.find_by(nomeCurso: @pending_user.curso) if @pending_user.curso.present?
    departamento = Departamento.find_by(nomeDepartamento: @pending_user.departamento)

    return { success: false, error: 'Departamento inválido.' } unless departamento

    usuario = Usuario.new(
      nome: @pending_user.nome,
      email: @pending_user.email,
      matricula: @pending_user.matricula,
      curso_id: curso&.id,
      departamento_id: departamento.id,
      password: @params[:password],
      papel: @pending_user.papel,
      formacao: @pending_user.formacao
    )

    if usuario.save
      @pending_user.destroy
      { success: true, usuario: usuario }
    else
      { success: false, error: usuario.errors.full_messages.to_sentence }
    end
  end
end
