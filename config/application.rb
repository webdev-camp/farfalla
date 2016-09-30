require File.expand_path('../boot', __FILE__)

require 'rails/all'
require "susy"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

GC::Profiler.enable

module Farfalla
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.to_prepare do
      Dir.glob("app/**/*_decorator.rb").each do |c|
        load(c)
      end
    end
    def office_assets
      "farfalla_office"
    end

    config.cache_store = :memory_store, { size: 64.megabytes }

    config.active_record.raise_in_transactional_callbacks = true
    config.middleware.use Rack::Attack
    config.i18n.available_locales = :en
    config.i18n.default_locale = :en
  end
end
