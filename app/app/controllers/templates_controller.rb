# app/controllers/templates_controller.rb
class TemplatesController < ApplicationController
    skip_before_action :require_login
    def index
      @templates = Template.all
      @template = Template.new
    end
  
    def create
        @template = Template.new
        @template.nomeTemplate = template_params[:nomeTemplate]
        @template.semestre = template_params[:semestre]
        @template.idTemplate = "TEMPLATE_#{Time.current.to_i}"
        @template.dataCriacao = Time.current
        
        if @template.save
          redirect_to templates_path# app/controllers/templates_controller.rb
          class TemplatesController < ApplicationController
            def index
              @templates = Template.all
            end
          
            def new
              @template = Template.new
              @template.questoes.build
            end
          
            def create
              @template = Template.new(template_params)
              if @template.save
                redirect_to templates_path
              else
                render :new
              end
            end
          
            private
          
            def template_params
              params.require(:template).permit(:idTemplate, :nomeTemplate, :dataCriacao, :semestre, questoes_attributes: [:id, :tipo, :enunciado, :_destroy])
            end
          end
          @templates = Template.all
          render :index
        end
      end