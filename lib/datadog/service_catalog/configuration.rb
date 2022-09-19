# frozen_string_literal: true

module Datadog
  module ServiceCatalog
    # ServiceCatalog::Configuration - gem configuration
    class Configuration
      attr_accessor :datadog_api_key, :datadog_application_key, :markdown_file

      def initialize
        @markdown_file = 'README.md'
      end

      def datadog_keys
        {
          application_key: datadog_application_key,
          api_key: datadog_api_key
        }
      end
    end
  end
end
