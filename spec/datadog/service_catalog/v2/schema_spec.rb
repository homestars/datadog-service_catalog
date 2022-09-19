# frozen_string_literal: true

module Datadog
  module ServiceCatalog
    module V2
      RSpec.describe Schema do
        subject(:sut) { described_class.new }

        describe 'class' do
          subject { described_class }

          it { is_expected.to be_const_defined(:V2_SCHEMA_PATH) }
        end

        it { is_expected.to respond_to :get }

        describe '.get' do
          before { allow(described_class).to receive(:get).and_return(stub_response) }

          let(:stub_response) do
            double('json_response', success?: success, empty?: false, body: '{}', response: stub_error_response)
          end

          let(:stub_error_response) { double('error_response') }

          context 'when successful' do
            before { sut.get }

            let(:success) { true }

            it 'sends a get request' do
              expect(described_class).to have_received(:get)
            end

            it 'with the correct path' do
              expect(described_class).to have_received(:get).with(Schema::V2_SCHEMA_PATH)
            end
          end

          context 'when NOT successful' do
            let(:success) { false }

            it 'raises the error' do
              allow(stub_error_response).to receive(:value).and_raise('blort')
              expect { sut.get }.to raise_error('blort')
            end
          end
        end
      end
    end
  end
end
