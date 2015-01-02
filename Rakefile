# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

Rails.application.load_tasks

desc 'Rebuild test and run specs'
task :full_test do
  system("rake db:drop db:migrate RAILS_ENV=test && rspec")
end

task :default => 'full_test'
