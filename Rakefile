require 'foodcritic'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

task :default => [:foodcritic, :spec, :rubocop]

FoodCritic::Rake::LintTask.new

RSpec::Core::RakeTask.new

Rubocop::RakeTask.new

begin
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
rescue LoadError
  puts '>>>>> Kitchen gem not loaded, omitting tasks' unless ENV['CI']
end
