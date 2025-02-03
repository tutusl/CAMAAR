# app/components/template_card_component.rb
class TemplateCardComponent < ViewComponent::Base
    def initialize(template:)
      @template = template
    end
  
    def render?
      @template.present?
    end
  
    private
  
    def template_link
      link_to @template.nomeTemplate, edit_template_path(@template)
    end
  
    def template_meta
      content_tag :div, class: 'text-gray-500' do
        "Criado em: #{@template.dataCriacao.strftime('%d/%m/%Y')}"
      end
    end
  
    def template_actions
      content_tag :div, class: 'flex justify-end' do
        link_to 'Editar', edit_template_path(@template), class: 'btn btn-primary mr-2' +
        link_to 'Excluir', template_path(@template), method: :delete, data: { confirm: 'Tem certeza?' }, class: 'btn btn-danger'
      end
    end
  end