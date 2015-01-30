require 'sinatra/activerecord/rake'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new :spec
  task default: :spec
rescue LoadError
end

namespace :db do
  task :load_config do
    require './app'
  end
end
