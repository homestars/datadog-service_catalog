# frozen_string_literal: true

module Datadog
  module ServiceCatalog
    module FrontMatter
      RSpec.describe Content do
        subject(:sut) { described_class.new(parser_klass: parser_klass_double(front_matter)) }

        let(:front_matter) { { described_class::DD_SERVICE_IDENTIFIERS_KEY => services } }
        let(:services) { %w[a b c] }
        let(:body_content) { { 'key_1' => 'value_1', 'key_2' => 'value_2' } }

        it { is_expected.to respond_to :filename }

        describe '.filename' do
          subject { sut.filename }

          it { is_expected.to eq ServiceCatalog.configuration.markdown_file }
        end

        it { is_expected.to respond_to :services }

        describe '.services' do
          subject { sut.services }

          it { is_expected.to be_a Array }

          context 'when there are no services specified' do
            let(:front_matter) { body_content }

            it { is_expected.to be_empty }
          end

          context 'when there are services specified' do
            it { is_expected.to eq services }
          end
        end

        it { is_expected.to respond_to :body }

        describe '.body' do
          subject { sut.body }

          let(:front_matter) { { described_class::DD_SERVICE_IDENTIFIERS_KEY => services }.merge(body_content) }

          it { is_expected.not_to include :services }
          it { is_expected.to eq body_content }
        end

        context 'when there is no front matter' do
          let(:front_matter) { {} }
          let(:filename) { ServiceCatalog.configuration.markdown_file }

          it 'is raises an error' do
            expect { sut.body }.to raise_error(described_class::NO_FRONT_MATTER_ERROR_MSG_PROC.call(filename))
          end
        end

        def parser_instance_double(front_matter)
          instance_double(Parser).tap do |double|
            allow(double).to receive(:parse).and_return(front_matter)
          end
        end

        def parser_klass_double(front_matter)
          class_double(Parser).tap do |double|
            allow(double).to receive(:new).and_return(parser_instance_double(front_matter))
          end
        end
      end
    end
  end
end
