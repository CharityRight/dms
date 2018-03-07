# frozen_string_literal: true

require_relative 'spec_helper'
require 'database_cleaner'

require_relative SPEC_ROOT.join('../system/dms/web')
require_relative SPEC_ROOT.join('../apps/main/system/dms/main/web')
require_relative 'support/web/helpers'
require_relative 'support/db/helpers'

Dir[SPEC_ROOT.join('support/web/*.rb').to_s].each(&method(:require))

# TODO: Move into db_spec_helper
require 'database_cleaner'
DatabaseCleaner[:sequel, connection: Test::DatabaseHelpers.db].strategy = :truncation

# Use the minitest-hooks plugin to add the :all condition
# To run code before any specs in the suite are executed
class Minitest::Spec
  before :all do
    include Rack::Test::Methods
    include Test::WebHelpers
    Test::WebHelpers.app.freeze
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end
end
