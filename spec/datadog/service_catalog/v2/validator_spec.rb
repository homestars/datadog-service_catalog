# frozen_string_literal: true

module Datadog
  module ServiceCatalog
    module V2
      RSpec.describe Validator do
        subject(:sut) do
          described_class.new(service_definition: service_definition_instance_double(service_identifiers, body))
        end

        let(:service_identifiers) { ['service-1'] }
        let(:body) do
          {
            'schema-version' => SCHEMA_VERSION,
            'dd-service' => 'service-1'
          }
        end
        let(:missing_body_error_msg) { 'root is missing required keys: schema-version, dd-service' }

        it { is_expected.to respond_to :valid? }

        describe '.valid?' do
          context 'when it matches the schema' do
            subject { sut.valid? }

            it { is_expected.to be_truthy }
          end

          context 'when it does NOT match the schema' do
            subject { sut.valid? }

            let(:body) { { 'abc' => 11 } }

            it { is_expected.to be_falsey }
          end

          context 'when service_identifiers is empty' do
            subject { sut.valid? }

            let(:service_identifiers) { [] }

            it { is_expected.to be_falsey }
          end
        end

        it { is_expected.to respond_to :errors }

        describe 'error messages' do
          subject { sut.errors }

          context 'when it is valid' do
            it { is_expected.to be_empty }
          end

          context 'when the body is NOT valid' do
            let(:body) { {} }

            it { is_expected.not_to be_empty }
            it { is_expected.to have_attributes(count: 1) }
            it { is_expected.to eq [missing_body_error_msg] }
          end

          context 'when service_identifiers is empty' do
            let(:service_identifiers) { [] }

            it { is_expected.not_to be_empty }
            it { is_expected.to have_attributes(count: 1) }
            it { is_expected.to eq [described_class::MISSING_SERVICE_IDENTIFIERS_ERROR] }
          end

          context 'when BOTH the body is NOT valid and service_identifiers is empty' do
            let(:body) { {} }
            let(:service_identifiers) { [] }

            it { is_expected.not_to be_empty }
            it { is_expected.to have_attributes(count: 2) }

            it { is_expected.to eq [missing_body_error_msg, described_class::MISSING_SERVICE_IDENTIFIERS_ERROR] }
          end
        end

        def service_definition_instance_double(service_identifiers, body)
          instance_double(ServiceDefinition).tap do |double|
            allow(double).to receive(:service_identifiers).and_return(service_identifiers)
            allow(double).to receive(:body).and_return(body)
          end
        end
      end
    end
  end
end
