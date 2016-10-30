$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "base_form/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "base_form"
  s.version     = BaseForm::VERSION
  s.authors     = ["andrerpbts"]
  s.email       = ["andrerpbts@gmail.com"]
  s.homepage    = ""
  s.summary     = "A simple and small form objects Rails plugin"
  s.description = "BaseForm is a small and simple Rails plugin to work with Form Objects"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.0", ">= 5.0.0.1"
  s.add_dependency "virtus"

  s.add_development_dependency "postgresql"
  s.add_development_dependency "rspec", "~> 3.5"
  s.add_development_dependency "factory_girl", "~> 4.0"
end
