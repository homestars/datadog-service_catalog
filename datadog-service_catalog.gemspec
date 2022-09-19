# frozen_string_literal: true

require_relative 'lib/datadog/service_catalog/version'

Gem::Specification.new do |spec|
  spec.name          = 'datadog-service_catalog'
  spec.version       = Datadog::ServiceCatalog::VERSION
  spec.authors       = ['Gerry Power']
  spec.email         = ['gerry.power@homestars.com']

  spec.summary       = 'Interact with the Datadog Service Catalog'
  spec.description   = 'See: https://docs.datadoghq.com/tracing/service_catalog/'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.4.0')

  spec.metadata['allowed_push_host'] = 'http://mygemserver.com'

  spec.metadata['source_code_uri'] = 'https://github.com/homestars/datadog-service_catalog'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'front_matter_parser'
  spec.add_dependency 'httparty'
  spec.add_dependency 'json_schemer'
  spec.add_dependency 'rake'

  spec.metadata['rubygems_mfa_required'] = 'true'
end
