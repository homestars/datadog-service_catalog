# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new

RUBY_VERSIONS = '2.7, 3.0, 3.1'

desc 'Run guard and spec for each supported ruby'
task :spec_all do
  RUBY_VERSIONS.split(',').map(&:strip).each do |ruby_version|
    puts "----- #{ruby_version} -----"
    Bundler.with_unbundled_env do
      File.delete('Gemfile.lock')
      system("RBENV_VERSION=#{ruby_version} bundle install")
      abort unless system("RBENV_VERSION=#{ruby_version} bundle exec rake rubocop")
      abort unless system("RBENV_VERSION=#{ruby_version} bundle exec rake spec")
    end
  end
end

task default: %i[spec rubocop]
