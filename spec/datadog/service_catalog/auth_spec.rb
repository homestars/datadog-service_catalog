# frozen_string_literal: true

module Datadog
  module ServiceCatalog
    RSpec.describe Auth do
      subject(:sut) { described_class }

      it { is_expected.to respond_to :header }

      describe '#header' do
        subject(:header) { sut.header }

        context 'with configured DataDog keys' do
          before do
            ServiceCatalog.configure do |config|
              config.datadog_api_key = api_key
              config.datadog_application_key = application_key
            end
          end

          let(:api_key) { 'zzz' }
          let(:application_key) { '999' }

          it { is_expected.to be_a Hash }

          it { is_expected.to have_key 'DD-API-KEY' }

          describe 'DD-API-KEY' do
            subject { header['DD-API-KEY'] }

            it { is_expected.to be api_key }
          end

          it { is_expected.to have_key 'DD-APPLICATION-KEY' }

          describe 'DD-APPLICATION-KEY' do
            subject { header['DD-APPLICATION-KEY'] }

            it { is_expected.to be application_key }
          end
        end

        context 'with NO configured DataDog keys' do
          before do
            ServiceCatalog.configure do |config|
              config.datadog_api_key = nil
              config.datadog_application_key = nil
            end
          end

          it 'is expected to raise an error' do
            expect { sut.header }.to raise_error(described_class::NO_CONFIGURED_DATADOG_AUTH_MESSAGE)
          end
        end
      end
    end
  end
end
