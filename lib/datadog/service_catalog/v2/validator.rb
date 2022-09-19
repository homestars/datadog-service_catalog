# frozen_string_literal: true

require 'json_schemer'
require 'forwardable'

module Datadog
  module ServiceCatalog
    module V2
      # V2::Validator - validate the front matter against the provided schema
      class Validator
        extend Forwardable

        MISSING_SERVICE_IDENTIFIERS_ERROR = 'Error: no service_identifiers specified'
        ERROR_FORMATTER = proc { |error| JSONSchemer::Errors.pretty(error) }

        def initialize(service_definition:)
          @service_definition = service_definition
          schema = Schema.new.get
          @schemer = JSONSchemer.schema(schema)
        end

        def valid?
          schemer.valid?(body) && !service_identifiers.empty?
        end

        def errors
          schema_errors + service_identifier_errors.to_a
        end

        private

        def body
          service_definition.body(service_identifier: 'validator-identifier')
        end

        def_delegators :service_definition, :service_identifiers

        def schema_errors
          schemer.validate(body).to_a.map(&ERROR_FORMATTER)
        end

        def service_identifier_errors
          [MISSING_SERVICE_IDENTIFIERS_ERROR] if service_identifiers.empty?
        end

        attr_reader :service_definition, :schemer
      end
    end
  end
end
