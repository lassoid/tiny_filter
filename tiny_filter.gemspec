# frozen_string_literal: true

require_relative "lib/tiny_filter/version"

Gem::Specification.new do |spec|
  spec.name = "tiny_filter"
  spec.version = TinyFilter::VERSION
  spec.authors = ["Kirill Usanov", "LassoID"]
  spec.email = "kirill@lassoid.ru"

  spec.summary = "Tiny filtering for Rails."
  spec.description = "Simple filtering for ActiveRecord and enumerables."
  spec.homepage = "https://github.com/lassoid/tiny_filter"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/lassoid/tiny_filter"
  spec.metadata["changelog_uri"] = "https://github.com/lassoid/tiny_filter/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    %x(git ls-files -z).split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Dependencies
  spec.add_dependency "activesupport", ">= 6.0"
  spec.add_development_dependency "activerecord", ">= 6.0"
  spec.add_development_dependency "railties", ">= 6.0"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop-performance"
  spec.add_development_dependency "rubocop-rails"
  spec.add_development_dependency "rubocop-rake"
  spec.add_development_dependency "rubocop-rspec"
  spec.add_development_dependency "rubocop-shopify"
  spec.add_development_dependency "sqlite3"
end
