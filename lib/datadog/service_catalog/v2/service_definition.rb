# frozen_string_literal: true

require 'httparty'
require 'forwardable'

module Datadog
  module ServiceCatalog
    module V2
      # V2::ServiceDefinition - Service Catalog Service Definition API
      class ServiceDefinition
        include HTTParty
        extend V2
        extend Forwardable
        def_delegators :@validator, :valid?, :errors
        def_delegator :@front_matter_content, :services, :service_identifiers
        def_delegator :@front_matter_content, :body, :fm_body
        def_delegator :@front_matter_content, :filename

        SERVICE_DEFINITION_PATH = '/services/definitions'

        def initialize(front_matter_content_klass: FrontMatter::Content, validator_klass: Validator)
          @front_matter_content = front_matter_content_klass.new
          @validator = validator_klass.new(service_definition: self)
        end

        def body(service_identifier:)
          fm_body.merge(datadog_params(service_identifier))
        end

        def upload(service_identifier:)
          raise error_report(service_identifier) unless valid?

          response = Datadog::ServiceCatalog::V2::CreateOrUpdate.call(
            service_identifier: service_identifier,
            service_definition: self
          )

          response.success? && !response.parsed_response['data'].empty?
        end

        def upload_all
          service_identifiers.map do |service_identifier|
            upload(service_identifier: service_identifier)
          end
        end

        private

        def error_report(service_identifier)
          <<~ERROR_REPORT
            The following errors for file '#{filename}', service '#{service_identifier}' prevented upload:
            #{errors}
          ERROR_REPORT
        end

        def datadog_params(service_identifier)
          {
            'schema-version' => SCHEMA_VERSION,
            'dd-service' => service_identifier
          }
        end
      end
    end
  end
end
