# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'base_form/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'base_form'
  s.version     = BaseForm::VERSION
  s.authors     = ['andrerpbts']
  s.email       = ['andrerpbts@gmail.com']
  s.homepage    = 'https://github.com/andrerpbts/base_form'
  s.summary     = 'A simple and small form objects Rails plugin'
  s.description = 'BaseForm is a small and simple Rails plugin to work with Form Objects'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_development_dependency 'bundler', '~> 1.16'
  s.add_development_dependency 'codeclimate-test-reporter'
  s.add_development_dependency 'factory_bot_rails', '~> 4.0'
  s.add_development_dependency 'rails', '~> 6.0'
  s.add_development_dependency 'rspec-rails', '~> 3.5'
  s.add_development_dependency 'rubocop', '0.49.0'
  s.add_development_dependency 'shoulda-matchers', '~> 3.1'
  s.add_development_dependency 'sqlite3', '~> 1.3.13'

  s.add_runtime_dependency 'activesupport', '>= 3.2'
  s.add_runtime_dependency 'virtus', '~> 1.0'
end
