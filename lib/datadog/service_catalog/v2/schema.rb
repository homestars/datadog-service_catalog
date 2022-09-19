# frozen_string_literal: true

require 'httparty'

module Datadog
  module ServiceCatalog
    module V2
      # V2::Schema - Service Catalog V2 Publish Schema
      class Schema
        include HTTParty

        V2_SCHEMA_PATH = 'https://raw.githubusercontent.com/DataDog/schema/main/service-catalog/v2/schema.json'
        EMPTY_SCHEMA_ERROR_MESSAGE = "Error: no schema loaded @ '#{V2_SCHEMA_PATH}'"
        INVALID_JSON_SCHEMA_ERROR = "Error: invalid json schema @ '#{V2_SCHEMA_PATH}'"

        def get
          fetch_schema
        end

        private

        def remote_get
          self.class.get(V2_SCHEMA_PATH).tap do |result|
            result.response&.value unless result.success?
            raise EMPTY_SCHEMA_ERROR_MESSAGE if schema_empty(result)
          end
        end

        def fetch_schema
          @schema ||= JSON.parse(remote_get.body)
        rescue JSON::ParserError => e
          raise INVALID_JSON_SCHEMA_ERROR + ": #{e.message}"
        end

        def schema_empty(result)
          result.body.nil? || result.body.empty?
        end
      end
    end
  end
end
