# frozen_string_literal: true

require 'datadog/service_catalog'
require 'support/file_utils'
require 'support/hash_utils'

require 'rspec/json_expectations'

require 'simplecov'
require 'simplecov_json_formatter'

include Support::FileUtils

SimpleCov.formatter = SimpleCov::Formatter::JSONFormatter
SimpleCov.start

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
