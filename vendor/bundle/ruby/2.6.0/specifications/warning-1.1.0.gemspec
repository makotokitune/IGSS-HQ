# -*- encoding: utf-8 -*-
# stub: warning 1.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "warning".freeze
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/jeremyevans/ruby-warning/issues", "changelog_uri" => "https://github.com/jeremyevans/ruby-warning/blob/master/CHANGELOG", "documentation_uri" => "https://github.com/jeremyevans/ruby-warning/blob/master/README.rdoc", "source_code_uri" => "https://github.com/jeremyevans/ruby-warning" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jeremy Evans".freeze]
  s.date = "2020-06-12"
  s.description = "ruby-warning adds custom processing for warnings, including the\nability to ignore specific warning messages, ignore warnings\nin specific files/directories, include backtraces with warnings,\ntreat warnings as errors, deduplicate warnings, and add\ncustom handling for all warnings in specific files/directories.\n".freeze
  s.email = "code@jeremyevans.net".freeze
  s.extra_rdoc_files = ["README.rdoc".freeze, "CHANGELOG".freeze, "MIT-LICENSE".freeze]
  s.files = ["CHANGELOG".freeze, "MIT-LICENSE".freeze, "README.rdoc".freeze]
  s.homepage = "https://github.com/jeremyevans/ruby-warning".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--quiet".freeze, "--line-numbers".freeze, "--inline-source".freeze, "--title".freeze, "ruby-warning: Add custom processing for warnings".freeze, "--main".freeze, "README.rdoc".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.4.0".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Add custom processing for warnings".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<minitest-global_expectations>.freeze, [">= 0"])
    else
      s.add_dependency(%q<minitest-global_expectations>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<minitest-global_expectations>.freeze, [">= 0"])
  end
end
