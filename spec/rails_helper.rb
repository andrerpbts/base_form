# frozen_string_literal: true

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

require 'support/test_app/config/environment'

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rails/all'
require 'rspec/rails'

# Require support files
Dir[Rails.root.join('..', '*.rb')].each { |f| require f }

# Require this lib
require 'base_form'

ActiveRecord::Migration.maintain_test_schema!

# set up db
# be sure to update the schema if required by doing
# - cd spec/rails_app
# - rake db:migrate
ActiveRecord::Schema.verbose = false
load 'support/test_app/db/schema.rb' # use db agnostic schema by default


