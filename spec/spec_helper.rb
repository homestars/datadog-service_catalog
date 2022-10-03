# frozen_string_literal: true

require 'simplecov'
require 'simplecov_json_formatter'

SimpleCov.formatter = SimpleCov::Formatter::JSONFormatter
SimpleCov.start

require 'datadog/service_catalog'
require 'support/file_utils'
require 'support/hash_utils'

require 'rspec/json_expectations'

include Support::FileUtils

RSpec.configure do |config|
  config.add_formatter('RspecSonarqubeFormatter', 'coverage/sonarcube-report.xml')

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
