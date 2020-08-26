$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "beekeeper/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "beekeeper"
  spec.version     = Beekeeper::VERSION
  spec.authors     = [""]
  spec.authors     = ["Omkar Joshi"]
  spec.email       = ["omkar.joshi@anarock.com"]
  spec.homepage    = "https://github.com/saas-bn/beekeeper"
  spec.summary     = "Beekeeper: Error logging, processing and rendering."
  spec.description = "Beekeepeer: This gem is responsible for error logging, processing and rendering of errors in a standard JSON format.."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", ">= 5.1.4"
  spec.add_development_dependency "blueprinter", "~> 0.23.4"
  spec.add_development_dependency "oj", "~> 3.10.6"

  # spec.add_development_dependency "sqlite3"
end
