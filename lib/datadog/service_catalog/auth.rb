# frozen_string_literal: true

module Datadog
  module ServiceCatalog
    # ServiceCatalog::Auth - Auth generation for DataDog
    class Auth
      NO_CONFIGURED_DATADOG_AUTH_MESSAGE = 'Error: missing configuration for datadog_api_key/datadog_application_key'

      class << self
        def header
          datadog_keys = ServiceCatalog.configuration.datadog_keys

          raise NO_CONFIGURED_DATADOG_AUTH_MESSAGE if datadog_keys.values.any?(&:nil?)

          {
            'DD-API-KEY' => datadog_keys[:api_key],
            'DD-APPLICATION-KEY' => datadog_keys[:application_key]
          }
        end
      end
    end
  end
end
