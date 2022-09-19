# frozen_string_literal: true

module Datadog
  module ServiceCatalog
    module V2
      RSpec.describe CreateOrUpdate do
        describe 'class' do
          subject(:sut) { described_class }

          it { is_expected.to respond_to :base_uri }

          describe '#base_uri' do
            subject { described_class.base_uri }

            it { is_expected.to eq('https://api.datadoghq.com/api/v2') }
          end

          it { is_expected.to respond_to :call }

          describe '#call' do
            before do
              ServiceCatalog.configure do |config|
                config.datadog_api_key = api_key
                config.datadog_application_key = application_key
              end
              allow(described_class).to receive(:post)
              sut.call(service_identifier: service_identifier, service_definition: service_definition_instance_double)
            end

            let(:service_identifier) { 'abc-123' }
            let(:service_definition_instance_double) { instance_double(ServiceDefinition, body: body) }
            let(:body) { { paramA: 'A', paramB: 'B' } }
            let(:api_key) { 'api_key' }
            let(:application_key) { 'application_key' }

            it 'sends a POST' do
              expect(described_class).to have_received(:post)
            end

            it 'with the correct path' do
              expect(described_class).to have_received(:post).with(
                described_class::SERVICE_DEFINITION_PATH,
                body: anything,
                headers: anything
              )
            end

            it 'with the service definition body' do
              expect(described_class).to have_received(:post).with(
                anything,
                body: include_json(body),
                headers: anything
              )
            end

            it 'with the correct headers' do
              expect(described_class).to have_received(:post).with(
                anything,
                body: anything,
                headers: expected_headers(api_key, application_key)
              )
            end
          end
        end

        def expected_headers(api_key, application_key)
          {
            'Content-Type' => 'application/json',
            'DD-API-KEY' => api_key,
            'DD-APPLICATION-KEY' => application_key
          }
        end
      end
    end
  end
end
