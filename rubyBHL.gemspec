require File.expand_path('../lib/rubyBHL/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name = 'RubyBHL'
  gem.version = RubyBHL::VERSION #"0.1.0
  gem.authors = ["Matt Yoder"]
  gem.email = %q{diapriid@gmail.com}

  gem.description = %q{Hook to the Biodiversity Heritage Library API plus some screen scraping for OCR.}
  gem.summary = %q{Hook to the Biodiversity Heritage Library API plus some screen scraping for OCR.}
  gem.homepage = 'http://github.com/SpeciesFileGroup/rubyBHL'

  gem.license       = "University of Illinois/NCSA Open Source License (NCSA)"

  gem.required_rubygems_version = Gem::Requirement.new(">= 1.2") if gem.respond_to? :required_rubygems_version=

  gem.files         = `git ls-files`.split($/) # be sure to commit!
  gem.test_files =  gem.files.grep(%r{^(spec|features)/}) 
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'json', '~> 1.8'
  
  gem.add_development_dependency 'rake', '~> 10.1'
  gem.add_development_dependency 'bundler', '~> 1.3'
  gem.add_development_dependency 'rspec', '~> 2.14'
  gem.add_development_dependency 'debugger', '~> 1.6'
  gem.add_development_dependency 'git', '~> 1.2'

 #gem.date = %q{2009-10-19}
 #gem.extra_rdoc_files = ["README.rdoc", "lib/rubyBHL.rb"]
 #gem.rdoc_options = ["--line-numbers", "--inline-source", "--title", "rubyBHL", "--main", "README.rdoc"]
 #gem.rubyforge_project = %q{rubybhl}
 #gem.rubygems_version = %q{1.3.5}

 #if gem.respond_to? :specification_version then
 #  current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
 #  s.specification_version = 3

 #  if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
 #  else
 #  end
 #else
 #end
end
