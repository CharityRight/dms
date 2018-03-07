# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'
require 'rack/test'
require 'pry-byebug'

SPEC_ROOT = Pathname(__FILE__).dirname

require_relative SPEC_ROOT.join('../system/dms/container')
require 'database_cleaner'

require_relative SPEC_ROOT.join('../system/dms/web')
require_relative SPEC_ROOT.join('../apps/main/system/dms/main/web')
require_relative 'support/web/helpers'
require_relative 'support/db/helpers'

require 'database_cleaner'
DatabaseCleaner[:sequel, connection: Test::DatabaseHelpers.db].strategy = :truncation

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.include Rack::Test::Methods
  config.include Test::WebHelpers

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.example_status_persistence_file_path = 'spec/examples.txt'

  config.default_formatter = 'doc' if config.files_to_run.one?

  config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed

  config.before :suite do
    DatabaseCleaner.clean_with :truncation
    Test::WebHelpers.app.freeze
  end

  config.around :each do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
