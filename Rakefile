require 'bundler'
Bundler::GemHelper.install_tasks

task :default => :test

desc 'Run rspec tests'
task :test do
  sh 'rspec spec/'
end
