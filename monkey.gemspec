lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'monkey/version'

Gem::Specification.new do |s|
  s.name = 'monkey'
  s.version = Monkey::VERSION
  s.date = '2011-09-29'
  s.summary = 'Ruby implementation of the Monkey programming language'
  s.files = Dir[File.join(__dir__, 'lib', '**', '*.rb')]
  s.require_paths = ['lib']
  s.authors = ['Steve Hobbs']
  s.email = 'elkdanger@gmail.com'
  s.bindir = ['bin']
  s.executables = ['monkey']

  s.add_development_dependency 'rspec', '~> 3.0'
end
