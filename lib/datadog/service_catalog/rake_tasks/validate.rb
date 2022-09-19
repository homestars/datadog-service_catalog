# frozen_string_literal: true

require_relative 'rake_task'

module Datadog
  module ServiceCatalog
    module RakeTasks
      # ServiceCatalog::Validate - rake task to validate Datadog ServiceDefinition
      #
      class Validate < RakeTask
        def define_task
          namespace(nspace) do
            desc 'Upload the ServiceDefinition for each service identifier'
            task(validate: task_dependencies) do
              unless service_definition.valid?
                puts formatted_error_msg
                abort('The ServiceDefinition was not valid')
              end
            end
          end
        end

        def service_definition
          @service_definition || service_definition_klass.new
        end

        def formatted_error_msg
          "The ServiceDefinition has the following errors: #{formatted_errors}"
        end

        def formatted_errors
          delim = "\n  * "
          "#{delim}#{service_definition.errors.join(delim)}"
        end
      end
    end
  end
end
