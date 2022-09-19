# frozen_string_literal: true

require_relative 'rake_task'

module Datadog
  module ServiceCatalog
    module RakeTasks
      # RakeTasks::UploadAll - rake task for uploading Datadog ServiceDefinitions
      #
      class UploadAll < RakeTask
        def define_task
          namespace(nspace) do
            desc 'Upload the ServiceDefinition for each service identifier'
            task(upload_all: task_dependencies) do
              service_definition_klass.new.upload_all
            end
          end
        end
      end
    end
  end
end
