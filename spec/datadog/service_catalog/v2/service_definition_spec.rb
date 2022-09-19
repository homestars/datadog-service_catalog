# frozen_string_literal: true

module Datadog
  module ServiceCatalog
    module V2
      RSpec.describe ServiceDefinition do
        subject(:sut) do
          described_class.new(
            front_matter_content_klass: content_klass_double(content_instance),
            validator_klass: validator_klass_double(validator_double)
          )
        end

        let(:services) { [] }
        let(:body) { {} }
        let(:validator_double) { instance_double(Validator, valid?: true, errors: []) }
        let(:service_identifier) { 'a-wonderful-service' }
        let(:content_instance) { content_instance_double(services, body) }

        it { is_expected.to respond_to :service_identifiers }

        describe '.service_identifiers' do
          subject(:sut_service_identifiers) { sut.service_identifiers }

          let(:services) { [service_identifier] }

          it { is_expected.not_to be_empty }
          it { is_expected.to eq services  }
        end

        it { is_expected.to respond_to :body }

        describe '.body' do
          subject(:sut_body) { sut.body(service_identifier: service_identifier) }

          it { is_expected.not_to be_empty }
          it { is_expected.to eq(body.merge(datadog_params(service_identifier))) }
        end

        it { is_expected.to respond_to :valid? }

        describe '.valid?' do
          it 'is expected to call the validator' do
            sut.valid?
            expect(validator_double).to have_received(:valid?)
          end
        end

        it { is_expected.to respond_to :errors }

        describe '.errors' do
          it 'is expected to call the validator' do
            sut.errors
            expect(validator_double).to have_received(:errors)
          end
        end

        it { is_expected.to respond_to :filename }

        describe '.filename' do
          it 'is expected to call the front matter content' do
            sut.filename
            expect(content_instance).to have_received(:filename)
          end
        end

        describe 'uploading service definitions' do
          before { allow(Datadog::ServiceCatalog::V2::CreateOrUpdate).to receive(:call).and_return(api_response_stub) }

          it { is_expected.to respond_to :upload }

          describe '.upload' do
            context 'when the service definition is valid' do
              before { sut.upload(service_identifier: service_identifier) }

              it 'is expected to call CreateOrUpdate' do
                expect(Datadog::ServiceCatalog::V2::CreateOrUpdate).to have_received(:call)
              end
            end

            context 'when the service definition is NOT valid' do
              let(:error_msg) { 'something bad happened' }
              let(:validator_double) { instance_double(Validator, valid?: false, errors: ['something bad happened']) }

              it 'is expected to raise with the errors' do
                expect { sut.upload(service_identifier: service_identifier) }.to raise_error(Regexp.new(error_msg))
              end
            end
          end

          it { is_expected.to respond_to :upload_all }

          describe '.upload_all' do
            before { sut.upload_all }

            let(:services) { %w[service-0 service-1] }

            it 'is expected to call CreateOrUpdate for each service' do
              expect(Datadog::ServiceCatalog::V2::CreateOrUpdate).to have_received(:call).exactly(services.count)
            end
          end

          def api_response_stub
            double(
              'api_response',
              success?: true,
              parsed_response: { 'data' => [] }
            )
          end
        end

        def datadog_params(service_identifier)
          {
            'schema-version' => V2::SCHEMA_VERSION,
            'dd-service' => service_identifier
          }
        end

        def content_instance_double(services, body)
          instance_double(FrontMatter::Content).tap do |double|
            allow(double).to receive(:services).and_return(services)
            allow(double).to receive(:body).and_return(body)
            allow(double).to receive(:filename).and_return('fakefilename.md')
          end
        end

        def content_klass_double(instance_double)
          class_double(FrontMatter::Content).tap do |double|
            allow(double).to receive(:new).and_return(instance_double)
          end
        end

        def validator_klass_double(instance_double)
          class_double(Validator).tap do |double|
            allow(double).to receive(:new).and_return(instance_double)
          end
        end
      end
    end
  end
end
