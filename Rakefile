require 'rake/testtask'
require 'gemmer'

Gemmer::Tasks.new('scatter') do |t|
  t.release_via :rubygems
end

desc 'Default: run unit tests.'
task :default => [:"test:units", :"test:functionals"]

desc 'Test the scatter gem unit tests.'
Rake::TestTask.new(:"test:units") do |t|
  t.libs << 'src'
  t.pattern = 'test/unit/**/*_test.rb'
  t.verbose = true
end

desc 'Test the scatter gem functional tests.'
Rake::TestTask.new(:"test:functionals") do |t|
  t.libs << 'src'
  t.pattern = 'test/functional/**/*_test.rb'
  t.verbose = true
end
