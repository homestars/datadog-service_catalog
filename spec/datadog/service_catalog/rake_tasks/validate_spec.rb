# frozen_string_literal: true

require 'datadog/service_catalog/rake_tasks'

module Datadog
  module ServiceCatalog
    module RakeTasks
      RSpec.describe Validate do
        before do
          Rake::Task.clear

          Datadog::ServiceCatalog.configure do |config|
            config.markdown_file = 'docs/sample_frontmatter.md'
          end

          described_class.new
        end

        after { Rake::Task.clear }

        describe 'defining tasks' do
          it 'creates an validate task' do
            expect(Rake::Task.task_defined?('service_catalog:validate')).to be true
          end
        end

        describe 'running upload_all' do
          before do
            described_class.new(:service_catalog, [], service_definition_klass)
            Rake::Task['service_catalog:validate'].execute
          end

          let(:service_definition_klass) { service_definition_klass_double(service_definition_instance_double) }
          let(:service_definition_instance_double) { instance_double(V2::ServiceDefinition, valid?: true) }

          it 'calls ServiceDefinition upload_all' do
            expect(service_definition_instance_double).to have_received(:valid?)
          end
        end

        def service_definition_klass_double(instance_double)
          class_double(V2::ServiceDefinition).tap do |double|
            allow(double).to receive(:new).and_return(instance_double)
          end
        end
      end
    end
  end
end
