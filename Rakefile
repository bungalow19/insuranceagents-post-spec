require 'rake/testtask'
require 'erb'
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files =  FileList['test/test*.rb']
end

desc "Set up the built schema"
file 'build/schema.xsd' => FileList['*.erb'] do
  File.open('build/schema.xsd', 'w+').puts(ERB.new(File.read('schema.xsd.erb')).result(binding))
end


task :default => ['build/schema.xsd', :test]