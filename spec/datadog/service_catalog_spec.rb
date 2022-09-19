# frozen_string_literal: true

module Datadog
  RSpec.describe ServiceCatalog do
    it 'has a version number' do
      expect(Datadog::ServiceCatalog::VERSION).not_to be_nil
    end

    it { is_expected.to be_const_defined(:Auth) }
    it { is_expected.to be_const_defined(:Configuration) }
    it { is_expected.to be_const_defined(:FrontMatter) }
    it { is_expected.to be_const_defined(:V2) }
    it { is_expected.to be_const_defined(:RakeTasks) }

    it { is_expected.to respond_to :configure }
    it { is_expected.to respond_to :configuration }

    describe '#configuration' do
      subject(:configuration) { described_class.configuration }

      it { is_expected.to be_a ServiceCatalog::Configuration }

      specify { expect { |block| described_class.configure(&block) }.to yield_control }
      specify { expect { |block| described_class.configure(&block) }.to yield_with_args(configuration) }
    end
  end
end
