# Controller responsible for managing Templates and their associated Questions
class TemplatesController < ApplicationController
  # Lists all available templates
  #
  # @note Fetches all templates from the database
  # @return [void]
  # @side_effects
  #   - Assigns @templates instance variable with all Template records
  #   - Renders the index view template
  def index
    # render layout: false
    @templates = Template.all
  end

  # Displays the form for creating a new template
  #
  # @note Initializes a new template with an empty associated question
  # @return [void]
  # @side_effects
  #   - Creates a new Template instance
  #   - Builds an empty associated question
  #   - Renders the new template form
  def new
    @template = Template.new
    @template.questaos.build
  end

  # Creates a new template with its associated questions
  #
  # @note Processes the template creation form submission
  # @return [void]
  # @side_effects
  #   - Creates a new Template record in the database
  #   - Sets the creation date to current time
  #   - Creates associated Question records
  #   - Redirects to templates index on success
  #   - Re-renders new form on failure
  #   - Sets flash notice on success
  #   - Logs parameters and errors for debugging
  def create
    puts "Params recebidos: #{params.inspect}"
    
    @template = Template.new(template_params)
    @template.dataCriacao = Time.current
  
    if @template.questaos.is_a?(Hash)
      puts "questaos não está no formato esperado, ajustando..."
      @template.questaos = @template.questaos.map { |q| Questao.new(q) }
    end
  
    if @template.save
      redirect_to templates_path, notice: 'Template criado com sucesso!'
    else
      puts "Erros ao salvar: #{@template.errors.full_messages}"
      render :new
    end
  end
  
  private

  # Filters and permits template parameters for mass assignment
  #
  # @note Used internally by the create action
  # @return [ActionController::Parameters] Filtered parameters containing template attributes
  #   and nested question attributes
  # @side_effects None
  def template_params
    params.require(:template).permit(
      :nomeTemplate, 
      :dataCriacao, 
      :semestre, 
      questaos_attributes: [:id, :enunciado, :tipoQuestao, :_destroy]
    )
  end
end
