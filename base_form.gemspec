# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

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
  s.required_ruby_version = '>= 2.7.0'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_development_dependency 'bootsnap', '~> 1.16'
  s.add_development_dependency 'bundler', '~> 2.4.17'
  s.add_development_dependency 'factory_bot_rails', '~> 6.2'
  s.add_development_dependency 'listen', '~> 3.8'
  s.add_development_dependency 'rails', '~> 5.2.8.1'
  s.add_development_dependency 'rspec-rails', '~> 4.0'
  s.add_development_dependency 'rubocop', '1.55.0'
  s.add_development_dependency 'sqlite3', '~> 1.6.3'

  s.add_runtime_dependency 'activesupport', '>= 3.2'
  s.add_runtime_dependency 'virtus', '~> 2.0'
  s.metadata['rubygems_mfa_required'] = 'true'
end
