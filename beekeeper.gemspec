$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "beekeeper/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "beekeeper"
  spec.version     = Beekeeper::VERSION
  spec.authors     = ["Omkar Joshi"]
  spec.email       = ["onjoshi@ncsu.edu"]
  spec.homepage    = "https://github.com/joshio1/beekeeper"
  spec.summary     = "Beekeeper: Error logging, processing and rendering via Rack middleware."
  spec.description = "Beekeepeer: This gem is responsible for error logging, processing and rendering of errors in a standard JSON format.."
  spec.license     = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", ">= 5.1.4"
  spec.add_dependency "blueprinter"
  spec.add_dependency "oj"
  spec.add_dependency "apipie-rails"

  spec.add_development_dependency "sqlite3"
end
