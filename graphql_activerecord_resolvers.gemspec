
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "graphql_activerecord_resolvers/version"

Gem::Specification.new do |spec|
  spec.name = "graphql_activerecord_resolvers"
  spec.version = GraphQLActiveRecordResolvers::VERSION
  spec.authors = ["Steven Petryk"]
  spec.email = ["petryk.steven@gmail.com"]

  spec.summary = %q{Write a short summary, because RubyGems requires one.}
  spec.description = %q{Write a longer description or delete this line.}
  spec.homepage = "TODO: Put your gem's website or public repo URL here."
  spec.license = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bullet", "~> 5.7"
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rubocop", "~> 0.52"
  spec.add_development_dependency "pry", "~> 0.11"

  spec.add_development_dependency "activerecord", "~> 5.1.5"
  spec.add_development_dependency "factory_bot", "~> 4.8"
  spec.add_development_dependency "graphql"
  spec.add_development_dependency "sqlite3"
end
