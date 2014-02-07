require File.expand_path('../lib/rubyBHL/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name = 'rubyBHL'
  gem.version = RubyBHL::VERSION #"0.1.0
  gem.authors = ["Matt Yoder"]
  gem.email = %q{diapriid@gmail.com}

  gem.description = %q{RubyBHL is a simple but flexible request/response wrapper for the Biodiversity Heritage Libary API.  It includes (some) validation for request formatting.  It has excellent unit-test coverage.}
  gem.summary = %q{RubyBHL is a simple request/response wrapper for the Biodiversity Heritage Libary API.}
  gem.homepage = 'http://github.com/SpeciesFileGroup/rubyBHL'
  gem.license = "University of Illinois/NCSA Open Source License (NCSA)"

  gem.files         = `git ls-files`.split($/) # be sure to commit!
  gem.test_files =  gem.files.grep(%r{^(spec|features)/}) 
  gem.require_paths = ["lib"]

  gem.required_ruby_version = '~> 2.0'

  gem.add_runtime_dependency 'json', '~> 1.8'
  gem.add_runtime_dependency 'dotenv'

  gem.add_development_dependency 'rake', '~> 10.1'
  gem.add_development_dependency 'bundler', '~> 1.3'
  gem.add_development_dependency 'rspec', '~> 2.14'
  gem.add_development_dependency 'debugger', '~> 1.6'
  gem.add_development_dependency 'git', '~> 1.2'
  gem.add_development_dependency 'dotenv'
  gem.add_development_dependency 'awesome_print', '~> 1.2'

end
