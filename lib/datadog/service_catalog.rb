# frozen_string_literal: true

require_relative 'service_catalog/auth'
require_relative 'service_catalog/configuration'
require_relative 'service_catalog/front_matter'
require_relative 'service_catalog/version'
require_relative 'service_catalog/v2'
require_relative 'service_catalog/rake_tasks'

module Datadog
  # Datadog::ServiceCatalog - interact with the Datadog ServiceCatalog
  module ServiceCatalog
    class << self
      attr_writer :configuration, :validator
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.configure
      yield(configuration)
    end
  end
end
