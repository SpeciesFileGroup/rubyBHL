
require File.expand_path('../lib/RubyBHL/version', __FILE__)


Gem::Specification.new do |gem|
  gem.name          = "dwc-archive"
  gem.version       = RubyBHL::VERSION
  gem.authors       = ["Dmitry Mozzherin"]
  gem.email         = ["dmozzherin at gmail dot com"]
  gem.description   = %q{Darwin Core Archive is the current standard exchange 
                          format for GLobal Names Architecture modules.  
                          This gem makes it easy to incorporate files in 
                          Darwin Core Archive format into a ruby project.}
  gem.summary       = %q{Handler of Darwin Core Archive files}
  gem.homepage      = "http://github.com/GlobalNamesArchitecture/dwc-archive"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'nokogiri', '~> 1.6'
  gem.add_runtime_dependency 'parsley-store', '~> 0.3'
  gem.add_runtime_dependency 'archive-tar-minitar', '~> 0.5'
  
  gem.add_development_dependency 'rake', '~> 10.1'
  gem.add_development_dependency 'bundler', '~> 1.3'
  gem.add_development_dependency 'rspec', '~> 2.14'
  gem.add_development_dependency 'cucumber', '~> 1.3'
  gem.add_development_dependency 'coveralls', '~> 0.7'
  gem.add_development_dependency 'debugger', '~> 1.6'
  gem.add_development_dependency 'git', '~> 1.2'
end



Gem::Specification.new do |gem|
  gem.name = %q{RubyBHL}
  gem.version = RubyBHL::VERSION # "0.1.0"
  gem.required_rubygems_version = Gem::Requirement.new(">= 1.2") if gem.respond_to? :required_rubygems_version=
  gem.authors = ["Matt Yoder"]
  gem.date = %q{2009-10-19}
  gem.description = %q{Once a bespoke single purpose gem to do some screen scraping for OCR this gem is now a more general purpose effort to provide a simple wrapper around the BHL API.}}
  gem.summary = %q{Hook to the Biodiversity Heritage Library API plus some screen scraping for OCR.}
 
  gem.email = %q{diapriid@gmail.com}
  # gem.extra_rdoc_files = ["README.rdoc", "lib/rubyBHL.rb"]

  # gem.files = ["Manifest", "README.rdoc", "Rakefile", "init.rb", "lib/rubyBHL.rb", "test/helper.rb", "test/rubyBHL_test.rb", "rubyBHL.gemspec"]
  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
 
  gem.homepage = %q{http://github.com/mjy/rubyBHL}
  gem.rdoc_options = ["--line-numbers", "--inline-source", "--title", "rubyBHL", "--main", "README.rdoc"]
  gem.require_paths = ["lib"]
  gem.rubyforge_project = %q{rubybhl}
  gem.rubygems_version = %q{1.3.5}
  
  
  # gem.test_files = ["test/rubyBHL_test.rb"]

 #if gem.respond_to? :specification_version then
 #  current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
 #  gem.specification_version = 3

 #  if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
 #  else
 #  end
 #else
 #end

  gem.add_runtime_dependency 'nokogiri', '~> 1.6'
  gem.add_runtime_dependency 'parsley-store', '~> 0.3'
  gem.add_runtime_dependency 'archive-tar-minitar', '~> 0.5'
  
  gem.add_development_dependency 'rake', '~> 10.1'
  gem.add_development_dependency 'bundler', '~> 1.3'
  gem.add_development_dependency 'rspec', '~> 2.14'
  gem.add_development_dependency 'cucumber', '~> 1.3'
  gem.add_development_dependency 'coveralls', '~> 0.7'
  gem.add_development_dependency 'debugger', '~> 1.6'
  gem.add_development_dependency 'git', '~> 1.2'


end
