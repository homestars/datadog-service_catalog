# frozen_string_literal: true

require 'tempfile'

module Support
  module FileUtils
    def create_markdown_file(file_name:, &content)
      Tempfile.new([file_name, '.md']).tap do |file|
        if content
          file.write(content.call)
          file.rewind
        end
      end
    end
  end
end
