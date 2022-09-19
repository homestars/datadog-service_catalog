# frozen_string_literal: true

require 'httparty'

module Datadog
  module ServiceCatalog
    module V2
      # V2::CreateOrUpdate - Create or update the DataDog ServiceDefinition
      class CreateOrUpdate
        include HTTParty
        base_uri 'https://api.datadoghq.com/api/v2'

        SERVICE_DEFINITION_PATH = '/services/definitions'

        class << self
          def call(service_identifier:, service_definition:)
            post(
              SERVICE_DEFINITION_PATH,
              body: service_definition.body(service_identifier: service_identifier).to_json,
              headers: content_type_header.merge(Auth.header)
            )
          end

          def content_type_header
            { 'Content-Type' => 'application/json' }
          end
        end
      end
    end
  end
end
