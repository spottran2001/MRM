# -*- encoding: utf-8 -*-
# stub: activerecord-sqlserver-adapter 7.0.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "activerecord-sqlserver-adapter".freeze
  s.version = "7.0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/rails-sqlserver/activerecord-sqlserver-adapter/issues", "changelog_uri" => "https://github.com/rails-sqlserver/activerecord-sqlserver-adapter/blob/v7.0.3.0/CHANGELOG.md", "source_code_uri" => "https://github.com/rails-sqlserver/activerecord-sqlserver-adapter/tree/v7.0.3.0" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Ken Collins".freeze, "Anna Carey".freeze, "Will Bond".freeze, "Murray Steele".freeze, "Shawn Balestracci".freeze, "Joe Rafaniello".freeze, "Tom Ward".freeze]
  s.date = "2023-06-12"
  s.description = "ActiveRecord SQL Server Adapter. SQL Server 2012 and upward.".freeze
  s.email = ["ken@metaskills.net".freeze, "will@wbond.net".freeze]
  s.homepage = "http://github.com/rails-sqlserver/activerecord-sqlserver-adapter".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.7.0".freeze)
  s.rubygems_version = "3.3.3".freeze
  s.summary = "ActiveRecord SQL Server Adapter.".freeze

  s.installed_by_version = "3.3.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<activerecord>.freeze, ["~> 7.0.0"])
    s.add_runtime_dependency(%q<tiny_tds>.freeze, [">= 0"])
  else
    s.add_dependency(%q<activerecord>.freeze, ["~> 7.0.0"])
    s.add_dependency(%q<tiny_tds>.freeze, [">= 0"])
  end
end
