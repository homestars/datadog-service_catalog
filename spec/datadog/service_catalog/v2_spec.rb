# frozen_string_literal: true

module Datadog
  module ServiceCatalog
    RSpec.describe V2 do
      it { is_expected.to be_const_defined(:CreateOrUpdate) }
      it { is_expected.to be_const_defined(:ServiceDefinition) }
      it { is_expected.to be_const_defined(:Schema) }
      it { is_expected.to be_const_defined(:Validator) }
      it { is_expected.to be_const_defined(:SCHEMA_VERSION) }

      describe 'SCHEMA_VERSION' do
        subject { V2::SCHEMA_VERSION }

        it { is_expected.to eq 'v2' }
      end
    end
  end
end
