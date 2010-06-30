require 'rake/testtask'
require 'erb'
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files =  FileList['test/test*.rb']
end

task :default => [:test]