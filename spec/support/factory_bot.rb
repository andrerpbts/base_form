# frozen_string_literal: true

require 'factory_bot'
require 'factory_bot_rails'

Dir["#{File.dirname(__FILE__)}/factories/**/*.rb"].each do |f|
  require f
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end
end
