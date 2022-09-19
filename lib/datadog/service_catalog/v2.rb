# frozen_string_literal: true

require 'json'
require_relative 'v2/create_or_update'
require_relative 'v2/service_definition'
require_relative 'v2/schema'
require_relative 'v2/validator'

module Datadog
  module ServiceCatalog
    # ServiceCatalog::V2 - DataDog Service Catalog V2 API
    module V2
      SCHEMA_VERSION = 'v2'
    end
  end
end
