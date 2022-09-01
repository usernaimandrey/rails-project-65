# frozen_string_literal: true

require_relative 'boot'

ENV['RANSACK_FORM_BUILDER'] = '::SimpleForm::FormBuilder'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

if %w[development test].include? ENV['RAILS_ENV']
  Dotenv::Railtie.load
end

GITHUB_CLIENT_ID = ENV.fetch('GITHUB_CLIENT_ID', nil)
GITHUB_CLIENT_SECRET = ENV.fetch('GITHUB_CLIENT_SECRET', nil)

module BulletinBoard
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.i18n.default_locale = :ru
    config.i18n.available_locales = %i[en ru]
  end
end
