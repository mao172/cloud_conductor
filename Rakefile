# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  nil
end

begin
  task routes: :environment do
    API::Root.routes.each do |api|
      method = api.route_method.ljust(10)
      path = api.route_path
      puts "     #{method} #{path}"
    end
  end
end

begin
  task api: :environment do
    API::Root.routes.each do |api|
      method = api.route_method
      path = api.route_path
      puts "### [#{method}] #{path}"
      puts ""
      puts "#### Parameters"
      api.instance_variable_get(:@options)[:params].to_a.each do |param|
        puts "- #{param[0]}: #{param[1]} "
      end
      puts ""
    end
  end
end
