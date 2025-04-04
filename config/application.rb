require_relative "boot"

require 'dotenv/load'

require "rails/all"

Bundler.require(*Rails.groups)

module WebAssignment
  class Application < Rails::Application
    config.load_defaults 7.1
    config.autoload_lib(ignore: %w(assets tasks))
  end
end
