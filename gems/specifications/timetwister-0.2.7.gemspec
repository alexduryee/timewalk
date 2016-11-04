# -*- encoding: utf-8 -*-
# stub: timetwister 0.2.7 ruby lib

Gem::Specification.new do |s|
  s.name = "timetwister"
  s.version = "0.2.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Alex Duryee"]
  s.date = "2016-09-02"
  s.email = ["alexanderduryee@nypl.org"]
  s.executables = ["timetwister"]
  s.files = ["bin/timetwister"]
  s.homepage = "http://github.com/alexduryee/timetwister"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.8"
  s.summary = "Chronic wrapper to handle common date formats"

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.7"])
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
      s.add_runtime_dependency(%q<chronic>, ["~> 0.10.2"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.7"])
      s.add_dependency(%q<rake>, ["~> 10.0"])
      s.add_dependency(%q<chronic>, ["~> 0.10.2"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.7"])
    s.add_dependency(%q<rake>, ["~> 10.0"])
    s.add_dependency(%q<chronic>, ["~> 0.10.2"])
  end
end
