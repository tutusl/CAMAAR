# frozen_string_literal: true

# features/support/env.rb

# Carrega o ambiente Rails
require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'environment'))

# Carrega as gems necessárias
require 'cucumber/rails'
require 'capybara/rails'
require 'capybara/cucumber'
require 'capybara-screenshot/cucumber'
require 'selenium-webdriver'
require 'database_cleaner/active_record'

# Configuração do Capybara
Capybara.register_driver :selenium_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless') # Executa o Chrome em modo headless (sem interface gráfica)
  options.add_argument('--disable-gpu')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--window-size=1400,1400')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

# Define o driver padrão do Capybara
Capybara.default_driver = :rack_test # Driver rápido para testes sem JavaScript
Capybara.javascript_driver = :selenium_chrome # Driver para testes com JavaScript

# Configuração do Capybara Screenshot (para tirar screenshots em caso de falhas)
Capybara.save_path = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'tmp', 'capybara'))
Capybara::Screenshot.autosave_on_failure = true

# Configuração do DatabaseCleaner
DatabaseCleaner.strategy = :transaction
DatabaseCleaner.allow_remote_database_url = true if ENV['CI']

# Hook para limpar o banco de dados antes de cada cenário
Before do
  DatabaseCleaner.start
end

After do |_scenario|
  DatabaseCleaner.clean
  Capybara.reset_session! # Limpa a sessão do Capybara após cada cenário
end

# Configuração do Warden (para autenticação em testes)
if defined?(Warden)
  include Warden::Test::Helpers
  Warden.test_mode!
end

# Configuração do Rails para desabilitar logs durante os testes
Rails.logger.level = :info

# Carrega as factories do FactoryBot
World(FactoryBot::Syntax::Methods)

# Configuração adicional para suporte a JavaScript
Capybara.server = :puma, { Silent: true } # Usa o servidor Puma para testes com JavaScript
Capybara.default_max_wait_time = 5 # Define o tempo máximo de espera para elementos aparecerem

# Configuração para ignorar exceções específicas (opcional)
Capybara.ignore_hidden_elements = true
Capybara.server_errors = [Net::ReadTimeout] # Ignora erros de timeout do servidor
