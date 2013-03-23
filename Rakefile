require "bundler/gem_tasks"
require 'rake/testtask'
require 'rake/clean'

NAME = 'multi_encoder'

file "lib/#{NAME}/gbarcode.bundle" =>
Dir.glob("ext/#{NAME}/*{.rb,.c}") do
  Dir.chdir("ext/#{NAME}") do
  ruby "extconf.rb"
  sh "make"
end
cp "ext/#{NAME}/gbarcode.bundle", "lib/#{NAME}"
end

# make the :test task depend on the shared
# object, so it will be built automatically
# before running the tests
task :test => "lib/#{NAME}/gbarcode.bundle"

# use 'rake clean' and 'rake clobber' to
# easily delete generated files
CLEAN.include('ext/**/*{.o,.log,.bundle}')
CLEAN.include('ext/**/Makefile')
CLOBBER.include('lib/**/*.bundle')

# the same as before
Rake::TestTask.new do |t|
  t.libs << 'test'
end

desc "Run tests"
task :default => :test
