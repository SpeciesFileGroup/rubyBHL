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

  gem.add_runtime_dependency 'json', '~> 2.2'
  gem.add_dependency 'dotenv', '~> 2.7'

  gem.add_development_dependency 'rake', '~> 12.3.2'
  gem.add_development_dependency 'bundler', '~> 2.0'
  gem.add_development_dependency 'rspec', '~> 3.8.0'
  gem.add_development_dependency 'byebug'
  gem.add_development_dependency 'git', '~> 1.5'
  gem.add_development_dependency 'awesome_print', '~> 1.2'

end
