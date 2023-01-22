# frozen_string_literal: true

require 'rake'
require 'rake/tasklib'

module Datadog
  module ServiceCatalog
    module RakeTasks
      # RakeTasks::RakeTask - base rake task for Service Catalog tasks
      #
      class RakeTask < ::Rake::TaskLib
        attr_accessor :task_dependencies, :verbose

        def initialize(task_dependencies = [], service_definition_klass = V2::ServiceDefinition)
          super()
          @service_definition_klass = service_definition_klass
          @task_dependencies = task_dependencies
          @verbose = true

          yield self if block_given?

          desc 'Datadog ServiceCatalog tasks' unless ::Rake.application.last_description

          define_task
        end

        protected

        attr_reader :service_definition_klass

        def define_task
          raise NotImplementedError
        end
      end
    end
  end
end
