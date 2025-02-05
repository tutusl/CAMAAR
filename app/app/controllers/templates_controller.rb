class TemplatesController < ApplicationController
  def index
    # render layout: false
    @templates = Template.all
  end

  def new
    @template = Template.new
    @template.questaos.build
  end

  def create
    @template = Template.new(template_params)
    @template.idTemplate = "TEMPLATE_#{Time.current.to_i}"  # Se necessário
    @template.dataCriacao = Time.current

    if @template.save
      redirect_to templates_path, notice: 'Template criado com sucesso!'
    else
      render :new
    end
  end

  private

  def template_params
    params.require(:template).permit(:nomeTemplate, :dataCriacao, :semestre, questoes_attributes: [:id, :tipo, :enunciado, :_destroy])
  end
end
