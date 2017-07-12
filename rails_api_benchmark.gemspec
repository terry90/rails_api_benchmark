$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'rails_api_benchmark/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'rails_api_benchmark'
  s.version     = RailsApiBenchmark::VERSION
  s.authors     = ['Terry Raimondo']
  s.email       = ['terry.raimondo@gmail.com']
  s.homepage    = 'https://github.com/terry90/rails_api_benchmark'
  s.summary     = 'RailsApiBenchmark is a benchmark tool for your Rails API'
  s.description = 'Benchmark your API endpoints and get the results fast ! This gem leverages the power of ApacheBench, but can be configured with another benchmark tool'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.1.2'
  s.add_runtime_dependency 'mustache', '~> 1.0', '>= 0.99.4'
end
