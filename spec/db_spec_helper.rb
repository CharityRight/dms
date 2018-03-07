# frozen_string_literal: true

require 'database_cleaner'
require_relative 'test_helper'
require_relative 'support/db/helpers'

DatabaseCleaner[:sequel, connection: Test::DatabaseHelpers.db].strategy = :truncation

class Minitest::Spec
  include Rack::Test::Methods
  before :all do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end
end
