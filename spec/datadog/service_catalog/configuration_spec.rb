# frozen_string_literal: true

require 'yaml'

module Datadog
  module ServiceCatalog
    RSpec.describe Configuration do
      subject(:sut) { described_class.new }

      let(:api_key) { 'abc-123' }
      let(:application_key) { 'def-456' }

      it { is_expected.to respond_to :datadog_api_key }

      describe '.datadog_api_key' do
        subject { sut.datadog_api_key }

        it { is_expected.to be_nil }

        context 'when setting' do
          before { sut.datadog_api_key = api_key }

          it { is_expected.to eq api_key }
        end
      end

      it { is_expected.to respond_to :datadog_application_key }

      describe '.datadog_application_key' do
        subject { sut.datadog_application_key }

        it { is_expected.to be_nil }

        context 'when setting' do
          before { sut.datadog_application_key = application_key }

          it { is_expected.to eq application_key }
        end
      end

      it { is_expected.to respond_to :datadog_keys }

      describe '.datadog_keys' do
        subject { sut.datadog_keys }

        before do
          sut.datadog_application_key = application_key
          sut.datadog_api_key = api_key
        end

        it { is_expected.to be_a Hash }

        it { is_expected.to include(application_key: application_key, api_key: api_key) }
      end

      it { is_expected.to respond_to :markdown_file }

      describe '.markdown_file' do
        subject { sut.markdown_file }

        it { is_expected.to eq 'README.md' }

        context 'when setting' do
          before { sut.markdown_file = 'sample.md' }

          it { is_expected.to eq 'sample.md' }
        end
      end
    end
  end
end
