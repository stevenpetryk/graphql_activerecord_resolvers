lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "graphql_activerecord_resolvers/version"

Gem::Specification.new do |spec|
  spec.name = "graphql_activerecord_resolvers"
  spec.version = GraphQLActiveRecordResolvers::VERSION
  spec.authors = ["Steven Petryk"]
  spec.email = ["petryk.steven@gmail.com"]

  spec.summary = %q{GraphQL on Rails, without the N+1's.}
  spec.homepage = "https://github.com/stevenpetryk/graphql_activerecord_resolvers"
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

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rubocop", "~> 0.52"
  spec.add_development_dependency "pry", "~> 0.11"

  spec.add_development_dependency "activerecord", "~> 5.1"
  spec.add_development_dependency "graphql", "~> 1.7"
end
