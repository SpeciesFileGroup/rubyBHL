# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rubyBHL}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Yoder & Seltmann"]
  s.date = %q{2009-10-19}
  s.description = %q{Hook to the Biodiversity Heritage Library API plus some screen scraping for OCR.}
  s.email = %q{diapriid@gmail.com}
  s.extra_rdoc_files = ["README.rdoc", "lib/rubyBHL.rb"]
  s.files = ["Manifest", "README.rdoc", "Rakefile", "init.rb", "lib/rubyBHL.rb", "test/helper.rb", "test/rubyBHL_test.rb", "rubyBHL.gemspec"]
  s.homepage = %q{http://github.com/mjy/rubyBHL}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "rubyBHL", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{rubybhl}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Hook to the Biodiversity Heritage Library API plus some screen scraping for OCR.}
  s.test_files = ["test/rubyBHL_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
