class RespostasController < ApplicationController
  before_action :require_login
  before_action :verificar_permissao

  def index
    @turmas = Turma.includes(:usuario_turma, :codigo_disciplina)
                   .joins(:formularios)
                   .distinct
  end

  def show
    @formulario = Formulario.find(params[:id])
    @questoes = @formulario.template.questoes

    # Cálculo das porcentagens
    @estatisticas = @questoes.map do |questao|
      respostas = questao.respostas.group(:valorResposta).count
      total_respostas = respostas.values.sum
      {
        questao: questao.enunciado,
        respostas: respostas.transform_values { |v| ((v.to_f / total_respostas) * 100).round(2) }
      }
    end
  end

  private

  def verificar_permissao
    redirect_to root_path, alert: "Acesso negado!" unless current_user&.admin?
  end
end
