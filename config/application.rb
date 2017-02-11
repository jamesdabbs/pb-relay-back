require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Pbql
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.autoload_paths << Rails.root.join('app', 'graph')
    config.autoload_paths << Rails.root.join('app', 'graph', 'types')
    config.autoload_paths << Rails.root.join('app', 'services')

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: :any
      end
    end

    require Rails.root.join('app', 'services', 'container')
    config.container = Container.new
  end
end
