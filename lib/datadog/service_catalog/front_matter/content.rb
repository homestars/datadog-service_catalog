# frozen_string_literal: true

module Datadog
  module ServiceCatalog
    module FrontMatter
      # FrontMatter::Content - organize the front matter content
      class Content
        DD_SERVICE_IDENTIFIERS_KEY = 'datadog_service_identifiers'
        NO_FRONT_MATTER_ERROR_MSG_PROC = proc { |filename| "Error: no markdown front matter found in '#{filename}'" }

        def initialize(parser_klass: Parser)
          @parser = parser_klass.new(file_path: filename)
        end

        def filename
          ServiceCatalog.configuration.markdown_file
        end

        def services
          fetch_front_matter if @services.nil?
          @services
        end

        def body
          fetch_front_matter if @body.nil?
          @body
        end

        private

        def fetch_front_matter
          @body = parser.parse.tap do |c|
            raise NO_FRONT_MATTER_ERROR_MSG_PROC.call(filename) if c.nil? || c.empty?

            @services = c.delete(DD_SERVICE_IDENTIFIERS_KEY).to_a
          end
        end

        attr_reader :parser
      end
    end
  end
end
