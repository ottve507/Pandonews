# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "make_voteable"
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kai Schlamp"]
  s.date = "2011-07-24"
  s.description = "A user-centric voting extension for Rails 3 applications."
  s.email = ["schlamp@gmx.de"]
  s.homepage = "http://github.com/medihack/make_voteable"
  s.require_paths = ["lib"]
  s.rubyforge_project = "make_voteable"
  s.rubygems_version = "1.8.25"
  s.summary = "Rails 3 voting extension"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, ["~> 3.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.5.0"])
      s.add_development_dependency(%q<database_cleaner>, ["= 0.6.7"])
      s.add_development_dependency(%q<sqlite3-ruby>, ["~> 1.3.0"])
      s.add_development_dependency(%q<generator_spec>, ["~> 0.8.2"])
    else
      s.add_dependency(%q<activerecord>, ["~> 3.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<rspec>, ["~> 2.5.0"])
      s.add_dependency(%q<database_cleaner>, ["= 0.6.7"])
      s.add_dependency(%q<sqlite3-ruby>, ["~> 1.3.0"])
      s.add_dependency(%q<generator_spec>, ["~> 0.8.2"])
    end
  else
    s.add_dependency(%q<activerecord>, ["~> 3.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<rspec>, ["~> 2.5.0"])
    s.add_dependency(%q<database_cleaner>, ["= 0.6.7"])
    s.add_dependency(%q<sqlite3-ruby>, ["~> 1.3.0"])
    s.add_dependency(%q<generator_spec>, ["~> 0.8.2"])
  end
end
