# frozen_string_literal: true

require 'yaml'

module Datadog
  module ServiceCatalog
    module FrontMatter
      RSpec.describe Parser do
        subject(:sut) { described_class.new(file_path: path) }

        after { file.unlink }

        let(:file) { create_markdown_file(file_name: 'README') { front_matter + content } }
        let(:path) { file.path }
        let(:front_matter) { '' }
        let(:content) { '### Markdown content' }

        context 'when the file does not exist' do
          let(:path) { 'blort' }

          it 'raises a file not found error' do
            expect { sut }.to raise_error("#{described_class::FILE_NOT_FOUND_ERROR_MSG}: #{path}")
          end
        end

        it { is_expected.to respond_to :parse }

        describe '#parse' do
          subject { sut.parse }

          context 'when there is no front matter' do
            let(:front_matter) { '' }

            it { is_expected.to be_empty }
          end

          context 'when there is front matter' do
            let(:front_matter) do
              <<~MARKDOWN
                #{hash_front_matter.to_yaml.chomp}
                ---
              MARKDOWN
            end

            let(:hash_front_matter) { { title: 'Hello' }.stringify_keys }

            it { is_expected.to eq(hash_front_matter) }
          end
        end
      end
    end
  end
end
