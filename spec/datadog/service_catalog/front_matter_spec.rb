# frozen_string_literal: true

module Datadog
  module ServiceCatalog
    RSpec.describe FrontMatter do
      it { is_expected.to be_const_defined(:Content) }
      it { is_expected.to be_const_defined(:Parser) }
    end
  end
end
