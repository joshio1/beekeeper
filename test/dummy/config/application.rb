require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)
require "beekeeper"

module Dummy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.autoload_paths += %W[
      #{config.root}/lib
      #{config.root}/schema
    ]

    config.eager_load_paths += %W[
      #{config.root}/lib
    ]

    Dir["./lib/middlewares/*.rb"].sort.each do |file|
      require file
    end

    Dir["./lib/*_error.rb"].sort.each do |file|
      require file
    end

    Dir["./lib/*_errors.rb"].sort.each do |file|
      require file
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

