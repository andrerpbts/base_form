# frozen_string_literal: true

require 'rails/all'
require 'rspec/rails'
require 'support/test_app/config/environment'

ActiveRecord::Migration.maintain_test_schema!

# set up db
# be sure to update the schema if required by doing
# - cd spec/rails_app
# - rake db:migrate
ActiveRecord::Schema.verbose = false
load 'support/test_app/db/schema.rb' # use db agnostic schema by default

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

require 'spec_helper'
