# frozen_string_literal: true

require 'front_matter_parser'

module Datadog
  module ServiceCatalog
    module FrontMatter
      # FrontMatter::Parser - parse the front matter of a file for Service Catalog props
      class Parser
        FILE_NOT_FOUND_ERROR_MSG = 'Error: Requested file not found'

        def initialize(file_path:)
          raise "#{FILE_NOT_FOUND_ERROR_MSG}: #{file_path}" unless FileTest.file?(file_path)

          @file_path = file_path
        end

        def parse
          ::FrontMatterParser::Parser.parse_file(file_path).front_matter
        end

        private

        attr_reader :file_path
      end
    end
  end
end
