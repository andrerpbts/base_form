# frozen_string_literal: true

require 'factory_girl'
require 'factory_girl_rails'

Dir["#{File.dirname(__FILE__)}/factories/**/*.rb"].each do |f|
  require f
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.find_definitions
  end
end
