# -*- encoding: utf-8 -*-
# stub: omniauth-azure-activedirectory-v2 2.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "omniauth-azure-activedirectory-v2".freeze
  s.version = "2.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/RIPAGlobal/omniauth-azure-activedirectory-v2/issues/", "changelog_uri" => "https://github.com/RIPAGlobal/omniauth-azure-activedirectory-v2/blob/master/CHANGELOG.md", "homepage_uri" => "https://www.ripaglobal.com/", "source_code_uri" => "https://github.com/RIPAGlobal/omniauth-azure-activedirectory-v2" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["RIPA Global".freeze]
  s.bindir = "exe".freeze
  s.date = "2023-01-11"
  s.email = ["dev@ripaglobal.com".freeze]
  s.homepage = "https://github.com/RIPAGlobal/omniauth-azure-activedirectory-v2".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0".freeze)
  s.rubygems_version = "3.3.3".freeze
  s.summary = "OAuth 2 authentication with the Azure ActiveDirectory V2 API.".freeze

  s.installed_by_version = "3.3.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<omniauth-oauth2>.freeze, ["~> 1.8"])
  else
    s.add_dependency(%q<omniauth-oauth2>.freeze, ["~> 1.8"])
  end
end
