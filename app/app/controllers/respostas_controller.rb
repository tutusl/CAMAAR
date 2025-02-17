# frozen_string_literal: true

class RespostasController < ApplicationController
  before_action :require_login
  before_action :verificar_permissao

  def index
    @turmas = Turma.includes(:usuario_turma, :codigo_disciplina)
                   .joins(:formularios)
                   .distinct
  end

  class RespostasController < ApplicationController
    def create
      @formulario = Formulario.find(params[:formulario_id])
      params[:respostas].each do |questao_id, resposta_texto|
        Resposta.create(
          formulario_id: @formulario.id,
          questao_id: questao_id,
          resposta: resposta_texto,
          usuario_id: current_usuario.id
        )
      end
      redirect_to formulario_path(@formulario), notice: 'Respostas enviadas com sucesso!'
    end
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
    redirect_to root_path, alert: 'Acesso negado!' unless current_user&.admin?
  end
end
